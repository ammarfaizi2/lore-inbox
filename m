Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBGHot>; Thu, 7 Feb 2002 02:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbSBGHoj>; Thu, 7 Feb 2002 02:44:39 -0500
Received: from angband.namesys.com ([212.16.7.85]:9348 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S285692AbSBGHoV>; Thu, 7 Feb 2002 02:44:21 -0500
Date: Thu, 7 Feb 2002 10:44:20 +0300
From: Oleg Drokin <green@namesys.com>
To: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files resiserfs
Message-ID: <20020207104420.A6824@namesys.com>
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Thu, Feb 07, 2002 at 08:23:48AM +0100, Alex Riesen wrote:

> There were no crashes or suspicious messages on the console.
> Nothing special in logs, and sorry, reiserfs self-debugging
> wasn't enabled.
Can you try the patch attached? It may not fix the thing, but 
we want to be sure (and we'll try to reproduce locally atthe same time).
Also try to run reiserfsck --check on your reiserfs partitions.

Bye,
    Oleg

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i_version_mismatch.diff"

--- linux-2.5.4-pre1/fs/reiserfs/inode.c.orig	Wed Feb  6 11:18:35 2002
+++ linux-2.5.4-pre1/fs/reiserfs/inode.c	Wed Feb  6 11:12:08 2002
@@ -890,6 +890,13 @@
     inode->i_blksize = PAGE_SIZE;
 
     INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
+    REISERFS_I(inode)->i_flags = 0;
+    REISERFS_I(inode)->i_prealloc_block = 0;
+    REISERFS_I(inode)->i_prealloc_count = 0;
+    REISERFS_I(inode)->i_trans_id = 0;
+    REISERFS_I(inode)->i_trans_index = 0;
+    /* nopack = 0, by default */
+    REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
 
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
@@ -950,13 +957,6 @@
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
     }
-    REISERFS_I(inode)->i_flags = 0;
-    REISERFS_I(inode)->i_prealloc_block = 0;
-    REISERFS_I(inode)->i_prealloc_count = 0;
-    REISERFS_I(inode)->i_trans_id = 0;
-    REISERFS_I(inode)->i_trans_index = 0;
-    /* nopack = 0, by default */
-    REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
 
     pathrelse (path);
     if (S_ISREG (inode->i_mode)) {

--bg08WKrSYDhXBjb5--
