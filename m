Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVDWW04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVDWW04 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDWWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:25:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50146 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262147AbVDWWS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:18:56 -0400
Date: Sun, 24 Apr 2005 00:18:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [3/4]
Message-ID: <20050423221826.GE1884@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232334.17343.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504232334.17343.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch cleans up whitespace in swsusp.c (a bit):
> - removes any trailing whitespace
> - adds spaces after if, for, for_each_pbe, for_each_zone etc., wherever
> necessary.
> 
> Please consider for applying.

Few hunks rejected, so I just applied those that work. This is the
result....

								Pavel

Index: kernel/power/swsusp.c
===================================================================
--- 32777ae73f5bb73dc108d3848153adb77b8a424a/kernel/power/swsusp.c  (mode:100644 sha1:cb4a01ed956eba4369ac1c21fa52901f13ac2cd5)
+++ uncommitted/kernel/power/swsusp.c  (mode:100644)
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
@@ -97,11 +97,11 @@
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
 
@@ -206,7 +206,7 @@
 {
 	int error;
 
-	rw_swap_page_sync(READ, 
+	rw_swap_page_sync(READ,
 			  swp_entry(root_swap, 0),
 			  virt_to_page((unsigned long)&swsusp_header));
 	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
@@ -218,7 +218,7 @@
 		memcpy(swsusp_header.iv, iv, MAXIV);
 #endif
 		swsusp_header.swsusp_info = prev;
-		error = rw_swap_page_sync(WRITE, 
+		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
 					  virt_to_page((unsigned long)
 						       &swsusp_header));
@@ -252,22 +252,22 @@
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
@@ -287,15 +287,15 @@
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
@@ -307,7 +307,7 @@
  *	@loc:	Place to store the entry we used.
  *
  *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not 
+ *	errors. That is an artifact left over from swsusp. It did not
  *	check the return of rw_swap_page_sync() at all, since most pages
  *	written back to swap would return -EIO.
  *	This is a partial improvement, since we will at least return other
@@ -319,7 +319,7 @@
 	int error = 0;
 
 	entry = get_swap_page();
-	if (swp_offset(entry) && 
+	if (swp_offset(entry) &&
 	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
 		error = rw_swap_page_sync(WRITE, entry,
 					  virt_to_page(addr));
@@ -335,7 +335,7 @@
 /**
  *	data_free - Free the swap entries used by the saved image.
  *
- *	Walk the list of used swap entries and free each one. 
+ *	Walk the list of used swap entries and free each one.
  *	This is only used for cleanup when suspend fails.
  */
 static void data_free(void)
@@ -381,7 +381,7 @@
 		mod = 1;
 
 	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe(p, pagedir_nosave) {
+	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
 #ifdef CONFIG_SWSUSP_ENCRYPT
@@ -437,7 +437,7 @@
 
 	dump_info();
 	error = write_page((unsigned long)&swsusp_info, &entry);
-	if (!error) { 
+	if (!error) {
 		printk( "S" );
 		error = mark_swapfiles(entry);
 		printk( "|\n" );
@@ -472,7 +472,7 @@
 	struct pbe * pbe;
 
 	printk( "Writing pagedir...");
-	for_each_pb_page(pbe, pagedir_nosave) {
+	for_each_pb_page (pbe, pagedir_nosave) {
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
 	}
@@ -578,7 +578,7 @@
 	int res = 0;
 
 	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
 		if (res)
@@ -653,7 +653,7 @@
 
 	nr_copy_pages = 0;
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
@@ -668,9 +668,9 @@
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
@@ -808,7 +808,7 @@
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		if (p->address) {
 			ClearPageNosave(virt_to_page(p->address));
 			free_page(p->address);
@@ -825,7 +825,7 @@
 {
 	struct pbe * p;
 
-	for_each_pbe(p, pagedir_save) {
+	for_each_pbe (p, pagedir_save) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if (!p->address)
 			return -ENOMEM;
@@ -846,7 +846,7 @@
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
  *
- *	Returns TRUE or FALSE after checking the number of available 
+ *	Returns TRUE or FALSE after checking the number of available
  *	free pages.
  */
 
@@ -864,11 +864,11 @@
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
@@ -933,8 +933,8 @@
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
@@ -1150,7 +1150,7 @@
 
 	/* Set page flags */
 
-	for_each_zone(zone) {
+	for_each_zone (zone) {
         	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
                 	SetPageNosaveFree(pfn_to_page(zone_pfn +
 					zone->zone_start_pfn));



-- 
Boycott Kodak -- for their patent abuse against Java.
