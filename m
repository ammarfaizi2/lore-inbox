Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293756AbSCKNtn>; Mon, 11 Mar 2002 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293753AbSCKNtf>; Mon, 11 Mar 2002 08:49:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56583 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293737AbSCKNt1>; Mon, 11 Mar 2002 08:49:27 -0500
Message-Id: <200203111347.g2BDlPq05350@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 fs
Date: Mon, 11 Mar 2002 15:46:39 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for fs/*.c cache size messages and the like.

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/buffer.c linux-new/fs/buffer.c
--- linux-2.4.19-pre2/fs/buffer.c	Tue Mar  5 12:42:34 2002
+++ linux-new/fs/buffer.c	Mon Mar 11 10:47:42 2002
@@ -2798,7 +2798,7 @@
 		hash_table = (struct buffer_head **)
 		    __get_free_pages(GFP_ATOMIC, order);
 	} while (hash_table == NULL && --order > 0);
-	printk("Buffer-cache hash table entries: %d (order: %d, %ld bytes)\n",
+	printk(KERN_INFO "Buffer cache hash table entries: %d (order: %d, %ld bytes)\n",
 	       nr_hash, order, (PAGE_SIZE << order));
 
 	if (!hash_table)
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/dcache.c linux-new/fs/dcache.c
--- linux-2.4.19-pre2/fs/dcache.c	Mon Feb 25 17:38:08 2002
+++ linux-new/fs/dcache.c	Mon Mar 11 10:47:42 2002
@@ -1210,7 +1210,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (dentry_hashtable == NULL && --order >= 0);
 
-	printk("Dentry-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
 	if (!dentry_hashtable)
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/inode.c linux-new/fs/inode.c
--- linux-2.4.19-pre2/fs/inode.c	Fri Dec 21 15:41:55 2001
+++ linux-new/fs/inode.c	Mon Mar 11 10:47:42 2002
@@ -1152,7 +1152,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (inode_hashtable == NULL && --order >= 0);
 
-	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Inode cache hash table entries: %d (order: %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
 	if (!inode_hashtable)
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/namespace.c linux-new/fs/namespace.c
--- linux-2.4.19-pre2/fs/namespace.c	Tue Mar  5 12:42:37 2002
+++ linux-new/fs/namespace.c	Mon Mar 11 10:47:42 2002
@@ -1056,8 +1056,9 @@
 	nr_hash = 1UL << hash_bits;
 	hash_mask = nr_hash-1;
 
-	printk("Mount-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
+	printk(KERN_INFO "Mount cache hash table entries: %d"
+		" (order: %ld, %ld bytes)\n",
+		nr_hash, order, (PAGE_SIZE << order));
 
 	/* And initialize the newly allocated array */
 	d = mount_hashtable;
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/super.c linux-new/fs/super.c
--- linux-2.4.19-pre2/fs/super.c	Tue Mar  5 12:42:38 2002
+++ linux-new/fs/super.c	Mon Mar 11 10:47:42 2002
@@ -762,7 +762,7 @@
 
 	/* Forget any remaining inodes */
 	if (invalidate_inodes(sb)) {
-		printk("VFS: Busy inodes after unmount. "
+		printk(KERN_ERR "VFS: Busy inodes after unmount. "
 			"Self-destruct in 5 seconds.  Have a nice day...\n");
 	}
 
