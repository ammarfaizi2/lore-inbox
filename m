Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVAaItd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVAaItd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAaItd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:49:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:51378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261566AbVAaItW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:49:22 -0500
Date: Mon, 31 Jan 2005 00:48:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk+lkml@arm.linux.org.uk, e9925248@student.tuwien.ac.at,
       linux-kernel@vger.kernel.org
Subject: Re: Deadlock in serial driver 2.6.x
Message-Id: <20050131004857.07f5e2c4.akpm@osdl.org>
In-Reply-To: <1107157019.14847.64.camel@localhost.localdomain>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
	<20050126231329.440fbcd8.akpm@osdl.org>
	<1106844084.14782.45.camel@localhost.localdomain>
	<20050130164840.D25000@flint.arm.linux.org.uk>
	<1107157019.14847.64.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Sul, 2005-01-30 at 16:48, Russell King wrote:
>  > Unsolvable as the tty layer currently stands.  tty needs to not call back
>  > into serial drivers when they supply read characters from their interrupt
>  > functions.
> 
>  The tty layer cannot fix this for now, and I don't intend to fix it. Fix
>  the serial driver: the fix is quite simple since you can keep a field in
>  the driver for now to detect recursive calling into the echo case and
>  don't relock.

Are we sure that the serial driver is the only one which will hit this
deadlock?
