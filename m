Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310133AbSCKXIF>; Mon, 11 Mar 2002 18:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310120AbSCKXH4>; Mon, 11 Mar 2002 18:07:56 -0500
Received: from rj.sgi.com ([204.94.215.100]:3506 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S310133AbSCKXHp>;
	Mon, 11 Mar 2002 18:07:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: [patch] 2.4.19-pre3 rename duplicate partition_name()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 10:07:18 +1100
Message-ID: <4521.1015888038@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops gets confused by two symbols called partition_name when one of
them is exported.  Since the version in fs/partitions/msdos.c is local,
rename it, leave the version in drivers/md/md.c alone.

Index: 19-pre3.1/fs/partitions/msdos.c
--- 19-pre3.1/fs/partitions/msdos.c Wed, 16 Jan 2002 10:45:09 +1100 kaos (linux-2.4/h/b/45_msdos.c 1.1.1.1.1.1.5.1.1.3 644)
+++ 19-pre3.1(w)/fs/partitions/msdos.c Tue, 12 Mar 2002 10:00:22 +1100 kaos (linux-2.4/h/b/45_msdos.c 1.1.1.1.1.1.5.1.1.3 644)
@@ -66,13 +66,13 @@ static inline int is_extended_partition(
 }
 
 /*
- * partition_name() formats the short partition name into the supplied
+ * msdos_partition_name() formats the short partition name into the supplied
  * buffer, and returns a pointer to that buffer.
  * Used by several partition types which makes conditional inclusion messy,
  * use __attribute__ ((unused)) instead.
  */
 static char __attribute__ ((unused))
-	*partition_name (struct gendisk *hd, int minor, char *buf)
+	*msdos_partition_name (struct gendisk *hd, int minor, char *buf)
 {
 #ifdef CONFIG_DEVFS_FS
 	sprintf(buf, "p%d", (minor & ((1 << hd->minor_shift) - 1)));
@@ -225,7 +225,7 @@ solaris_x86_partition(struct gendisk *hd
 		put_dev_sector(sect);
 		return;
 	}
-	printk(" %s: <solaris:", partition_name(hd, minor, buf));
+	printk(" %s: <solaris:", msdos_partition_name(hd, minor, buf));
 	if (le32_to_cpu(v->v_version) != 1) {
 		printk("  cannot handle version %d vtoc>\n",
 			le32_to_cpu(v->v_version));
@@ -319,7 +319,7 @@ static void do_bsd_partition(struct gend
 		put_dev_sector(sect);
 		return;
 	}
-	printk(" %s: <%s:", partition_name(hd, minor, buf), name);
+	printk(" %s: <%s:", msdos_partition_name(hd, minor, buf), name);
 
 	if (le16_to_cpu(l->d_npartitions) < max_partitions)
 		max_partitions = le16_to_cpu(l->d_npartitions);
@@ -385,7 +385,7 @@ static void unixware_partition(struct ge
 		put_dev_sector(sect);
 		return;
 	}
-	printk(" %s: <unixware:", partition_name(hd, minor, buf));
+	printk(" %s: <unixware:", msdos_partition_name(hd, minor, buf));
 	p = &l->vtoc.v_slice[1];
 	/* I omit the 0th slice as it is the same as whole disk. */
 	while (p - &l->vtoc.v_slice[0] < UNIXWARE_NUMSLICE) {
@@ -433,7 +433,7 @@ static void minix_partition(struct gendi
 	if (msdos_magic_present (data + 510) &&
 	    SYS_IND(p) == MINIX_PARTITION) { /* subpartition table present */
 
-		printk(" %s: <minix:", partition_name(hd, minor, buf));
+		printk(" %s: <minix:", msdos_partition_name(hd, minor, buf));
 		for (i = 0; i < MINIX_NR_SUBPARTITIONS; i++, p++) {
 			if ((*current_minor & mask) == 0)
 				break;

