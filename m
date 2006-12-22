Return-Path: <linux-kernel-owner+w=401wt.eu-S1752742AbWLVVJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbWLVVJt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbWLVVJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:09:49 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:35609 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752742AbWLVVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:09:47 -0500
X-Greylist: delayed 2746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 16:09:46 EST
From: Alex Tomas <alex@clusterfs.com>
To: linux-ext4@vger.kernel.org
Cc: <linux-kernel@vger.kernel.org>, alex@clusterfs.com
Subject: [RFC] booked-page-flag.patch
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
Date: Fri, 22 Dec 2006 23:23:55 +0300
In-Reply-To: <m37iwjwumf.fsf@bzzz.home.net> (Alex Tomas's message of "Fri\, 22
	Dec 2006 23\:20\:08 +0300")
Message-ID: <m33b77wug4.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Index: linux-2.6.20-rc1/include/linux/page-flags.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/page-flags.h	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/page-flags.h	2006-12-22 20:05:31.000000000 +0300
@@ -90,6 +90,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Used for system suspend/resume */
 #define PG_buddy		19	/* Page is free, on buddy lists */
+#define PG_booked		20	/* Has blocks reserved on-disk */
 
 
 #if (BITS_PER_LONG > 32)
@@ -230,6 +231,10 @@ static inline void SetPageUptodate(struc
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
 
+#define PageBooked(page)	test_bit(PG_booked, &(page)->flags)
+#define SetPageBooked(page)	set_bit(PG_booked, &(page)->flags)
+#define ClearPageBooked(page)	clear_bit(PG_booked, &(page)->flags)
+
 #define PageReclaim(page)	test_bit(PG_reclaim, &(page)->flags)
 #define SetPageReclaim(page)	set_bit(PG_reclaim, &(page)->flags)
 #define ClearPageReclaim(page)	clear_bit(PG_reclaim, &(page)->flags)
