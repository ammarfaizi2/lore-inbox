Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUA1PqB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbUA1Pog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:44:36 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:10763 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266052AbUA1PlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:41:22 -0500
Date: Wed, 28 Jan 2004 23:40:40 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 6/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282328330.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

6-autofs4-2.6.0-test9-misc.patch

Mostly corrections to debug print strings.

diff -Nur linux-2.6.0-0.test9.readdir/fs/autofs4/root.c linux-2.6.0-0.test9.misc/fs/autofs4/root.c
--- linux-2.6.0-0.test9.readdir/fs/autofs4/root.c	2003-11-30 10:16:18.977924576 +0800
+++ linux-2.6.0-0.test9.misc/fs/autofs4/root.c	2003-11-30 10:17:28.125412560 +0800
@@ -544,7 +544,7 @@
 	struct autofs_sb_info *sbi;
 	int oz_mode;
 
-	DPRINTK(("autofs_root_lookup: name = %.*s\n", 
+	DPRINTK(("autofs4_root_lookup: name = %.*s\n", 
 		 dentry->d_name.len, dentry->d_name.name));
 
 	if (dentry->d_name.len > NAME_MAX)
@@ -553,7 +553,7 @@
 	sbi = autofs4_sbi(dir->i_sb);
 
 	oz_mode = autofs4_oz_mode(sbi);
-	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
+	DPRINTK(("autofs4_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
 		 current->pid, process_group(current), sbi->catatonic, oz_mode));
 
 	/*
@@ -611,7 +611,7 @@
 	struct inode *inode;
 	char *cp;
 
-	DPRINTK(("autofs_dir_symlink: %s <- %.*s\n", symname, 
+	DPRINTK(("autofs4_dir_symlink: %s <- %.*s\n", symname, 
 		 dentry->d_name.len, dentry->d_name.name));
 
 	if (!autofs4_oz_mode(sbi)) {
@@ -663,7 +663,7 @@
  * If a process is blocked on the dentry waiting for the expire to finish,
  * it will invalidate the dentry and try to mount with a new one.
  *
- * Also see autofs_dir_rmdir().. 
+ * Also see autofs4_dir_rmdir().. 
  */
 static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
@@ -728,7 +728,7 @@
 	if ( !autofs4_oz_mode(sbi) )
 		return -EACCES;
 
-	DPRINTK(("autofs_dir_mkdir: dentry %p, creating %.*s\n",
+	DPRINTK(("autofs4_dir_mkdir: dentry %p, creating %.*s\n",
 		 dentry, dentry->d_name.len, dentry->d_name.name));
 
 	ino = autofs4_init_ino(ino, sbi, S_IFDIR | 0555);
@@ -752,7 +752,7 @@
 	return 0;
 }
 
-/* Identify autofs_dentries - this is so we can tell if there's
+/* Identify autofs4_dentries - this is so we can tell if there's
    an extra dentry refcount or not.  We only hold a refcount on the
    dentry if its non-negative (ie, d_inode != NULL)
 */
@@ -804,7 +804,7 @@
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
 
-	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
+	DPRINTK(("autofs4_root_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
 		 cmd,arg,sbi,process_group(current)));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
diff -Nur linux-2.6.0-0.test9.readdir/fs/autofs4/waitq.c linux-2.6.0-0.test9.misc/fs/autofs4/waitq.c
--- linux-2.6.0-0.test9.readdir/fs/autofs4/waitq.c	2003-11-30 10:16:29.756286016 +0800
+++ linux-2.6.0-0.test9.misc/fs/autofs4/waitq.c	2003-11-30 10:17:38.059902288 +0800
@@ -93,7 +93,7 @@
 	union autofs_packet_union pkt;
 	size_t pktsz;
 
-	DPRINTK(("autofs_notify: wait id = 0x%08lx, name = %.*s, type=%d\n",
+	DPRINTK(("autofs4_notify_daemon: wait id = 0x%08lx, name = %.*s, type=%d\n",
 		 wq->wait_queue_token, wq->len, wq->name, type));
 
 	memset(&pkt,0,sizeof pkt); /* For security reasons */
@@ -119,7 +119,7 @@
 		memcpy(ep->name, wq->name, wq->len);
 		ep->name[wq->len] = '\0';
 	} else {
-		printk("autofs_notify_daemon: bad type %d!\n", type);
+		printk("autofs4_notify_daemon: bad type %d!\n", type);
 		return;
 	}
 
@@ -211,7 +211,7 @@
 		sbi->queues = wq;
 		spin_unlock(&waitq_lock);
 
-		DPRINTK(("autofs_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
+		DPRINTK(("autofs4_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 		/* autofs4_notify_daemon() may block */
 		wq->wait_ctr = 2;
@@ -223,7 +223,7 @@
 		}
 	} else {
 		wq->wait_ctr++;
-		DPRINTK(("autofs_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
+		DPRINTK(("autofs4_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 	}
 
@@ -267,7 +267,7 @@
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 	} else {
-		DPRINTK(("autofs_wait: skipped sleeping\n"));
+		DPRINTK(("autofs4_wait: skipped sleeping\n"));
 	}
 
 	status = wq->status;
