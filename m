Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWFUTgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWFUTgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWFUTgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:36:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932696AbWFUTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:35:34 -0400
Date: Wed, 21 Jun 2006 20:35:22 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] dm mirror log: bitset_size fix
Message-ID: <20060621193522.GV4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the 'sizeof' in the region log bitmap size calculation: it's
uint32_t, not unsigned long - this breaks on some archs.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-log.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-log.c	2006-06-21 17:17:55.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-log.c	2006-06-21 17:17:56.000000000 +0100
@@ -295,10 +295,10 @@ static int create_log_context(struct dir
 	 * Work out how many "unsigned long"s we need to hold the bitset.
 	 */
 	bitset_size = dm_round_up(region_count,
-				  sizeof(unsigned long) << BYTE_SHIFT);
+				  sizeof(*lc->clean_bits) << BYTE_SHIFT);
 	bitset_size >>= BYTE_SHIFT;
 
-	lc->bitset_uint32_count = bitset_size / 4;
+	lc->bitset_uint32_count = bitset_size / sizeof(*lc->clean_bits);
 
 	/*
 	 * Disk log?
