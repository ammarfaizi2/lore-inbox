Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTJFRAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTJFQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:59:05 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:2575 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264023AbTJFQ57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:57:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lib/parser: Use "%u" instead "%d" (5/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:57:54 +0900
Message-ID: <871xtqpalp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If original code uses the following,

	opts->value = simple_strtoul(value, &value, 0);
	if (*value)
		return error;

It doesn't recognize negative value. So option format should use "%u".

Please apply.


 linux-2.6.0-test6-hirofumi/fs/affs/super.c    |   10 +++++-----
 linux-2.6.0-test6-hirofumi/fs/autofs/inode.c  |   12 ++++++------
 linux-2.6.0-test6-hirofumi/fs/autofs4/inode.c |   12 ++++++------
 linux-2.6.0-test6-hirofumi/fs/ext2/super.c    |    6 +++---
 linux-2.6.0-test6-hirofumi/fs/ext3/super.c    |    6 +++---
 linux-2.6.0-test6-hirofumi/fs/fat/inode.c     |   10 +++++-----
 6 files changed, 28 insertions(+), 28 deletions(-)

diff -puN fs/affs/super.c~parser-token-type fs/affs/super.c
--- linux-2.6.0-test6/fs/affs/super.c~parser-token-type	2003-10-07 01:51:44.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/affs/super.c	2003-10-07 01:51:45.000000000 +0900
@@ -150,15 +150,15 @@ enum {
 };
 
 static match_table_t tokens = {
-	{Opt_bs, "bs=%d"},
+	{Opt_bs, "bs=%u"},
 	{Opt_mode, "mode=%o"},
 	{Opt_mufs, "mufs"},
 	{Opt_prefix, "prefix=%s"},
 	{Opt_protect, "protect"},
-	{Opt_reserved, "reserved=%d"},
-	{Opt_root, "root=%d"},
-	{Opt_setgid, "setgid=%d"},
-	{Opt_setuid, "setuid=%d"},
+	{Opt_reserved, "reserved=%u"},
+	{Opt_root, "root=%u"},
+	{Opt_setgid, "setgid=%u"},
+	{Opt_setuid, "setuid=%u"},
 	{Opt_verbose, "verbose"},
 	{Opt_volume, "volume=%s"},
 	{Opt_ignore, "grpquota"},
diff -puN fs/autofs/inode.c~parser-token-type fs/autofs/inode.c
--- linux-2.6.0-test6/fs/autofs/inode.c~parser-token-type	2003-10-07 01:51:45.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/autofs/inode.c	2003-10-07 01:51:45.000000000 +0900
@@ -49,12 +49,12 @@ static struct super_operations autofs_so
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
 
 static match_table_t autofs_tokens = {
-	{Opt_fd, "fd=%d"},
-	{Opt_uid, "uid=%d"},
-	{Opt_gid, "gid=%d"},
-	{Opt_pgrp, "pgrp=%d"},
-	{Opt_minproto, "minproto=%d"},
-	{Opt_maxproto, "maxproto=%d"},
+	{Opt_fd, "fd=%u"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_pgrp, "pgrp=%u"},
+	{Opt_minproto, "minproto=%u"},
+	{Opt_maxproto, "maxproto=%u"},
 	{Opt_err, NULL}
 };
 
diff -puN fs/autofs4/inode.c~parser-token-type fs/autofs4/inode.c
--- linux-2.6.0-test6/fs/autofs4/inode.c~parser-token-type	2003-10-07 01:51:45.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/autofs4/inode.c	2003-10-07 01:51:45.000000000 +0900
@@ -98,12 +98,12 @@ static struct super_operations autofs4_s
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
 
 static match_table_t tokens = {
-	{Opt_fd, "fd=%d"},
-	{Opt_uid, "uid=%d"},
-	{Opt_gid, "gid=%d"},
-	{Opt_pgrp, "pgrp=%d"},
-	{Opt_minproto, "minproto=%d"},
-	{Opt_maxproto, "maxproto=%d"},
+	{Opt_fd, "fd=%u"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_pgrp, "pgrp=%u"},
+	{Opt_minproto, "minproto=%u"},
+	{Opt_maxproto, "maxproto=%u"},
 	{Opt_err, NULL}
 };
 
diff -puN fs/ext2/super.c~parser-token-type fs/ext2/super.c
--- linux-2.6.0-test6/fs/ext2/super.c~parser-token-type	2003-10-07 01:51:45.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/ext2/super.c	2003-10-07 01:51:45.000000000 +0900
@@ -281,9 +281,9 @@ static match_table_t tokens = {
 	{Opt_grpid, "bsdgroups"},
 	{Opt_nogrpid, "nogrpid"},
 	{Opt_nogrpid, "sysvgroups"},
-	{Opt_resgid, "resgid=%d"},
-	{Opt_resuid, "resuid=%d"},
-	{Opt_sb, "sb=%d"},
+	{Opt_resgid, "resgid=%u"},
+	{Opt_resuid, "resuid=%u"},
+	{Opt_sb, "sb=%u"},
 	{Opt_err_cont, "errors=continue"},
 	{Opt_err_panic, "errors=panic"},
 	{Opt_err_ro, "errors=remount-ro"},
diff -puN fs/ext3/super.c~parser-token-type fs/ext3/super.c
--- linux-2.6.0-test6/fs/ext3/super.c~parser-token-type	2003-10-07 01:51:45.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/ext3/super.c	2003-10-07 01:51:45.000000000 +0900
@@ -544,9 +544,9 @@ static match_table_t tokens = {
 	{Opt_grpid, "bsdgroups"},
 	{Opt_nogrpid, "nogrpid"},
 	{Opt_nogrpid, "sysvgroups"},
-	{Opt_resgid, "resgid=%d"},
-	{Opt_resuid, "resuid=%d"},
-	{Opt_sb, "sb=%d"},
+	{Opt_resgid, "resgid=%u"},
+	{Opt_resuid, "resuid=%u"},
+	{Opt_sb, "sb=%u"},
 	{Opt_err_cont, "errors=continue"},
 	{Opt_err_panic, "errors=panic"},
 	{Opt_err_ro, "errors=remount-ro"},
diff -puN fs/fat/inode.c~parser-token-type fs/fat/inode.c
--- linux-2.6.0-test6/fs/fat/inode.c~parser-token-type	2003-10-07 01:51:45.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/fat/inode.c	2003-10-07 01:51:45.000000000 +0900
@@ -264,12 +264,12 @@ static match_table_t fat_tokens = {
 	{Opt_check_r, "check=r"},
 	{Opt_check_s, "check=s"},
 	{Opt_check_n, "check=n"},
-	{Opt_uid, "uid=%d"},
-	{Opt_gid, "gid=%d"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
 	{Opt_umask, "umask=%o"},
 	{Opt_dmask, "dmask=%o"},
 	{Opt_fmask, "fmask=%o"},
-	{Opt_codepage, "codepage=%d"},
+	{Opt_codepage, "codepage=%u"},
 	{Opt_nocase, "nocase"},
 	{Opt_quiet, "quiet"},
 	{Opt_showexec, "showexec"},
@@ -281,8 +281,8 @@ static match_table_t fat_tokens = {
 	{Opt_obsolate, "conv=b"},
 	{Opt_obsolate, "conv=t"},
 	{Opt_obsolate, "conv=a"},
-	{Opt_obsolate, "fat=%d"},
-	{Opt_obsolate, "blocksize=%d"},
+	{Opt_obsolate, "fat=%u"},
+	{Opt_obsolate, "blocksize=%u"},
 	{Opt_obsolate, "cvf_format=%20s"},
 	{Opt_obsolate, "cvf_options=%100s"},
 	{Opt_obsolate, "posix"},

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
