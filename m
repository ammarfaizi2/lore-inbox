Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVAXQt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVAXQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVAXQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:49:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46742 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261531AbVAXQtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:49:40 -0500
Subject: Re: kernel oops!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, ierdnah <ierdnah@go.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050123161512.149cc9de.vsu@altlinux.ru>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <20050123161512.149cc9de.vsu@altlinux.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106509496.6148.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 15:44:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-23 at 13:15, Sergey Vlasov wrote:
> On Sat, 22 Jan 2005 22:43:50 -0800 (PST) Linus Torvalds wrote:
> tty_poll() grabs ldisc reference for the tty it was called with;
> however, in this case pty_chars_in_buffer() accesses another ldisc
> (tty->link->ldisc) without grabbing a reference to it.  BTW, many other
> pty_* functions do the same thing.

Correct - the pty code still relies on all sorts of "lock_kernel"
assumptions so its probably very very racy. It can't however easily use
tty_ldisc_()
functions that wait because the lock ordering is indeterminate. 


