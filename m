Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030604AbWJKOyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbWJKOyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWJKOyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:54:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4234 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030583AbWJKOyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:54:45 -0400
Date: Wed, 11 Oct 2006 15:54:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
Message-ID: <20061011145441.GB29920@ftp.linux.org.uk>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk> <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 01:16:56PM +0200, Jan Engelhardt wrote:
> 
> >diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
> >index ddc0681..b30372f 100644
> >--- a/drivers/sbus/char/uctrl.c
> >+++ b/drivers/sbus/char/uctrl.c
> >@@ -400,7 +400,7 @@ static int __init ts102_uctrl_init(void)
> > 	}
> > 
> > 	driver->regs->uctrl_intr = UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK;
> >-	printk("uctrl: 0x%x (irq %d)\n", driver->regs, driver->irq);
> >+	printk("uctrl: 0x%p (irq %d)\n", driver->regs, driver->irq);
> 
> So what's the difference, except that %p will evaluate to (nil) or 
> (null) when the argument is 0 [this is the case with glibc]?
> That would print 0x(nil).

%p will do no such thing in the kernel.  As for the difference...  %x
might happen to work on some architectures (where sizeof(void *)==sizeof(int)),
but it's not portable _and_ not right.  %p is proper C for that...
