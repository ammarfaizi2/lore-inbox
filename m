Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289697AbSBERcS>; Tue, 5 Feb 2002 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289680AbSBERcC>; Tue, 5 Feb 2002 12:32:02 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64773 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289686AbSBERbq>; Tue, 5 Feb 2002 12:31:46 -0500
Date: Tue, 5 Feb 2002 20:31:39 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 8 of 9 08-unfinished_rebuildtree_message.diff
Message-ID: <20020205203139.A9933@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


This set of patches of which this is one will update ReiserFS in 2.5.3
with latest bugfixes. Also it cleanups the code a bit and adds more helpful
messages in some places.

08-unfinished_rebuildtree_message.diff
    Give a proper explanation if unfinished reiserfsck --rebuild-tree
    run on a fs was detected.


The other patches in this set are:

01-pick_correct_key_version.diff
    This is to fix certain cases where items may get its keys to be interpreted
    wrong, or to be inserted into the tree in wrong order. This bug was only
    observed live on 2.5.3, though it is present in 2.4, too.

02-prealloc_list_init.diff
    prealloc list was forgotten to be initialised.

03-key_output_fix.diff
    Fix all the places where cpu key is attempted to be printed as ondisk key

04-nfs_stale_inode_access.diff
    This is to fix a case where stale NFS handles are correctly detected as
    stale, but inodes assotiated with them are still valid and present in cache,    hence there is no way to deal with files, these handles are attached to.
    Bug was found and explained by
    Anne Milicia <milicia@missioncriticallinux.com>

05-kernel-reiserfs_fs_h-offset_v2.diff
    Convert erroneous le64_to_cpu to cpu_to_le64

06-return_braindamage_removal.diff
    Kill stupid code like 'goto label ; return 1;'

07-remove_nospace_warnings.diff
    Do not print scary warnings in out of free space situations.

08-unfinished_rebuildtree_message.diff
    Give a proper explanation if unfinished reiserfsck --rebuild-tree
    run on a fs was detected.

09-64bit_bitops_fix-1.diff
    Bitopts arguments must be long, not int.


--- linux-2.5.3/fs/reiserfs/super.c.orig	Tue Feb  5 16:54:21 2002
+++ linux-2.5.3/fs/reiserfs/super.c	Tue Feb  5 16:56:01 2002
@@ -749,6 +749,14 @@
 	return 1;
     }
 
+    if ( rs->s_v1.s_root_block == -1 ) {
+       brelse(bh) ;
+       printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
+              "reiserfsck --rebuild-tree and wait for a completion. If that fais\n"
+              "get newer reiserfsprogs package\n", kdevname (s->s_dev));
+       return 1;
+    }
+
     SB_BUFFER_WITH_SB (s) = bh;
     SB_DISK_SUPER_BLOCK (s) = rs;
 
