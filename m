Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbULFAgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbULFAgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbULFAgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:36:23 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:57554 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261434AbULFAf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:35:57 -0500
Message-ID: <41B3A963.4090003@keyaccess.nl>
Date: Mon, 06 Dec 2004 01:35:47 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Matthieu Castet <castet.matthieu@free.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
Content-Type: multipart/mixed;
 boundary="------------060101010902010404030003"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101010902010404030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam.

Between 2.6.8 and 2.6.9, the following patch to rsparser.c was merged:

http://linus.bkbits.net:8080/linux-2.5/cset@414703f7MEe33PTYY-aFQaM3CLKjZw?nav=index.html|src/|src/drivers|src/drivers/pnp|src/drivers/pnp/pnpbios|related/drivers/pnp/pnpbios/rsparser.c

The added warning triggers on my machine:

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7740
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6634, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver

I don't believe those warnings should be printed, what with "broken" the 
expected state of anything coming from the BIOS. The attached patch 
removes them again. Works for me...

Rene.






--------------060101010902010404030003
Content-Type: text/x-patch;
 name="linux-2.6.10-rc3_rsparser.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-rc3_rsparser.diff"

--- linux-2.6.10-rc3.orig/drivers/pnp/pnpbios/rsparser.c	2004-12-04 03:10:03.000000000 +0100
+++ linux-2.6.10-rc3/drivers/pnp/pnpbios/rsparser.c	2004-12-06 01:12:50.000000000 +0100
@@ -433,14 +433,10 @@
 		case SMALL_TAG_ENDDEP:
 			if (len != 0)
 				goto len_err;
-			if (option_independent == option)
-				printk(KERN_WARNING "PnPBIOS: Missing SMALL_TAG_STARTDEP tag\n");
 			option = option_independent;
 			break;
 
 		case SMALL_TAG_END:
-			if (option_independent != option)
-				printk(KERN_WARNING "PnPBIOS: Missing SMALL_TAG_ENDDEP tag\n");
 			p = p + 2;
         		return (unsigned char *)p;
 			break;

--------------060101010902010404030003--
