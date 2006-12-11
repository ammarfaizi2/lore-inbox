Return-Path: <linux-kernel-owner+w=401wt.eu-S1762951AbWLKRHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762951AbWLKRHm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762949AbWLKRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:07:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53418 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762951AbWLKRHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:07:41 -0500
Date: Mon, 11 Dec 2006 17:15:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <cminyard@mvista.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Message-ID: <20061211171521.777eeff8@localhost.localdomain>
In-Reply-To: <457D876B.9000508@mvista.com>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<457D70A4.1000000@mvista.com>
	<20061211151943.2bbc720e@localhost.localdomain>
	<457D876B.9000508@mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was actually wrong, flush_to_ldisc does handle reentrancy.
> It can only have one caller to disc->receive_buf() at a time.  So
> long chains of recursion don't seem to be possible, even if called
> from IRQ context.

disc->receive_buf is single threaded but if it then sends characters back
in the same context (eg flow control) you get re-entry in the driver.

> And studying the way ppp does writing, it can bypass the tty_write()
> call and directly call the drivers.  So that bypasses the transmit
> locking problems I saw.

tty_write() is the layer above the ldisc. tty_write() feeds a line
discipline from (usually) user space. Line disciplines write direct to
the tty.

> 
> This is going to require some more thought.  But I believe it can be
> done with adding a poll routine to the tty_operations structure 

What status do you need to poll ?
