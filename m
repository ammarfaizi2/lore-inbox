Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWJHT34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWJHT34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJHT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:29:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:32400 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751056AbWJHT34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:29:56 -0400
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [mm/ subdirectory] constifications
Date: Sun, 8 Oct 2006 21:29:51 +0200
User-Agent: KMail/1.9.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610082120.57709.deller@gmx.de>
In-Reply-To: <200610082120.57709.deller@gmx.de>
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,=?utf-8?q?7X=0A=09=3FBt1Wb=3AL7K6z-?=<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(=?utf-8?q?e=7D=0A=09=60-QV=7B=23=25=26=5B=3F=5EfAke6t8QbP=3Bb=27XB?=,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"=?utf-8?q?=0A=09=5B?="ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610082129.52005.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 21:20, Helge Deller wrote:
> [ Patch deleted ]

Sorry, last mail was the wrong patch for the mail subject.
Here is the correct one:


[mm/ directory] constify some static string arrays and their pointers

    Signed-off-by: Helge Deller <deller@gmx.de>


 include/linux/mmzone.h |    2 +-
 mm/mempolicy.c         |    4 ++--
 mm/page_alloc.c        |    2 +-
 mm/shmem.c             |    4 ++--
 mm/swapfile.c          |    2 +-
 mm/vmstat.c            |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 59855b8..1d88f9b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -282,7 +282,7 @@ struct zone {
 	/*
 	 * rarely used fields:
 	 */
-	char			*name;
+	const char		*name;
 } ____cacheline_internodealigned_in_smp;
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 25788b1..15a7999 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1705,8 +1705,8 @@ void mpol_rebind_mm(struct mm_struct *mm
  * Display pages allocated per node and memory policy via /proc.
  */
 
-static const char *policy_types[] = { "default", "prefer", "bind",
-				      "interleave" };
+static const char * const policy_types[] = 
+	{ "default", "prefer", "bind", "interleave" };
 
 /*
  * Convert a mempolicy into a string.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8c003e..b706eef 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = {
+static const char * const zone_names[MAX_NR_ZONES] = {
 	 "DMA",
 #ifdef CONFIG_ZONE_DMA32
 	 "DMA32",
diff --git a/mm/shmem.c b/mm/shmem.c
index bb8ca7e..b9b69e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -176,7 +176,7 @@ static inline void shmem_unacct_blocks(u
 
 static struct super_operations shmem_ops;
 static const struct address_space_operations shmem_aops;
-static struct file_operations shmem_file_operations;
+static const struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct inode_operations shmem_special_inode_operations;
@@ -2237,7 +2237,7 @@ static const struct address_space_operat
 	.migratepage	= migrate_page,
 };
 
-static struct file_operations shmem_file_operations = {
+static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 #ifdef CONFIG_TMPFS
 	.llseek		= generic_file_llseek,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a15def6..88219d6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1337,7 +1337,7 @@ static int swaps_open(struct inode *inod
 	return seq_open(file, &swaps_op);
 }
 
-static struct file_operations proc_swaps_operations = {
+static const struct file_operations proc_swaps_operations = {
 	.open		= swaps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 45b124e..be7701a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -452,7 +452,7 @@ struct seq_operations fragmentation_op =
 #define TEXTS_FOR_ZONES(xx) xx "_dma", TEXT_FOR_DMA32(xx) xx "_normal", \
 					TEXT_FOR_HIGHMEM(xx)
 
-static char *vmstat_text[] = {
+static const char * const vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_anon_pages",
 	"nr_mapped",
