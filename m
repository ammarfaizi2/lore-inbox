Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbUDNJLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUDNJLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:11:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263993AbUDNJKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:10:32 -0400
Message-ID: <407CFFF9.5010500@pobox.com>
Date: Wed, 14 Apr 2004 05:10:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com>	<20040414005832.083de325.akpm@osdl.org>	<20040414010240.0e9f4115.akpm@osdl.org>	<407CF201.408@pobox.com> <20040414011653.22c690d9.akpm@osdl.org>
In-Reply-To: <20040414011653.22c690d9.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090300090407080601050100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300090407080601050100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>I would rather not kill the code in submit_bh() outright, just disable 
>> it for non-filesystem developers.
> 
> 
> submit_bh() is a slowpath ;) The one in mark_buffer_dirty() will be called
> more often, possibly others.  Kill!

Jens seems to like the debugging checks, so here's an alterna-patch.

	Jeff



--------------090300090407080601050100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== arch/alpha/Kconfig 1.36 vs edited =====
--- 1.36/arch/alpha/Kconfig	Sat Mar 20 13:29:54 2004
+++ edited/arch/alpha/Kconfig	Wed Apr 14 04:58:08 2004
@@ -690,6 +690,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/arm/Kconfig 1.53 vs edited =====
--- 1.53/arch/arm/Kconfig	Thu Apr  8 15:41:09 2004
+++ edited/arch/arm/Kconfig	Wed Apr 14 04:58:08 2004
@@ -724,6 +724,13 @@
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
===== arch/arm26/Kconfig 1.11 vs edited =====
--- 1.11/arch/arm26/Kconfig	Mon Mar  1 10:52:18 2004
+++ edited/arch/arm26/Kconfig	Wed Apr 14 04:58:08 2004
@@ -316,6 +316,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
===== arch/i386/Kconfig 1.116 vs edited =====
--- 1.116/arch/i386/Kconfig	Mon Apr 12 13:54:45 2004
+++ edited/arch/i386/Kconfig	Wed Apr 14 04:58:08 2004
@@ -1286,6 +1286,13 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	help
===== arch/ia64/Kconfig 1.69 vs edited =====
--- 1.69/arch/ia64/Kconfig	Mon Apr 12 21:50:46 2004
+++ edited/arch/ia64/Kconfig	Wed Apr 14 04:58:08 2004
@@ -503,6 +503,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
===== arch/m68k/Kconfig 1.31 vs edited =====
--- 1.31/arch/m68k/Kconfig	Thu Feb 26 06:25:58 2004
+++ edited/arch/m68k/Kconfig	Wed Apr 14 04:58:08 2004
@@ -688,6 +688,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/mips/Kconfig 1.24 vs edited =====
--- 1.24/arch/mips/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/mips/Kconfig	Wed Apr 14 04:58:08 2004
@@ -1253,6 +1253,13 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
===== arch/parisc/Kconfig 1.28 vs edited =====
--- 1.28/arch/parisc/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/parisc/Kconfig	Wed Apr 14 04:58:08 2004
@@ -222,6 +222,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/ppc/Kconfig 1.57 vs edited =====
--- 1.57/arch/ppc/Kconfig	Tue Mar 30 10:39:41 2004
+++ edited/arch/ppc/Kconfig	Wed Apr 14 04:58:08 2004
@@ -1209,6 +1209,13 @@
 	  debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
===== arch/ppc64/Kconfig 1.52 vs edited =====
--- 1.52/arch/ppc64/Kconfig	Mon Apr 12 13:54:05 2004
+++ edited/arch/ppc64/Kconfig	Wed Apr 14 04:58:08 2004
@@ -395,6 +395,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/s390/Kconfig 1.25 vs edited =====
--- 1.25/arch/s390/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/s390/Kconfig	Wed Apr 14 04:58:08 2004
@@ -397,6 +397,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	help
===== arch/sparc/Kconfig 1.28 vs edited =====
--- 1.28/arch/sparc/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/sparc/Kconfig	Wed Apr 14 04:58:08 2004
@@ -448,6 +448,13 @@
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/sparc64/Kconfig 1.50 vs edited =====
--- 1.50/arch/sparc64/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/sparc64/Kconfig	Wed Apr 14 04:58:08 2004
@@ -679,6 +679,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config STACK_DEBUG
 	depends on DEBUG_KERNEL
 	bool "Stack Overflow Detection Support"
