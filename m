Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBRAih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBRAih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVBRAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:38:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:64190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261250AbVBRAif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:38:35 -0500
Date: Thu, 17 Feb 2005 16:38:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
In-Reply-To: <4214450B.6090006@triplehelix.org>
Message-ID: <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
References: <4214450B.6090006@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Feb 2005, Joshua Kwan wrote:
> 
> Just migrated to 2.6.10 on an old VIA MVP3 box and I'm getting this:
> 
> irq 12: nobody cared!

IRQ 12 should be your PS/2 mouse irq too. It seems your wireless card 
shares that interrupt, which is unusual, but not necessarily wrong.

My guess is that the wireless card - or the mouse controller - has that
interrupt pending even before the driver gets to initialize, and depending
on just which one loads first, it will be unhappy - because it will see an
interrupt that it isn't able to handle, and that thus just isn't going
away..

Does the box still work? It may well be that once all drivers have had a 
chance to initialize their hardware properly, the problem is just gone, 
and that the interim reports about not being able to handle the irq are 
just temporary noise.

Of course, even if it works, the noise _is_ actually indicative of a
problem. There shouldn't be any pending interrupts, especially not
level-triggered ones. And it can cause a non-working mouse if you don't
load the driver for the wireless card (or vice versa).

What was the previous kernel you ran on that machine, just out of 
interest? If it hasn't happened before, it would be interesting to know 
when it started happening...

		Linus
