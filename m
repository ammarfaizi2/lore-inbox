Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270455AbRHNFtl>; Tue, 14 Aug 2001 01:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270457AbRHNFtc>; Tue, 14 Aug 2001 01:49:32 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:51356
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S270455AbRHNFtQ>; Tue, 14 Aug 2001 01:49:16 -0400
Message-ID: <027501c12485$042776b0$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
In-Reply-To: <E15WG2Z-0007Di-00@the-village.bc.nu>
Subject: [PATCH] Re: Lost interrupt with HPT370
Date: Mon, 13 Aug 2001 22:50:26 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This turned out to be the problem. There is a new generation of IBM Deskstar
drives (that are really nice drives :-) that have the same incompatibility
with the HPT-366 chip as the older IBM drives did. Below is a patch to add
the entire series to the "bad drives" lists, although I personally have only
experienced the problem with the 41G model I think it's logical to assume
they'll all have the same problem.

Drives work fine once this patch is in place, although only in ATA-44 (weird
mode).

<snip>

> Check your drive is in the bad_ata100_5 and bad_ata66_4 list. If not add
> it then rebuild and retry (drivers/ide/hpt366.c) - and let me know
>
> Alan

--- linux/drivers/ide/hpt366.old Mon Aug 13 08:45:58 2001
+++ linux/drivers/ide/hpt366.c Mon Aug 13 22:43:43 2001
@@ -60,6 +60,11 @@
  "IBM-DTLA-305040",
  "IBM-DTLA-305030",
  "IBM-DTLA-305020",
+        "IC35L010AVER07-0",
+        "IC35L020AVER07-0",
+        "IC35L030AVER07-0",
+        "IC35L040AVER07-0",
+        "IC35L060AVER07-0",
  "WDC AC310200R",
  NULL
 };
@@ -75,6 +80,11 @@
  "IBM-DTLA-305030",
  "IBM-DTLA-305020",
  "WDC AC310200R",
+        "IC35L010AVER07-0",
+        "IC35L020AVER07-0",
+        "IC35L030AVER07-0",
+        "IC35L040AVER07-0",
+        "IC35L060AVER07-0",
  NULL
 };


