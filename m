Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUBJQ7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUBJQ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:59:39 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:1286 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266009AbUBJQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:58:32 -0500
Date: Tue, 10 Feb 2004 16:59:02 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 2/10] dm: Lift to_bytes() and to_sectors() into dm.h
Message-ID: <20040210165902.GH27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lift to_bytes() and to_sectors() into dm.h
--- diff/drivers/md/dm.c	2004-01-19 10:22:56.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:11:24.000000000 +0000
@@ -233,15 +233,6 @@
  *   interests of getting something for people to use I give
  *   you this clearly demarcated crap.
  *---------------------------------------------------------------*/
-static inline sector_t to_sector(unsigned int bytes)
-{
-	return bytes >> SECTOR_SHIFT;
-}
-
-static inline unsigned int to_bytes(sector_t sector)
-{
-	return sector << SECTOR_SHIFT;
-}
 
 /*
  * Decrements the number of outstanding ios that a bio has been
--- diff/drivers/md/dm.h	2004-02-10 16:11:17.000000000 +0000
+++ source/drivers/md/dm.h	2004-02-10 16:11:24.000000000 +0000
@@ -151,6 +151,16 @@
 	return dm_round_up(n, size) / size;
 }
 
+static inline sector_t to_sector(unsigned long n)
+{
+	return (n >> 9);
+}
+
+static inline unsigned long to_bytes(sector_t n)
+{
+	return (n << 9);
+}
+
 /*
  * The device-mapper can be driven through one of two interfaces;
  * ioctl or filesystem, depending which patch you have applied.
