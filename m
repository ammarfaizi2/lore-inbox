Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbTCYR3m>; Tue, 25 Mar 2003 12:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbTCYR2o>; Tue, 25 Mar 2003 12:28:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1660 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263125AbTCYR2c>; Tue, 25 Mar 2003 12:28:32 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdeo3006919@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 7/8] 2.4: Minor build fix for ext3 (2.4 and 2.5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Dilger <adilger@clusterfs.com>

If you have ext2_fs.h and ext3_fs.h included at the same time,
we are missing one define used in ext3_should_journal_data() and
ext3_should_order_data() as part of the test_opt() macro (which
defaults to the ext2 definition if both are present).

--- linux-2.4-ext3push/include/linux/ext3_fs.h.=K0006=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/include/linux/ext3_fs.h	2003-03-25 10:59:15.000000000 +0000
@@ -349,6 +349,7 @@ struct ext3_inode {
 #else
 #define EXT2_MOUNT_NOLOAD		EXT3_MOUNT_NOLOAD
 #define EXT2_MOUNT_ABORT		EXT3_MOUNT_ABORT
+#define EXT2_MOUNT_DATA_FLAGS		EXT3_MOUNT_DATA_FLAGS
 #endif
 
 #define ext3_set_bit			ext2_set_bit
