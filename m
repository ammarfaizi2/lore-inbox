Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKAJ3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKAJ3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKAJ3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:29:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34280 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750715AbVKAJ3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:29:32 -0500
Date: Tue, 1 Nov 2005 10:28:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp cleanups
Message-ID: <20051101092821.GA5963@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans spaces between * and pointer up, and adds "int" in
"unsigned int".

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -168,9 +168,8 @@ static unsigned count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	unsigned n;
+	unsigned int n = 0;
 
-	n = 0;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
@@ -250,10 +249,10 @@ static inline void fill_pb_page(struct p
  *	of memory pages allocated with alloc_pagedir()
  */
 
-void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
+void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
 {
 	struct pbe *pbpage, *p;
-	unsigned num = PBES_PER_PAGE;
+	unsigned int num = PBES_PER_PAGE;
 
 	for_each_pb_page (pbpage, pblist) {
 		if (num >= nr_pages)
@@ -293,9 +292,9 @@ static void *alloc_image_page(void)
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe *alloc_pagedir(unsigned nr_pages)
+struct pbe *alloc_pagedir(unsigned int nr_pages)
 {
-	unsigned num;
+	unsigned int num;
 	struct pbe *pblist, *pbe;
 
 	if (!nr_pages)
@@ -329,7 +328,7 @@ void swsusp_free(void)
 	for_each_zone(zone) {
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			if (pfn_valid(zone_pfn + zone->zone_start_pfn)) {
-				struct page * page;
+				struct page *page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				if (PageNosave(page) && PageNosaveFree(page)) {
 					ClearPageNosave(page);
@@ -348,7 +347,7 @@ void swsusp_free(void)
  *	free pages.
  */
 
-static int enough_free_mem(unsigned nr_pages)
+static int enough_free_mem(unsigned int nr_pages)
 {
 	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
 	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
@@ -356,7 +355,7 @@ static int enough_free_mem(unsigned nr_p
 }
 
 
-static struct pbe *swsusp_alloc(unsigned nr_pages)
+static struct pbe *swsusp_alloc(unsigned int nr_pages)
 {
 	struct pbe *pblist, *p;
 
@@ -380,7 +379,7 @@ static struct pbe *swsusp_alloc(unsigned
 
 asmlinkage int swsusp_save(void)
 {
-	unsigned nr_pages;
+	unsigned int nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -122,8 +122,8 @@ static struct swsusp_info swsusp_info;
 static unsigned short swapfile_used[MAX_SWAPFILES];
 static unsigned short root_swap;
 
-static int write_page(unsigned long addr, swp_entry_t * loc);
-static int bio_read_page(pgoff_t page_off, void * page);
+static int write_page(unsigned long addr, swp_entry_t *loc);
+static int bio_read_page(pgoff_t page_off, void *page);
 
 static u8 key_iv[MAXKEY+MAXIV];
 
@@ -355,7 +355,7 @@ static void lock_swapdevices(void)
  *	This is a partial improvement, since we will at least return other
  *	errors, though we need to eventually fix the damn code.
  */
-static int write_page(unsigned long addr, swp_entry_t * loc)
+static int write_page(unsigned long addr, swp_entry_t *loc)
 {
 	swp_entry_t entry;
 	int error = 0;
@@ -383,7 +383,7 @@ static int write_page(unsigned long addr
 static void data_free(void)
 {
 	swp_entry_t entry;
-	struct pbe * p;
+	struct pbe *p;
 
 	for_each_pbe(p, pagedir_nosave) {
 		entry = p->swap_address;
@@ -492,8 +492,8 @@ static void free_pagedir_entries(void)
 static int write_pagedir(void)
 {
 	int error = 0;
-	unsigned n = 0;
-	struct pbe * pbe;
+	unsigned int n = 0;
+	struct pbe *pbe;
 
 	printk( "Writing pagedir...");
 	for_each_pb_page (pbe, pagedir_nosave) {
@@ -543,7 +543,7 @@ static int write_suspend_image(void)
  *	We should only consider resume_device.
  */
 
-int enough_swap(unsigned nr_pages)
+int enough_swap(unsigned int nr_pages)
 {
 	struct sysinfo i;
 
@@ -694,7 +694,7 @@ static int check_pagedir(struct pbe *pbl
  *	restore from the loaded pages later.  We relocate them here.
  */
 
-static struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
+static struct pbe *swsusp_pagedir_relocate(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -770,7 +770,7 @@ static struct pbe * swsusp_pagedir_reloc
 
 static atomic_t io_done = ATOMIC_INIT(0);
 
-static int end_io(struct bio * bio, unsigned int num, int err)
+static int end_io(struct bio *bio, unsigned int num, int err)
 {
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
 		panic("I/O error reading memory image");
@@ -778,7 +778,7 @@ static int end_io(struct bio * bio, unsi
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device *resume_bdev;
 
 /**
  *	submit - submit BIO request.
@@ -791,10 +791,10 @@ static struct block_device * resume_bdev
  *	Then submit it and wait.
  */
 
-static int submit(int rw, pgoff_t page_off, void * page)
+static int submit(int rw, pgoff_t page_off, void *page)
 {
 	int error = 0;
-	struct bio * bio;
+	struct bio *bio;
 
 	bio = bio_alloc(GFP_ATOMIC, 1);
 	if (!bio)
@@ -823,12 +823,12 @@ static int submit(int rw, pgoff_t page_o
 	return error;
 }
 
-static int bio_read_page(pgoff_t page_off, void * page)
+static int bio_read_page(pgoff_t page_off, void *page)
 {
 	return submit(READ, page_off, page);
 }
 
-static int bio_write_page(pgoff_t page_off, void * page)
+static int bio_write_page(pgoff_t page_off, void *page)
 {
 	return submit(WRITE, page_off, page);
 }
@@ -838,7 +838,7 @@ static int bio_write_page(pgoff_t page_o
  * I really don't think that it's foolproof but more than nothing..
  */
 
-static const char * sanity_check(void)
+static const char *sanity_check(void)
 {
 	dump_info();
 	if (swsusp_info.version_code != LINUX_VERSION_CODE)
@@ -864,7 +864,7 @@ static const char * sanity_check(void)
 
 static int check_header(void)
 {
-	const char * reason = NULL;
+	const char *reason = NULL;
 	int error;
 
 	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
@@ -912,7 +912,7 @@ static int check_sig(void)
 
 static int data_read(struct pbe *pblist)
 {
-	struct pbe * p;
+	struct pbe *p;
 	int error = 0;
 	int i = 0;
 	int mod = swsusp_info.image_pages / 100;
@@ -950,7 +950,7 @@ static int data_read(struct pbe *pblist)
 static int read_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbpage, *p;
-	unsigned i = 0;
+	unsigned int i = 0;
 	int error;
 
 	if (!pblist)

-- 
Thanks, Sharp!
