Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVDWVwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVDWVwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVDWVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:52:20 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:45727 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262064AbVDWVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:48:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [3/4]
Date: Sat, 23 Apr 2005 23:34:17 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl>
In-Reply-To: <200504232320.54477.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504232334.17343.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans up whitespace in swsusp.c (a bit):
- removes any trailing whitespace
- adds spaces after if, for, for_each_pbe, for_each_zone etc., wherever
necessary.

Please consider for applying.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nurp a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2005-04-22 14:48:04.000000000 +0200
+++ b/kernel/power/swsusp.c	2005-04-23 21:48:19.000000000 +0200
@@ -10,12 +10,12 @@
  * This file is released under the GPLv2.
  *
  * I'd like to thank the following people for their work:
- * 
+ *
  * Pavel Machek <pavel@ucw.cz>:
  * Modifications, defectiveness pointing, being with me at the very beginning,
  * suspend to swap space, stop all tasks. Port to 2.4.18-ac and 2.5.17.
  *
- * Steve Doddi <dirk@loth.demon.co.uk>: 
+ * Steve Doddi <dirk@loth.demon.co.uk>:
  * Support the possibility of hardware state restoring.
  *
  * Raph <grey.havens@earthling.net>:
@@ -84,11 +84,11 @@ extern char resume_file[];
 unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume 
+   must be freed after resume
 
    Warning: this is evil. There are actually two pagedirs at time of
    resume. One is "pagedir_save", which is empty frame allocated at
-   time of suspend, that must be freed. Second is "pagedir_nosave", 
+   time of suspend, that must be freed. Second is "pagedir_nosave",
    allocated at time of resume, that travels through memory not to
    collide with anything.
 
