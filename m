Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTILJlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTILJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:41:51 -0400
Received: from [212.184.2.221] ([212.184.2.221]:14329 "EHLO
	akde1101.de.kaercher.com") by vger.kernel.org with ESMTP
	id S261533AbTILJls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:41:48 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 11:41:45 +0200
User-Agent: KMail/1.5.3
References: <200309091406.56334.ronny-lkml@vlugnet.org> <20030911123418.GA6798@l-t.ee>
In-Reply-To: <20030911123418.GA6798@l-t.ee>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Marko Kreen <marko@l-t.ee>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309121141.45776.ronny-lkml@vlugnet.org>
X-OriginalArrivalTime: 12 Sep 2003 09:41:46.0055 (UTC) FILETIME=[14B90D70:01C37912]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag 11 September 2003 14:34 schrieb Marko Kreen:
> On Tue, Sep 09, 2003 at 02:06:56PM +0200, Ronny Buchmann wrote:
> > I have the same motherboard but a different problem with the hpt chip,
> > only the first channel is recognized. (see
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=97824)
>
> I saw something like that too - when disk was in second channel,
> it did not crash because it did not detect anything.
>
> > part from dmesg (klogd) output
> > ---
> > Sep  7 23:50:17 bserv kernel: HPT366: IDE controller at PCI slot 02:00.0
> > Sep  7 23:50:17 bserv kernel: HPT366: chipset revision 6
> > Sep  7 23:50:17 bserv kernel: HPT366: not 100%% native mode: will probe
> > irqs later
> > Sep  7 23:50:17 bserv kernel: hpt: HPT372N detected, using 372N timing.
> > Sep  7 23:50:17 bserv kernel: FREQ: 82 PLL: 35
>
> "FREQ: 82" is pretty high as the limit is 85.
It would be interesting to know what the average or ideal value is.

> I replaced "< 0x55" with "<= 0x55" in hpt366.c and the driver
> did not crash, but it also did not detect cdrom - only thing
> behind it ATM - so I did not bother messing with it further.
I will test with cdrom attached later today.
Currently I have one disk on each channel.

I had another look at hpt.c(from highpoint) and hpt366.c and found this:
--- linux-2.4.22-ac1/drivers/ide/pci/hpt366.c.orig	2003-09-11 
21:29:06.000000000 +0200
+++ linux-2.4.22-ac1/drivers/ide/pci/hpt366.c	2003-09-12 01:05:44.000000000 
+0200
@@ -713,7 +713,7 @@
 	
 	/* Reconnect channels to bus */
 	outb(0x00, hwif->dma_base+0x73);
-	outb(0x00, hwif->dma_base+0x79);
+	outb(0x00, hwif->dma_base+0x77);
 }
 
 /**
@@ -1368,7 +1368,7 @@
 		default:	break;
 	}
 
-	d->channels = 1;
+	d->channels = 2;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
 	pci_for_each_dev(findev) {


The first one is AFAICS a typo, for the second I'm not sure if there could be 
any reason?
Anyhow, it works for me.

-- 
ronny



