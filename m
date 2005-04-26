Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVDZKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVDZKvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDZKvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:51:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44435 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261477AbVDZKqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:46:04 -0400
Date: Tue, 26 Apr 2005 12:45:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2/3] swsusp: cleanup whitespace
Message-ID: <20050426104542.GA17091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans up whitespace in swsusp.c (a bit):
- removes any trailing whitespace
- adds spaces after if, for, for_each_pbe, for_each_zone etc., wherever
necessary.
    
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: kernel/power/swsusp.c
===================================================================
--- 692e5ecfee912a0752ee685f9f757911040f6750/kernel/power/swsusp.c  (mode:100644 sha1:880a42b1dd1bee261ea61bee2a3cb839df1ef1d0)
+++ 643fd6b9a0f4e9aae1fd359614b40f33c38fa503/kernel/power/swsusp.c  (mode:100644 sha1:32c73c87e0d4b68fb4ebb762104eb702fea536eb)
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
@@ -84,11 +84,11 @@
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
 
@@ -132,7 +132,7 @@
 {
 	int error;
 
-	rw_swap_page_sync(READ, 
+	rw_swap_page_sync(READ,
 			  swp_entry(root_swap, 0),
 			  virt_to_page((unsigned long)&swsusp_header));
 	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
@@ -140,7 +140,7 @@
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
 		swsusp_header.swsusp_info = prev;
-		error = rw_swap_page_sync(WRITE, 
+		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
 					  virt_to_page((unsigned long)
 						       &swsusp_header));
@@ -174,22 +174,22 @@
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
@@ -209,15 +209,15 @@
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
@@ -229,7 +229,7 @@
  *	@loc:	Place to store the entry we used.
  *
  *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not 
+ *	errors. That is an artifact left over from swsusp. It did not
  *	check the return of rw_swap_page_sync() at all, since most pages
  *	written back to swap would return -EIO.
  *	This is a partial improvement, since we will at least return other
@@ -241,7 +241,7 @@
 	int error = 0;
 
 	entry = get_swap_page();
-	if (swp_offset(entry) && 
+	if (swp_offset(entry) &&
 	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
 		error = rw_swap_page_sync(WRITE, entry,
 					  virt_to_page(addr));
@@ -257,7 +257,7 @@
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
- *	Walk the list of used swap entries and free each one. 
+ *	Walk the list of used swap entries and free each one.
  *	This is only used for cleanup when suspend fails.
  */
 static void data_free(void)
@@ -290,7 +290,7 @@
 		mod = 1;
 
 	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe(p, pagedir_nosave) {
+	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
 		if ((error = write_page(p->address, &(p->swap_address))))
@@ -335,7 +335,7 @@
 
 	dump_info();
 	error = write_page((unsigned long)&swsusp_info, &entry);
-	if (!error) { 
+	if (!error) {
 		printk( "S" );
 		error = mark_swapfiles(entry);
 		printk( "|\n" );
@@ -370,7 +370,7 @@
 	struct pbe * pbe;
 
 	printk( "Writing pagedir...");
-	for_each_pb_page(pbe, pagedir_nosave) {
+	for_each_pb_page (pbe, pagedir_nosave) {
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
 	}
@@ -472,7 +472,7 @@
 	int res = 0;
 
 	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
 		if (res)
@@ -547,7 +547,7 @@
 
 	nr_copy_pages = 0;
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
@@ -562,9 +562,9 @@
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
@@ -702,7 +702,7 @@
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		if (p->address) {
 			ClearPageNosave(virt_to_page(p->address));
 			free_page(p->address);
@@ -719,7 +719,7 @@
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address)
 			return -ENOMEM;
@@ -740,7 +740,7 @@
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
  *
- *	Returns TRUE or FALSE after checking the number of available 
+ *	Returns TRUE or FALSE after checking the number of available
  *	free pages.
  */
 
@@ -758,11 +758,11 @@
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
@@ -827,8 +827,8 @@
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
@@ -1030,7 +1030,7 @@
 
 	/* Set page flags */
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
         	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
                 	SetPageNosaveFree(pfn_to_page(zone_pfn +
 					zone->zone_start_pfn));



-- 
Boycott Kodak -- for their patent abuse against Java.
