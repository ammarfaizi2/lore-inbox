Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSLSNYZ>; Thu, 19 Dec 2002 08:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSLSNYZ>; Thu, 19 Dec 2002 08:24:25 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:42913 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S261721AbSLSNYX>;
	Thu, 19 Dec 2002 08:24:23 -0500
Message-ID: <3E01CB02.3010502@tin.it>
Date: Thu, 19 Dec 2002 14:34:58 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: John Reiser <jreiser@BitWagon.com>, Patrick Petermair <black666@inode.at>,
       Roland Quast <rquast@hotshed.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: vt8235 fix, hopefully last variant
References: <20021219112640.A21164@ucw.cz>
In-Reply-To: <20021219112640.A21164@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>Hi!
>
>Can you guys try out this last take on a fix for your ATAPI device
>problems? Applies against clean 2.4.20.
>
>Please report failure/success.
>
>Thanks.
>
>  
>
>------------------------------------------------------------------------
>
>ChangeSet@1.884, 2002-12-19 11:23:11+01:00, vojtech@suse.cz
>  VIA IDE: Always use slow address setup timings for ATAPI devices.
>
>
> via82cxxx.c |   19 ++++++-------------
> 1 files changed, 6 insertions(+), 13 deletions(-)
>
>
>diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
>--- a/drivers/ide/pci/via82cxxx.c	Thu Dec 19 11:23:42 2002
>+++ b/drivers/ide/pci/via82cxxx.c	Thu Dec 19 11:23:42 2002
>@@ -1,16 +1,5 @@
> /*
>- * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
>- *
>- *  Copyright (c) 2000-2001 Vojtech Pavlik
>- *
>- *  Based on the work of:
>- *	Michel Aubry
>- *	Jeff Garzik
>- *	Andre Hedrick
>- */
>-
>-/*
>- * Version 3.35
>+ * Version 3.36
>  *
>  * VIA IDE driver for Linux. Supported southbridges:
>  *
>@@ -152,7 +141,7 @@
> 	via_print("----------VIA BusMastering IDE Configuration"
> 		"----------------");
> 
>-	via_print("Driver Version:                     3.35-ac");
>+	via_print("Driver Version:                     3.36");
> 	via_print("South Bridge:                       VIA %s",
> 		via_config->name);
> 
>@@ -351,6 +340,10 @@
> 		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
> 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
> 	}
>+
>+	/* Always use 4 address setup clocks on ATAPI devices */
>+	if (drive->media != ide_disk)
>+		t.setup = 4;
> 
> 	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
> 
>  
>
It said that 2 of 3 hunks are failed. I don't know why. Error in patch again

Bye

Marcello

