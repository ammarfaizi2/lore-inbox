Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266793AbRGKVoq>; Wed, 11 Jul 2001 17:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266801AbRGKVof>; Wed, 11 Jul 2001 17:44:35 -0400
Received: from fire.osdlab.org ([65.201.151.4]:22172 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266793AbRGKVoV>;
	Wed, 11 Jul 2001 17:44:21 -0400
Message-ID: <3B4CC88C.572DEDA5@osdlab.org>
Date: Wed, 11 Jul 2001 14:43:40 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nils@kernelconcepts.de, Alan <alan@lxorguk.ukuu.org.uk>,
        Linus <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [patch-v2] i810 TCO Oops
Content-Type: multipart/mixed;
 boundary="------------DCC47A91C5EBE4218694D80F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DCC47A91C5EBE4218694D80F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Um, having lunch has created a better patch IMO.
It removes the "if (assignment_and_test)" line
and still fixes the Oops.

Please apply this one instead if possible...
to 2.4.7-preX and 2.3.6-acN.

Thanks.
-- 
~Randy
--------------DCC47A91C5EBE4218694D80F
Content-Type: text/plain; charset=us-ascii;
 name="i810-foundv2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810-foundv2.diff"

--- linux/drivers/char/i810-tco.c.org	Mon Jul  2 13:56:41 2001
+++ linux/drivers/char/i810-tco.c	Wed Jul 11 14:25:21 2001
@@ -261,11 +261,13 @@
 	 */
 
 	pci_for_each_dev(dev) {
-		if (pci_match_device(i810tco_pci_tbl, dev))
+		if (pci_match_device(i810tco_pci_tbl, dev)) {
+			i810tco_pci = dev;
 			break;
+		}
 	}
 
-	if ((i810tco_pci = dev)) {
+	if (i810tco_pci) {
 		/*
 		 *      Find the ACPI base I/O address which is the base
 		 *      for the TCO registers (TCOBASE=ACPIBASE + 0x60)

--------------DCC47A91C5EBE4218694D80F--

