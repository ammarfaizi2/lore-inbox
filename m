Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269870AbTGOXRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269877AbTGOXRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:17:15 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:32783 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S269870AbTGOXRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:17:14 -0400
Date: Tue, 15 Jul 2003 18:32:02 -0500
From: Art Haas <ahaas@airmail.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030715233202.GB17444@artsapartment.org>
References: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl> <Pine.SOL.4.30.0307160109140.27735-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307160109140.27735-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:12:09AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> It seems it won't help.
> 
> What was the last kernel which worked without "ide=nodma"?
> 

I've been using the 2.5 series for a long time now, but I have vague
memories of not needing to use 'ide=nodma' before this patch was added:

===== setup-pci.c 1.5 vs 1.6 =====
--- 1.5/drivers/ide/setup-pci.c	Sat Sep 21 07:59:59 2002
+++ 1.6/drivers/ide/setup-pci.c	Tue Sep 24 09:24:57 2002
@@ -250,6 +250,7 @@
 
 		switch(dev->device) {
 			case PCI_DEVICE_ID_AL_M5219:
+			case PCI_DEVICE_ID_AL_M5229:
 			case PCI_DEVICE_ID_AMD_VIPER_7409:
 			case PCI_DEVICE_ID_CMD_643:
 			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:

I don't recall which kernel brought this change, and I can't swear that
this recollection is correct.

I'd received mail from another person stating that the ALi DMA is broken
from many old chips, but that it is only the UDMA stuff that is broken,
and the MW_DMA stuff works. Also the notes about the 2.6 transition
indicate ali15x3 and DMA don't always play nicely together. Still,
if the MW_DMA stuff works, some hdparm trickery like ...

# hdparm -d1 -X34 /dev/hda

... would supposedly activate working DMA. I really screwed up my
machine once by fooling around with hdparm so I'm very hesitant to go in
and start trying hdparm commands without some expert guidance.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
