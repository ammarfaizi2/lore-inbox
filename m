Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRHRPVn>; Sat, 18 Aug 2001 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270222AbRHRPVc>; Sat, 18 Aug 2001 11:21:32 -0400
Received: from ns.suse.de ([213.95.15.193]:42757 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270224AbRHRPVP> convert rfc822-to-8bit;
	Sat, 18 Aug 2001 11:21:15 -0400
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.4.9] ati_pcigart.h ob1 bug
X-Yow: On the other hand, life can be an endless parade of TRANSSEXUAL
 QUILTING BEES aboard a cruise ship to DISNEYWORLD
 if only we let it!!
From: Andreas Schwab <schwab@suse.de>
Date: 18 Aug 2001 17:21:28 +0200
Message-ID: <je3d6p5r7r.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is an ob1 bug in ati_alloc_pcigart_table: it is reserving
one page too much beyond the region returned by __get_free_pages.
Similarily, ati_free_pcigart_table should unreserve one page less.

--- linux-2.4.9/drivers/char/drm/ati_pcigart.h	2001/08/18 15:13:16	1.1
+++ linux-2.4.9/drivers/char/drm/ati_pcigart.h	2001/08/18 15:13:43
@@ -57,7 +57,7 @@
 
 	page = virt_to_page( address );
 
-	for ( i = 0 ; i <= ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
+	for ( i = 0 ; i < ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
 		atomic_inc( &page->count );
 		SetPageReserved( page );
 	}
@@ -76,7 +76,7 @@
 
 	page = virt_to_page( address );
 
-	for ( i = 0 ; i <= ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
+	for ( i = 0 ; i < ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
 		atomic_dec( &page->count );
 		ClearPageReserved( page );
 	}

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