===== arch/um/Kconfig 1.14 vs edited =====
--- 1.14/arch/um/Kconfig	Mon Apr 12 13:53:57 2004
+++ edited/arch/um/Kconfig	Wed Apr 14 04:58:08 2004
@@ -233,6 +233,13 @@
         If you're truly short on disk space or don't expect to report any
         bugs back to the UML developers, say N, otherwise say Y.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
 	bool
 	default y if DEBUG_INFO
===== arch/v850/Kconfig 1.21 vs edited =====
--- 1.21/arch/v850/Kconfig	Mon Feb 16 19:42:32 2004
+++ edited/arch/v850/Kconfig	Wed Apr 14 04:58:08 2004
@@ -320,6 +320,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
===== arch/x86_64/Kconfig 1.47 vs edited =====
--- 1.47/arch/x86_64/Kconfig	Mon Apr 12 13:53:56 2004
+++ edited/arch/x86_64/Kconfig	Wed Apr 14 04:58:08 2004
@@ -471,6 +471,13 @@
 	  Please note that this option requires new binutils.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        help
===== fs/buffer.c 1.237 vs edited =====
--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
+++ edited/fs/buffer.c	Wed Apr 14 05:05:28 2004
@@ -55,6 +55,7 @@
  * Debug/devel support stuff
  */
 
+#ifdef CONFIG_DEBUG_BUFFERS
 void __buffer_error(char *file, int line)
 {
 	static int enough;
@@ -69,6 +70,7 @@
 	dump_stack();
 }
 EXPORT_SYMBOL(__buffer_error);
+#endif /* CONFIG_DEBUG_BUFFERS */
 
 inline void
 init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
@@ -105,10 +107,9 @@
 	 * waitqueue, which is used here. (Well.  Other locked buffers
 	 * against the page will pin it.  But complain anyway).
 	 */
-	if (atomic_read(&bh->b_count) == 0 &&
+	buffer_errchk  (atomic_read(&bh->b_count) == 0 &&
 			!PageLocked(bh->b_page) &&
-			!PageWriteback(bh->b_page))
-		buffer_error();
+			!PageWriteback(bh->b_page));
 
 	clear_buffer_locked(bh);
 	smp_mb__after_clear_bit();
@@ -125,9 +126,8 @@
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
 	DEFINE_WAIT(wait);
 
