Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSK1J2o>; Thu, 28 Nov 2002 04:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSK1J2o>; Thu, 28 Nov 2002 04:28:44 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:35834 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S265336AbSK1J2o>; Thu, 28 Nov 2002 04:28:44 -0500
Date: Thu, 28 Nov 2002 10:35:50 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Pawel Bernadowski <pbern@wilnet.info>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: error in quirks.c
Message-ID: <20021128093549.GC20066@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <Pine.LNX.4.50L.0211280826070.24209-100000@farma.wilnet.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0211280826070.24209-100000@farma.wilnet.info>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 08:27:09AM +0100, Pawel Bernadowski wrote:
> I use 2.5.50 and always get this error
>   gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
> -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=quirks -DKBUILD_MODNAME=quirks   -c -o 
> drivers/pci/quirks.o drivers/pci/quirks.c
> drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
> drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this 

You have IO-APIC enabled.
Alan posted a similar patch somewhere before, just in case here is the fix
for quirks.c:


--- 2.5.50+bk/drivers/pci/quirks.c	2002-11-26 06:03:51.000000000 +0100
+++ 2.5.50/drivers/pci/quirks.c	2002-11-28 10:29:37.000000000 +0100
@@ -350,6 +350,7 @@
 
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
+	extern int sis_apic_bug;
 	if (dev->devfn == 0 && dev->bus->number == 0)
 		sis_apic_bug = 1;
 }
