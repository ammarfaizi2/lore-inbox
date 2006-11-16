Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424237AbWKPQFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424237AbWKPQFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424236AbWKPQFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:05:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424237AbWKPQFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:05:47 -0500
Date: Thu, 16 Nov 2006 08:05:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <20061116042432.26300.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0611160757490.3349@woody.osdl.org>
References: <20061116042432.26300.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, linux@horizon.com wrote:
>
> Er... why can't you test it?

Because if it is level-triggered kind of thing and comes in on the wrong 
IRQ, and that IRQ is already used by something else, you're basically 
dead.

IRQ probing is essentially unworkable. We support it for ISA cards (and 
"ISA" here tends to mean PCMCIA - there are almost no other ISA forms 
left), but it just doesn't work very well.

> Well, before giving up entirely, assume that *some* device owns that
> interrupt, it's just mis-routed.
> 
> So start calling the IRQ handlers for *every* PCI device until the
> damn interrupt goes away, or you've really proved that it can't
> be shut up.

Sure, you can add crap upon crap upon crap for these things. I pretty much 
guarantee you that it's not going to work, though. Why? Because developers 
won't even be working on those machines that have irq routing problems, so 
they won't be testing things that way, and because if you have irq routing 
problems, your problems are so fundamental that it really isn't worth it 
any more.

We've added basic _debugging_ facilities (the whole "nobody cared" thing 
is really a debugging thing, not a "make it work" thing). That was big, 
because it used to be that a screaming interrupt just locked up the whole 
machine - notably you inserted a PCMCIA card, and the machine would just 
lock up (sometimes it would come back when you removed the card again).

Trying to work around it is basically not worthwhile. You need to fix the 
problem. Interrupts are very fundamental, you don't want to be guessing 
about them. If they are wrong, you're screwed.

		Linus
