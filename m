Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVCNBvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVCNBvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 20:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCNBvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 20:51:08 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:29578 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261624AbVCNBvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 20:51:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oN8QmBMF+kbzyP7hrWpMhYYGLAe2ZebgRluOZY59BgbRu1yYzBsJ5ebk9vY2DVkjD6n+FxAnbga9TMuFFvsOo/we7f1M2bIL9Mdn5whgDLiBsq3SOHwDLyAT2RUA0ssCZyr5P4MYuhLZzZSTD5+xih8bAXsZoIGpuTCrEabgCLM=
Message-ID: <9e4733910503131724830d5b9@mail.gmail.com>
Date: Sun, 13 Mar 2005 20:24:18 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <16948.56612.119258.653782@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <20050311102920.GB30252@elf.ucw.cz>
	 <9e473391050312082777a02001@mail.gmail.com>
	 <16948.56612.119258.653782@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 11:39:00 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:
> >>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
> 
> Jon> On Fri, 11 Mar 2005 11:29:20 +0100, Pavel Machek <pavel@ucw.cz>
> Jon> wrote:
> >> Hi!
> >>
> >> > As many of you will be aware, we've been working on
> >> infrastructure for > user-mode PCI and other drivers.  The first
> >> step is to be able to > handle interrupts from user
> >> space. Subsequent patches add > infrastructure for setting up DMA
> >> for PCI devices.
> >> >
> >> > The user-level interrupt code doesn't depend on the other
> >> patches, and > is probably the most mature of this patchset.
> >>
> >> Okay, I like it; it means way easier PCI driver development.
> 
> Jon> It won't help with PCI driver development. I tried implementing
> Jon> this for UML. If your driver has any bugs it won't get the
> Jon> interrupts acknowledged correctly and you'll end up rebooting.
> 
> That's not actually true, at least when we developed drivers here.
> The only times we had to reboot were the times we mucked up the dma
> register settings, and dma'd all over the kernel by mistake...

The way you can avoid reboot is to leave the interrupt turned off at
the PIC. The side effect is that everything else using that interrupt
is also turned off.

I did experiment with catching the process exit from the user space
app on abort. Then I used the power control registers to turn off the
card if it supported being turned off. That would then safely let me
reenable the pick.

This code needs to refuse to attach to a shared IRQ until problems
with them are fixed. Most IRQs are shared on x86 desktops. Every
machine I have around here has no free IRQ's available.


> 
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
> 


-- 
Jon Smirl
jonsmirl@gmail.com
