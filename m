Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTBECvS>; Tue, 4 Feb 2003 21:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTBECvS>; Tue, 4 Feb 2003 21:51:18 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:58017 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267750AbTBECvR>; Tue, 4 Feb 2003 21:51:17 -0500
Message-ID: <3E407E8A.1010700@t-online.de>
Date: Wed, 05 Feb 2003 04:01:30 +0100
From: sven.kissner@t-online.de (sven kissner)
Reply-To: chimaera_at_amessage.de@t-online.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021205 Debian/1.2.1-0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA vt8235 headache
References: <20030203225014$6785@gated-at.bofh.it>
In-Reply-To: <20030203225014$6785@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi petr,

i had the same errors (although i never experienced any issues with hd,
but this seems to be because i'm running them on primary while having my
atapu devices on secondary). i fixed them the following:

- using 2.4.21pre4 (pre3 worked either)
- applying the following patch from vojteck:

<--
ChangeSet@1.884, 2002-12-19 11:23:11+01:00, vojtech@suse.cz
    VIA IDE: Always use slow address setup timings for ATAPI devices.


via82cxxx.c |   19 ++++++-------------
1 files changed, 6 insertions(+), 13 deletions(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c       Thu Dec 19 11:23:42 2002
+++ b/drivers/ide/pci/via82cxxx.c       Thu Dec 19 11:23:42 2002
@@ -1,16 +1,5 @@
/*
- * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
- *
- *  Copyright (c) 2000-2001 Vojtech Pavlik
- *
- *  Based on the work of:
- *     Michel Aubry
- *     Jeff Garzik
- *     Andre Hedrick
- */
-
-/*
- * Version 3.35
+ * Version 3.36
    *
    * VIA IDE driver for Linux. Supported southbridges:
    *
@@ -152,7 +141,7 @@
          via_print("----------VIA BusMastering IDE Configuration"
                  "----------------");

-       via_print("Driver Version:                     3.35-ac");
+       via_print("Driver Version:                     3.36");
          via_print("South Bridge:                       VIA %s",
                  via_config->name);

@@ -351,6 +340,10 @@
                  ide_timing_compute(peer, peer->current_speed, &p, T, UT);
                  ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
          }
+
+       /* Always use 4 address setup clocks on ATAPI devices */
+       if (drive->media != ide_disk)
+               t.setup = 4;

          via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
-->

keep on rockin'
sven


