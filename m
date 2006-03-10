Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWCJSsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWCJSsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWCJSsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:48:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7063 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751858AbWCJSsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:48:16 -0500
Subject: [PATCH] Add "-o bh" option to ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:49:50 -0800
Message-Id: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its not really need for now, but as we try to make "nobh"
as default option, it would be nice to have a "-obh" fallback
option - if things go wrong.

Thanks,
Badari

This patch adds "-o bh" option to force use of buffer_heads.
This option is needed when we make "nobh" as default -
and if we run into problems.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc5/fs/ext3/super.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ext3/super.c	2006-02-26 21:09:35.000000000
-0800
+++ linux-2.6.16-rc5/fs/ext3/super.c	2006-03-10 10:31:26.000000000 -0800
@@ -628,7 +628,7 @@ enum {
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
Opt_err_ro,
 	Opt_nouid32, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
-	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
+	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh, Opt_bh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum, Opt_journal_dev,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
@@ -664,6 +664,7 @@ static match_table_t tokens = {
 	{Opt_noreservation, "noreservation"},
 	{Opt_noload, "noload"},
 	{Opt_nobh, "nobh"},
+	{Opt_bh, "bh"},
 	{Opt_commit, "commit=%u"},
 	{Opt_journal_update, "journal=update"},
 	{Opt_journal_inum, "journal=%u"},
@@ -1011,6 +1012,9 @@ clear_qf_name:
 		case Opt_nobh:
 			set_opt(sbi->s_mount_opt, NOBH);
 			break;
+		case Opt_bh:
+			clear_opt(sbi->s_mount_opt, NOBH);
+			break;
 		default:
 			printk (KERN_ERR
 				"EXT3-fs: Unrecognized mount option \"%s\" "


