Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbULLUCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbULLUCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbULLUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:01:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33042 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262105AbULLUAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:00:14 -0500
Date: Sun, 12 Dec 2004 21:00:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] swsusp: make some code static
Message-ID: <20041212200004.GO22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 kernel/power/swsusp.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/kernel/power/swsusp.c.old	2004-12-12 03:05:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/power/swsusp.c	2004-12-12 03:07:44.000000000 +0100
@@ -78,8 +78,8 @@
 extern int is_head_of_free_region(struct page *);
 
 /* Variables to be preserved over suspend */
-int pagedir_order_check;
-int nr_copy_pages_check;
+static int pagedir_order_check;
+static int nr_copy_pages_check;
 
 extern char resume_file[];
 static dev_t resume_device;
@@ -105,14 +105,14 @@
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
-struct swsusp_header {
+static struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
 } __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
 
-struct swsusp_info swsusp_info;
+static struct swsusp_info swsusp_info;
 
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
@@ -175,7 +175,7 @@
 		resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
-int swsusp_swap_check(void) /* This is called before saving image */
+static int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int i, len;
 	
@@ -422,7 +422,7 @@
 	struct highmem_page *next;
 };
 
-struct highmem_page *highmem_copy = NULL;
+static struct highmem_page *highmem_copy = NULL;
 
 static int save_highmem_zone(struct zone *zone)
 {
@@ -785,7 +785,7 @@
 	return 0;
 }
 
-int suspend_prepare_image(void)
+static int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;
 	int error;
@@ -1061,12 +1061,12 @@
 	return error;
 }
 
-int bio_read_page(pgoff_t page_off, void * page)
+static int bio_read_page(pgoff_t page_off, void * page)
 {
 	return submit(READ, page_off, page);
 }
 
-int bio_write_page(pgoff_t page_off, void * page)
+static int bio_write_page(pgoff_t page_off, void * page)
 {
 	return submit(WRITE, page_off, page);
 }

