Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVCLQ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVCLQ2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVCLQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:28:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:19884 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261949AbVCLQ23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:28:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Pv3VqMPPOT3Y7oERMWm53BOpyOUj1D3/B+2OeBL9Ma0yiCUHmSh8gO7iTHb+vHxas8MjIrPKmxMtTxjuoZ63JbNUzDkHYrJDt96BocaHOVKgSBuDk3daJf0eqQK+wyF/zhy7yutlLdMP6tMrSUIHQueK/d6Gq4ogOXoP3E4M0jI=
Message-ID: <9e473391050312082777a02001@mail.gmail.com>
Date: Sat, 12 Mar 2005 11:27:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20050311102920.GB30252@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <20050311102920.GB30252@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 11:29:20 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > As many of you will be aware, we've been working on infrastructure for
> > user-mode PCI and other drivers.  The first step is to be able to
> > handle interrupts from user space. Subsequent patches add
> > infrastructure for setting up DMA for PCI devices.
> >
> > The user-level interrupt code doesn't depend on the other patches, and
> > is probably the most mature of this patchset.
> 
> Okay, I like it; it means way easier PCI driver development.

It won't help with PCI driver development. I tried implementing this
for UML. If your driver has any bugs it won't get the interrupts
acknowledged correctly and you'll end up rebooting.

Xen just posted patches for using kgdb between two instances but I
don't see how they get out of the interrupt acknowledge problem
either.

> 
> But... how do you handle shared PCI interrupts?
> 
> > This patch adds a new file to /proc/irq/<nnn>/ called irq.  Suitably
> > privileged processes can open this file.  Reading the file returns the
> > number of interrupts (if any) that have occurred since the last read.
> > If the file is opened in blocking mode, reading it blocks until
> > an interrupt occurs.  poll(2) and select(2) work as one would expect, to
> > allow interrupts to be one of many events to wait for.
> > (If you didn't like the file, one could have a special system call to
> > return the file descriptor).
> 
> This should go into Documentation/ somewhere.
>                                                                 Pavel
> 
> --
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
