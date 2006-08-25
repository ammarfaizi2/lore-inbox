Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWHYQEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWHYQEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYQEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:04:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:40384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422723AbWHYQEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:04:52 -0400
Message-ID: <44EF1FAA.7000108@suse.com>
Date: Fri, 25 Aug 2006 12:04:58 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] sun disk label: fix signed int usage for sector count
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The current sun disklabel code uses a signed int for the sector count. When
 partitions larger than 1 TB are used, the cast to a sector_t causes the
 partition sizes to be invalid:

 # cat /proc/paritions | grep sdan
   66   112 2146435072 sdan
   66   115 9223372036853660736 sdan3
   66   120 9223372036853660736 sdan8

 This patch switches the sector count to an unsigned int to fix this.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

--- linux-2.6.5/fs/partitions/sun.c	2004-04-03 22:38:14.000000000 -0500
+++ linux-2.6.5.fix/fs/partitions/sun.c	2006-08-25 11:54:23.000000000 -0400
@@ -73,7 +73,7 @@
 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
 	for (i = 0; i < 8; i++, p++) {
 		unsigned long st_sector;
-		int num_sectors;
+		unsigned int num_sectors;
 
 		st_sector = be32_to_cpu(p->start_cylinder) * spc;
 		num_sectors = be32_to_cpu(p->num_sectors);

-- 
Jeff Mahoney
SUSE Labs