-	if (atomic_read(&bh->b_count) == 0 &&
-			(!bh->b_page || !PageLocked(bh->b_page)))
-		buffer_error();
+	buffer_errchk(atomic_read(&bh->b_count) == 0 &&
+			(!bh->b_page || !PageLocked(bh->b_page)));
 
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
@@ -146,8 +146,7 @@
 static void
 __set_page_buffers(struct page *page, struct buffer_head *head)
 {
-	if (page_has_buffers(page))
-		buffer_error();
+	buffer_errchk(page_has_buffers(page));
 	page_cache_get(page);
 	SetPagePrivate(page);
 	page->private = (unsigned long)head;
@@ -433,7 +432,7 @@
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	buffer_error();
+	BUG();
 	printk("block=%llu, b_blocknr=%llu\n",
 		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
 	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
@@ -847,10 +846,10 @@
 		struct buffer_head *bh = head;
 
 		do {
-			if (buffer_uptodate(bh))
+			if (likely(buffer_uptodate(bh)))
 				set_buffer_dirty(bh);
 			else
-				buffer_error();
+				BUG();
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
@@ -1151,7 +1150,7 @@
 	return page;
 
 failed:
-	buffer_error();
+	BUG();
 	unlock_page(page);
 	page_cache_release(page);
 	return NULL;
@@ -1247,8 +1246,7 @@
  */
 void fastcall mark_buffer_dirty(struct buffer_head *bh)
 {
-	if (!buffer_uptodate(bh))
-		buffer_error();
+	buffer_errchk(!buffer_uptodate(bh));
 	if (!buffer_dirty(bh) && !test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
@@ -1267,7 +1265,7 @@
 		return;
 	}
 	printk(KERN_ERR "VFS: brelse: Trying to free free buffer\n");
-	buffer_error();		/* For the stack backtrace */
+	BUG();
 }
 
 /*
@@ -1294,8 +1292,7 @@
 		unlock_buffer(bh);
 		return bh;
 	} else {
-		if (buffer_dirty(bh))
-			buffer_error();
+		buffer_errchk(buffer_dirty(bh));
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, bh);
@@ -1687,8 +1684,7 @@
 	old_bh = __find_get_block_slow(bdev, block, 0);
 	if (old_bh) {
 #if 0	/* This happens.  Later. */
-		if (buffer_dirty(old_bh))
-			buffer_error();
+		buffer_errchk(buffer_dirty(old_bh));
 #endif
 		clear_buffer_dirty(old_bh);
 		wait_on_buffer(old_bh);
@@ -1737,8 +1733,7 @@
 	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
 
 	if (!page_has_buffers(page)) {
-		if (!PageUptodate(page))
-			buffer_error();
+		buffer_errchk(!PageUptodate(page));
 		create_empty_buffers(page, 1 << inode->i_blkbits,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
 	}
@@ -1768,8 +1763,7 @@
 			 * this page can be outside i_size when there is a
 			 * truncate in progress.
 			 *
-			 * if (buffer_mapped(bh))
-			 *	buffer_error();
+			 * buffer_errchk(buffer_mapped(bh));
 			 */
 			/*
 			 * The buffer was zeroed by block_write_full_page()
@@ -1777,8 +1771,7 @@
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
-			if (buffer_new(bh))
-				buffer_error();
+			buffer_errchk(buffer_new(bh));
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1811,8 +1804,7 @@
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			if (!buffer_uptodate(bh))
-				buffer_error();
+			buffer_errchk(!buffer_uptodate(bh));
 			mark_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
@@ -1942,8 +1934,7 @@
 				unmap_underlying_metadata(bh->b_bdev,
 							bh->b_blocknr);
 				if (PageUptodate(page)) {
-					if (!buffer_mapped(bh))
-						buffer_error();
+					buffer_errchk(!buffer_mapped(bh));
 					set_buffer_uptodate(bh);
 					continue;
 				}
@@ -2001,8 +1992,7 @@
 			void *kaddr;
 
 			clear_buffer_new(bh);
-			if (buffer_uptodate(bh))
-				buffer_error();
+			buffer_errchk(buffer_uptodate(bh));
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr+block_start, 0, bh->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
@@ -2068,8 +2058,7 @@
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (PageUptodate(page))
-		buffer_error();
+	buffer_errchk(PageUptodate(page));
 	blocksize = 1 << inode->i_blkbits;
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
@@ -2692,12 +2681,9 @@
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
-	if ((rw == READ || rw == READA) && buffer_uptodate(bh))
-		buffer_error();
-	if (rw == WRITE && !buffer_uptodate(bh))
-		buffer_error();
-	if (rw == READ && buffer_dirty(bh))
-		buffer_error();
+	buffer_errchk((rw == READ || rw == READA) && buffer_uptodate(bh));
+	buffer_errchk(rw == WRITE && !buffer_uptodate(bh));
+	buffer_errchk(rw == READ && buffer_dirty(bh));
 
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
@@ -2807,7 +2793,7 @@
 			&& buffer_mapped(bh)	/* discard_buffer */
 			&& S_ISBLK(page->mapping->host->i_mode))
 		{
-			buffer_error();
+			BUG();
 		}
 	}
 }
@@ -2857,8 +2843,7 @@
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	if (!was_uptodate && PageUptodate(page) && !PageError(page))
-		buffer_error();
+	buffer_errchk(!was_uptodate && PageUptodate(page) && !PageError(page));
 
 	do {
 		struct buffer_head *next = bh->b_this_page;
===== fs/mpage.c 1.54 vs edited =====
--- 1.54/fs/mpage.c	Mon Apr 12 13:54:41 2004
+++ edited/fs/mpage.c	Wed Apr 14 05:06:40 2004
@@ -485,8 +485,7 @@
 			break;
 		block_in_file++;
 	}
-	if (page_block == 0)
-		buffer_error();
+	buffer_errchk(page_block == 0);
 
 	first_unmapped = page_block;
 
===== fs/ext3/inode.c 1.90 vs edited =====
--- 1.90/fs/ext3/inode.c	Tue Jan 20 20:58:53 2004
+++ edited/fs/ext3/inode.c	Wed Apr 14 05:06:48 2004
@@ -1358,8 +1358,7 @@
 	}
 
 	if (!page_has_buffers(page)) {
-		if (!PageUptodate(page))
-			buffer_error();
+		buffer_errchk(!PageUptodate(page));
 		create_empty_buffers(page, inode->i_sb->s_blocksize,
 				(1 << BH_Dirty)|(1 << BH_Uptodate));
 	}
