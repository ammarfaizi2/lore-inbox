Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRKVW1b>; Thu, 22 Nov 2001 17:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281807AbRKVW1M>; Thu, 22 Nov 2001 17:27:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281806AbRKVW1C>; Thu, 22 Nov 2001 17:27:02 -0500
Date: Thu, 22 Nov 2001 14:21:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Leif Sawyer <lsawyer@gci.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <leif@denali.net>
Subject: RE: Linux-2.4.15-pre9
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506DB3B73@berkeley.gci.com>
Message-ID: <Pine.LNX.4.33.0111221417001.1006-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Leif Sawyer wrote:
>
> adding the 'pci=biosirq' to my kernel boot command line causes an oops:

Well, you seem to have a buggered BIOS - the oops is actually in the BIOS
segment, and the BIOS appears to try to re-load the ES segment register
with some strange non-existing segment.

Your BIOS PCI irq routing routines probably only work in real-mode or
something like that.

This is the reason Linux avoids BIOS calls like the plague, and why you
have to ask for them explicitly - the likelihood of any random BIOS being
broken is actually rather high. That's probably because

 - the BIOS is written mostly in assembly
 - the BIOS is tested exclusively with DOS and Windows
 - most BIOS writers appear to simply be incompetent, or just not care.

Not a good combination, in short.

I'd love to just remove the support for BIOS calls entirely, but for every
ten broken machines there is one machine that actually works, so..

		Linus

