Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTBPD0a>; Sat, 15 Feb 2003 22:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTBPD0a>; Sat, 15 Feb 2003 22:26:30 -0500
Received: from [24.206.178.254] ([24.206.178.254]:16515 "EHLO
	mail.brianandsara.net") by vger.kernel.org with ESMTP
	id <S265736AbTBPD03>; Sat, 15 Feb 2003 22:26:29 -0500
From: Brian Jackson <brian@mdrx.com>
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       brian@brianandsara.net
Subject: 2.5 AGP for 2.4.21-pre4
Date: Sat, 15 Feb 2003 21:35:22 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302152135.22425.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a poor attempt at a backport of the 2.5.61 AGP subsystem by someone 
who doesn't know what he is doing and is in way over his head. That said, are 
there any "brave" souls out there that want to try this out with an AGP3 card 
and 2.4.21pre4. I compile/boot tested it with an old ati card, but I don't 
have an AGP 3.0 card/MB to test it on. I got into X and ran glxgears using 
this kernel(I am using it to finish writing this email)

http://www.mdrx.com/brian/2.4.21-pre4-2.5agp.diff.gz

caveats:
agp has to be built in to the kernel (no modules)

I did the following:
copied the drivers/char/agp directory from 2.5.61
copied include/asm-*/agp.h from 2.5.61
copied include/linux/*agp.h from 2.5.61
made some changes to drivers/char/agp/Makefile
on line 619&635 of frontend.c changed remap_page_range to only have 4
	arguments
line 705 generic.c changed SetPageLocked -->SetPageReserved
	(not sure if this is right, but Locked doesn't exist in 2.4 and I thought
	Reserved might work -- Let me know if this should be something else)
backend.c:241 & backend.c:263 commented references to 2.5 module stuff
	(therefore this only safe to be built into the kernel for now, any ideas what
	I should use here instead?)
added some device id's to drivers/char/agp/agp.h from
	2.5.61/include/linux/pci_ids.h
uninclude gfp.h & linux/page-flags.h from amd-k7-agp.c

What else I need to do:
change to old style module init stuff

This is nowhere near suitable for production use, but I would like some people 
that actually have AGP3 cards/MB's to try this out

--Brian Jackson

P.S. All criticism is welcome even flaming since I am in a decent mood right 
now

P.S.S. To Dave Jones -- I thought 2.5 had support for VIA chipsets & AGP3, but 
I only saw config options for the 7205/7505

