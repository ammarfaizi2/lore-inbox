Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWBTWMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWBTWMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWBTWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:12:08 -0500
Received: from rtr.ca ([64.26.128.89]:39378 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932236AbWBTWMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:12:06 -0500
Message-ID: <43FA3EB2.30002@rtr.ca>
Date: Mon, 20 Feb 2006 17:12:02 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Francesco Biscani <biscani@pd.astro.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
References: <1140445182.26526.1.camel@localhost.localdomain> <200602202226.43772.biscani@pd.astro.it>
In-Reply-To: <200602202226.43772.biscani@pd.astro.it>
Content-Type: multipart/mixed;
 boundary="------------070405060609090002080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070405060609090002080903
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Francesco Biscani wrote:
>
> Feb 20 22:06:17 kurtz ata2(0): WARNING: ATAPI is disabled, device ignored.
..
> The CDROM on the second ide channel was not recognized (what's up with that 
> WARNING?).

Dunno.  For some odd reason libata still doesn't want to handle ATAPI
devices out-of-the-box.  There's a boot/module option for it, though,
as well as this patch (attached).

--------------070405060609090002080903
Content-Type: text/x-patch;
 name="01_libata_atapi_enabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_libata_atapi_enabled.patch"

--- linux.old/drivers/scsi/libata-core.c	2006-02-14 12:10:33.000000000 -0500
+++ linux/drivers/scsi/libata-core.c	2006-02-16 11:42:58.000000000 -0500
@@ -78,7 +78,7 @@
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
-int atapi_enabled = 0;
+int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 

--------------070405060609090002080903--
