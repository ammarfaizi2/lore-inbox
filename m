Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318172AbSGWTFJ>; Tue, 23 Jul 2002 15:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSGWTFI>; Tue, 23 Jul 2002 15:05:08 -0400
Received: from ares.sdinet.de ([195.21.215.20]:9998 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S318172AbSGWTFG>;
	Tue, 23 Jul 2002 15:05:06 -0400
Date: Tue, 23 Jul 2002 21:08:26 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: George France <france@handhelds.org>
Cc: Martin Brulisauer <martin@uceb.org>, <linux-kernel@vger.kernel.org>,
       Jay Estabrook <Jay.Estabrook@hp.com>
Subject: Re: kbuild 2.5.26 - arch/alpha
In-Reply-To: <02072315005002.31958@shadowfax.middleearth>
Message-ID: <Pine.LNX.4.44.0207232103120.16191-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, George France wrote:

> On Tuesday 23 July 2002 13:01, Martin Brulisauer wrote:
> > Hopefully I can fix core_cia.c to run on XLT's (it's hard to find any
> > documentation on this toppic) and arch/alpha/kernel/setup.c for
> > machines booting with linload.exe/MILO because the hwrpb
> > struct is built by MILO and does not match the one booting from
> > SRM (eg. empty percpu struct resulting in a cpucount of zero
> > in /proc/cpuinfo).
>
> I am not very familiar with the XLT systems. Maybe Jay can help.  He has been
> working on Alpha systems for a very long time.

I am using Stock 2.4.19-rc2 with the following simple patch on an xl-300
with milo:
(without it, it breaks while initalizing the ncr-scsi-controller)

--- linux/arch/alpha/kernel/core_cia.c.orig	Sun Oct 21 19:30:58 2001
+++ linux/arch/alpha/kernel/core_cia.c	Fri Jul 19 16:11:46 2002
@@ -382,10 +382,10 @@
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;

-	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
-	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
+	*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
 				    & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
 }

 static void __init


I've got the patch from Alexander Stokman, who was kind to send it to me
~3 month after sending my question to lkml


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

