Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbUDPVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUDPVvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:51:16 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:6304 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263848AbUDPVtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:49:05 -0400
Date: Fri, 16 Apr 2004 22:47:43 +0100
From: Dave Jones <davej@redhat.com>
To: aia21@cantab.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NTFS null dereference x2
Message-ID: <20040416214743.GU20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, aia21@cantab.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if vol is NULL, everything falls apart..

		Dave

--- linux-2.6.5/fs/ntfs/attrib.c~	2004-04-16 22:45:53.000000000 +0100
+++ linux-2.6.5/fs/ntfs/attrib.c	2004-04-16 22:46:47.000000000 +0100
@@ -1235,16 +1235,19 @@
 	u8 *al_end = al + initialized_size;
 	run_list_element *rl;
 	struct buffer_head *bh;
-	struct super_block *sb = vol->sb;
+	struct super_block *sb;
 	unsigned long block_size = sb->s_blocksize;
 	unsigned long block, max_block;
 	int err = 0;
-	unsigned char block_size_bits = sb->s_blocksize_bits;
+	unsigned char block_size_bits;
 
 	ntfs_debug("Entering.");
 	if (!vol || !run_list || !al || size <= 0 || initialized_size < 0 ||
 			initialized_size > size)
 		return -EINVAL;
+	sb = vol->sb;
+	block_size_bits = sb->s_blocksize_bits;
+
 	if (!initialized_size) {
 		memset(al, 0, size);
 		return 0;
