Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSHDTF3>; Sun, 4 Aug 2002 15:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318220AbSHDTF3>; Sun, 4 Aug 2002 15:05:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40441 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318219AbSHDTF2>; Sun, 4 Aug 2002 15:05:28 -0400
Subject: Re: Linux 2.4.19-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Devilkin <Devilkin-LKML@blindguardian.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200208042057.57130.Devilkin-LKML@blindguardian.org>
References: <200208041746.g74Hkgr24437@devserv.devel.redhat.com> 
	<200208042057.57130.Devilkin-LKML@blindguardian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 21:27:19 +0100
Message-Id: <1028492839.15200.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 19:57, Devilkin wrote:
> On Sunday 04 August 2002 19:46, Alan Cox wrote:
> <snip>
> 
> There seems to be some problem with VIA IDE IRQ's on 2.4.19-ac2.

Ok based on Petr's comments about VIA stuff being a bit funny. We can
refine this test later.

--- arch/i386/kernel/pci-i386.c~	2002-08-04 20:06:54.000000000 +0100
+++ arch/i386/kernel/pci-i386.c	2002-08-04 20:06:54.000000000 +0100
@@ -277,6 +277,11 @@
 	if((r9 & 0x0A) != 0x0A)		/* Legacy only */
 		return 0;
 		
+	/* Leave alone VIA chips */
+	
+	if (dev->vendor == PCI_VENDOR_ID_VIA)
+		return 0;
+		
 	/* Request programmability */
 	
 	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);