===== fs/ntfs/aops.c 1.96 vs edited =====
--- 1.96/fs/ntfs/aops.c	Mon Apr 12 13:54:35 2004
+++ edited/fs/ntfs/aops.c	Wed Apr 14 05:06:55 2004
@@ -1340,8 +1340,7 @@
 			void *kaddr;
 
 			clear_buffer_new(bh);
-			if (buffer_uptodate(bh))
-				buffer_error();
+			buffer_errchk(buffer_uptodate(bh));
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + block_start, 0, bh->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
===== fs/reiserfs/inode.c 1.97 vs edited =====
--- 1.97/fs/reiserfs/inode.c	Mon Apr 12 13:54:58 2004
+++ edited/fs/reiserfs/inode.c	Wed Apr 14 05:07:16 2004
@@ -1924,10 +1924,8 @@
     /* catch places below that try to log something without starting a trans */
     th.t_trans_id = 0;
 
-    if (!buffer_uptodate(bh_result)) {
-        buffer_error();
+    if (!buffer_uptodate(bh_result))
 	return -EIO;
-    }
 
     kmap(bh_result->b_page) ;
 start_over:
@@ -2057,8 +2055,7 @@
      * in the BH_Uptodate is just a sanity check.
      */
     if (!page_has_buffers(page)) {
-	if (!PageUptodate(page))
-	    buffer_error();
+	buffer_errchk(!PageUptodate(page));
 	create_empty_buffers(page, inode->i_sb->s_blocksize, 
 	                    (1 << BH_Dirty) | (1 << BH_Uptodate));
     }
@@ -2120,8 +2117,7 @@
 	    }
 	}
 	if (test_clear_buffer_dirty(bh)) {
-	    if (!buffer_uptodate(bh))
-		buffer_error();
+	    buffer_errchk(!buffer_uptodate(bh));
 	    mark_buffer_async_write(bh);
 	} else {
 	    unlock_buffer(bh);
===== include/linux/buffer_head.h 1.47 vs edited =====
--- 1.47/include/linux/buffer_head.h	Wed Apr 14 03:18:09 2004
+++ edited/include/linux/buffer_head.h	Wed Apr 14 05:08:07 2004
@@ -7,6 +7,7 @@
 #ifndef _LINUX_BUFFER_HEAD_H
 #define _LINUX_BUFFER_HEAD_H
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
@@ -65,8 +66,16 @@
  * Debug
  */
 
+#ifdef CONFIG_DEBUG_BUFFERS
 void __buffer_error(char *file, int line);
-#define buffer_error() __buffer_error(__FILE__, __LINE__)
+#define buffer_error(condition)					\
+	do {							\
+		if (unlikely(condition))			\
+			__buffer_error(__FILE__, __LINE__);	\
+	} while (0)
+#else
+#define buffer_error(condition)  do {} while (0)
+#endif
 
 /*
  * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()

--------------090300090407080601050100--