@@ -132,7 +132,7 @@ static int mark_swapfiles(swp_entry_t pr
 {
 	int error;
 
-	rw_swap_page_sync(READ, 
+	rw_swap_page_sync(READ,
 			  swp_entry(root_swap, 0),
 			  virt_to_page((unsigned long)&swsusp_header));
 	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
@@ -140,7 +140,7 @@ static int mark_swapfiles(swp_entry_t pr
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
 		swsusp_header.swsusp_info = prev;
-		error = rw_swap_page_sync(WRITE, 
+		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
 					  virt_to_page((unsigned long)
 						       &swsusp_header));
@@ -174,22 +174,22 @@ static int is_resume_device(const struct
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int i, len;
-	
+
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
-	
+
 	swap_list_lock();
-	for(i=0; i<MAX_SWAPFILES; i++) {
+	for (i=0; i<MAX_SWAPFILES; i++) {
 		if (swap_info[i].flags == 0) {
 			swapfile_used[i]=SWAPFILE_UNUSED;
 		} else {
-			if(!len) {
+			if (!len) {
 	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
-				if(root_swap == 0xFFFF) {
+				if (root_swap == 0xFFFF) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else
-					swapfile_used[i] = SWAPFILE_IGNORED;				  
+					swapfile_used[i] = SWAPFILE_IGNORED;
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
 				if (is_resume_device(&swap_info[i])) {
@@ -209,15 +209,15 @@ static int swsusp_swap_check(void) /* Th
  * This is called after saving image so modification
  * will be lost after resume... and that's what we want.
  * we make the device unusable. A new call to
- * lock_swapdevices can unlock the devices. 
+ * lock_swapdevices can unlock the devices.
  */
 static void lock_swapdevices(void)
 {
 	int i;
 
 	swap_list_lock();
-	for(i = 0; i< MAX_SWAPFILES; i++)
-		if(swapfile_used[i] == SWAPFILE_IGNORED) {
+	for (i = 0; i< MAX_SWAPFILES; i++)
+		if (swapfile_used[i] == SWAPFILE_IGNORED) {
 			swap_info[i].flags ^= 0xFF;
 		}
 	swap_list_unlock();
@@ -229,7 +229,7 @@ static void lock_swapdevices(void)
  *	@loc:	Place to store the entry we used.
  *
  *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not 
+ *	errors. That is an artifact left over from swsusp. It did not
  *	check the return of rw_swap_page_sync() at all, since most pages
  *	written back to swap would return -EIO.
  *	This is a partial improvement, since we will at least return other
@@ -241,7 +241,7 @@ static int write_page(unsigned long addr
 	int error = 0;
 
 	entry = get_swap_page();
-	if (swp_offset(entry) && 
+	if (swp_offset(entry) &&
 	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
 		error = rw_swap_page_sync(WRITE, entry,
 					  virt_to_page(addr));
@@ -257,7 +257,7 @@ static int write_page(unsigned long addr
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
- *	Walk the list of used swap entries and free each one. 
+ *	Walk the list of used swap entries and free each one.
  *	This is only used for cleanup when suspend fails.
  */
 static void data_free(void)
@@ -290,7 +290,7 @@ static int data_write(void)
 		mod = 1;
 
 	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe(p, pagedir_nosave) {
+	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
 		if ((error = write_page(p->address, &(p->swap_address))))
@@ -335,7 +335,7 @@ static int close_swap(void)
 
 	dump_info();
 	error = write_page((unsigned long)&swsusp_info, &entry);
-	if (!error) { 
+	if (!error) {
 		printk( "S" );
 		error = mark_swapfiles(entry);
 		printk( "|\n" );
@@ -370,7 +370,7 @@ static int write_pagedir(void)
 	struct pbe * pbe;
 
 	printk( "Writing pagedir...");
-	for_each_pb_page(pbe, pagedir_nosave) {
+	for_each_pb_page (pbe, pagedir_nosave) {
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
 	}
@@ -472,7 +472,7 @@ static int save_highmem(void)
 	int res = 0;
 
 	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
 		if (res)
@@ -547,7 +547,7 @@ static void count_data_pages(void)
 
 	nr_copy_pages = 0;
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
@@ -562,9 +562,9 @@ static void copy_data_pages(void)
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
-	
+
 	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
@@ -702,7 +702,7 @@ static void free_image_pages(void)
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		if (p->address) {
 			ClearPageNosave(virt_to_page(p->address));
 			free_page(p->address);
@@ -719,7 +719,7 @@ static int alloc_image_pages(void)
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address)
 			return -ENOMEM;
@@ -740,7 +740,7 @@ void swsusp_free(void)
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
  *
- *	Returns TRUE or FALSE after checking the number of available 
+ *	Returns TRUE or FALSE after checking the number of available
  *	free pages.
  */
 
@@ -758,11 +758,11 @@ static int enough_free_mem(void)
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
  *
- *	Returns TRUE or FALSE after checking the total amount of swap 
+ *	Returns TRUE or FALSE after checking the total amount of swap
  *	space avaiable.
  *
  *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device. 
+ *	We should only consider resume_device.
  */
 
 static int enough_swap(void)
@@ -827,8 +827,8 @@ static int suspend_prepare_image(void)
 	error = swsusp_alloc();
 	if (error)
 		return error;
-	
-	/* During allocating of suspend pagedir, new cold pages may appear. 
+
+	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
 	 */
 	drain_local_pages();
@@ -1045,7 +1045,7 @@ static struct pbe * swsusp_pagedir_reloc
 
 	/* Set page flags */
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
         	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
                 	SetPageNosaveFree(pfn_to_page(zone_pfn +
 					zone->zone_start_pfn));
@@ -1181,9 +1181,9 @@ static int bio_write_page(pgoff_t page_o
 static const char * sanity_check(void)
 {
 	dump_info();
-	if(swsusp_info.version_code != LINUX_VERSION_CODE)
+	if (swsusp_info.version_code != LINUX_VERSION_CODE)
 		return "kernel version";
-	if(swsusp_info.num_physpages != num_physpages)
+	if (swsusp_info.num_physpages != num_physpages)
 		return "memory size";
 	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
 		return "system type";
@@ -1193,7 +1193,7 @@ static const char * sanity_check(void)
 		return "version";
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
 		return "machine";
-	if(swsusp_info.cpus != num_online_cpus())
+	if (swsusp_info.cpus != num_online_cpus())
 		return "number of cpus";
 	return NULL;
 }
@@ -1230,7 +1230,7 @@ static int check_sig(void)
 		 * Reset swap signature now.
 		 */
 		error = bio_write_page(0, &swsusp_header);
-	} else { 
+	} else {
 		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

