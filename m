Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVBHGRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVBHGRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 01:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBHGRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 01:17:06 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:23098 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261487AbVBHGRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 01:17:00 -0500
Message-ID: <4208590C.1040500@spirentcom.com>
Date: Mon, 07 Feb 2005 22:15:40 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.29-bk8] Resend: sym53c8xx.c: Add ULL suffix to fix
 warning
References: <420845CE.50908@spirentcom.com> <420853A2.2010405@spirentcom.com>
In-Reply-To: <420853A2.2010405@spirentcom.com>
Content-Type: multipart/mixed;
 boundary="------------060106090108080204050404"
X-OriginalArrivalTime: 08 Feb 2005 06:17:00.0334 (UTC) FILETIME=[CC9A0CE0:01C50DA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106090108080204050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark F. Haigh wrote:
> 
> Apologies.  Patch now -p1-able.
> 

[Apolgies yet again, description included now]

Noticed that in drivers/scsi/sym53c8xx.c:

sym53c8xx.c:13185: warning: integer constant is too large for "long" type

Since we're not dealing with C99 (yet), this 64 bit integer constant
needs to be suffixed with ULL.  Patch included.

Mark F. Haigh
Mark.Haigh@spirentcom.com

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>

--------------060106090108080204050404
Content-Type: text/plain;
 name="sym53c8xx-patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx-patch2"

--- linux-2.4.29-bk8/drivers/scsi/sym53c8xx.c.orig	2005-02-07 19:53:05.000000000 -0800
+++ linux-2.4.29-bk8/drivers/scsi/sym53c8xx.c	2005-02-07 19:53:36.000000000 -0800
@@ -13182,7 +13182,7 @@
 	** descriptors.
 	*/
 	if (chip && (chip->features & FE_DAC)) {
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
+		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffULL))
 			chip->features &= ~FE_DAC_IN_USE;
 		else
 			chip->features |= FE_DAC_IN_USE;

--------------060106090108080204050404--
