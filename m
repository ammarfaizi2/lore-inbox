Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUJBUAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUJBUAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUJBUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:00:14 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61845 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267526AbUJBUAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:00:10 -0400
Subject: Re: [2.6.9-rc3-bk1] Sleeping function called from invalid context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Marcel Sebek <sebek64@post.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410021201340.2301@ppc970.osdl.org>
References: <20041001203505.GA4480@penguin.localdomain>
	 <20041001205658.7c2b8ecf.akpm@osdl.org>
	 <Pine.LNX.4.58.0410021201340.2301@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096743455.25292.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 19:57:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-02 at 20:08, Linus Torvalds wrote:
> We might be able to change it to a per-tty semaphore instead, which sounds 
> reasonably safe, but in the meantime I don't think we have any other 
> choice than to just leave the driver/ldisc routines unprotected. They 
> should be just reading the state, after all.

Yep - already discussed on the linux-kernel and linux-usb lists. You can
do it with a semaphore. Its currently in testing. The USB drivers need
to sleep in order to handle the fact that their change is an
asynchronous message.

We do actually have to lock it or some drivers crash when you do the
fork 100 processes and all keep doing termios stuff attack.

Will send you a patch once its finished the test runs

Alan

