Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312920AbSDYFSV>; Thu, 25 Apr 2002 01:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312927AbSDYFSU>; Thu, 25 Apr 2002 01:18:20 -0400
Received: from gherkin.frus.com ([192.158.254.49]:8577 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S312920AbSDYFST>;
	Thu, 25 Apr 2002 01:18:19 -0400
Message-Id: <m170be4-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] miscellaneous 2.5.10 cleanup
To: linux-kernel@vger.kernel.org
Date: Thu, 25 Apr 2002 00:18:16 -0500 (CDT)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several things still broken in 2.5.10.  Patches appended below
except as noted in problem summary statements.

(1) drivers/scsi/aic7xxx/Makefile still contains an "aix7xxx" typo.
(2) kernel/acct.c still contains BUG_ON() statement that results in
    an "Oops" when "accton" is run on non-SMP systems.
(3) fs/exportfs/expfs.c compile error due to "bad parameter list in
    #define".
(4) drivers/usb/storage/jumpshot.c and datafab.c: several occurences of
	memcpy(sg[sg_idx].address + current_sg_offset, ...)
    need fixing (no "address" member of structure).  No patch supplied.

--- linux/drivers/scsi/aic7xxx/Makefile.orig	Wed Apr 24 23:45:10 2002
+++ linux/drivers/scsi/aic7xxx/Makefile	Wed Apr 24 23:47:46 2002
@@ -33,4 +33,4 @@
 aicasm/aicasm: aicasm/*.[chyl]
 	$(MAKE) -C aicasm
 
-aix7xxx_mod.o: aic7xxx_seq.h aic7xxx_reg.h
+aic7xxx_mod.o: aic7xxx_seq.h aic7xxx_reg.h
--- linux/kernel/acct.c.orig	Mon Apr 22 09:33:45 2002
+++ linux/kernel/acct.c	Mon Apr 22 10:39:01 2002
@@ -160,8 +160,6 @@
 {
 	struct file *old_acct = NULL;
 
-	BUG_ON(!spin_is_locked(&acct_globals.lock));
-
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);
--- linux/fs/exportfs/expfs.c.orig	Tue Apr 23 08:43:09 2002
+++ linux/fs/exportfs/expfs.c	Tue Apr 23 12:47:24 2002
@@ -34,7 +34,7 @@
 
 #define	CALL(ops,fun) ((ops->fun)?(ops->fun):export_op_default.fun)
 
-#define dprintk(x, ...) do{}while(0)
+#define dprintk(x...) do{}while(0)
 
 struct dentry *
 find_exported_dentry(struct super_block *sb, void *obj, void *parent,

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
