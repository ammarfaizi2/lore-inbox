Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269752AbRHMCqy>; Sun, 12 Aug 2001 22:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269748AbRHMCqo>; Sun, 12 Aug 2001 22:46:44 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:11784 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S269752AbRHMCqd>; Sun, 12 Aug 2001 22:46:33 -0400
Date: Mon, 13 Aug 2001 02:46:40 +0000 (GMT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: f.duncan.m.haldane@worldnet.att.net
cc: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: Re: PCI spec question/possible VIA quirk?
In-Reply-To: <XFMail.20010812205406.f.duncan.m.haldane@worldnet.att.net>
Message-ID: <Pine.LNX.4.10.10108130227420.7720-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone tell me what the PCI specs say config registers 0x2c:0x2f 
> should contain? 

via's kt133a spec says 0x2c-2d is "subsystem vendor ID"
defaults to zero, and 0x2d-2f is "subsystem ID" (also def zero).
these are RW, so the bios could put something cute in them, I guess.

ah, yes the vid 0x1043 from your example is AsusTek.  
on my (Asus) A7V133, those bytes are zero.

> In drivers/pci/pci.c (all 2.4.x kernels) pci_read_bridge_bases() 
> is reading "mem_limit_hi" from them.  
> (PCI_PREF_LIMIT_UPPER32 = 0x2c in pci.h) 

again, the kt133a spec says "prefetchable memory base" should
be at register 0x24-25, and "prefetchable memory limit" at 0x26-27.

I'm guessing pci.h should have:

#define PCI_PREF_BASE_UPPER32   0x28    /* Upper half of prefetchable memory range */
- #define PCI_PREF_LIMIT_UPPER32  0x2c
+ #define PCI_PREF_LIMIT_UPPER32  0x2a

(pardon the manual pseudopatch)

