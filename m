Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315217AbSDWOFk>; Tue, 23 Apr 2002 10:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315220AbSDWOFk>; Tue, 23 Apr 2002 10:05:40 -0400
Received: from jalon.able.es ([212.97.163.2]:63167 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315217AbSDWOFi>;
	Tue, 23 Apr 2002 10:05:38 -0400
Date: Tue, 23 Apr 2002 16:05:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam5
Message-ID: <20020423140531.GC2048@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10204222302220.32212-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.23 Andre Hedrick wrote:
>
>bottom of ide-pci.c
>
>there is a failed test to isolate multi-function chips which carry a real
>host inside.
>
>ide_scan_pcidev()
>
>else if (d->order_fix)
>	d->order_fix(dev, d);
>--
>--
>--
>
>delete the three lines after d->order_fix(dev, d);
>

Planning to include a 41-ide-6-promise-fix.gz in -pre7-jam6 with:

--- linux/drivers/ide/ide-pci.c.org	2002-04-23 15:57:13.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-04-23 15:57:57.000000000 +0200
@@ -918,9 +918,11 @@
 			"(uses own driver)\n", d->name);
 	else if (d->order_fix)
 		d->order_fix(dev, d);
+#if 0
 	else if (((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) &&
 		 (!(PCI_FUNC(dev->devfn) & 1)))
 		return;
+#endif
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A) &&
 		 (!(PCI_FUNC(dev->devfn) & 1)))
 		return;	/* UM8886A/BF pair */

so text stays there for reference....

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam5 #1 SMP mar abr 23 01:29:38 CEST 2002 i686
