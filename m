Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSILSXn>; Thu, 12 Sep 2002 14:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSILSXm>; Thu, 12 Sep 2002 14:23:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:55526 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316898AbSILSXJ>;
	Thu, 12 Sep 2002 14:23:09 -0400
Message-ID: <3D80DB14.2040809@watson.ibm.com>
Date: Thu, 12 Sep 2002 14:21:08 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Ben <bcrl@redhat.com>
Subject: [PATCH] 2.5 port of aio-20020619 for raw devices
Content-Type: multipart/mixed;
 boundary="------------050903060105090308050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903060105090308050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I just did a rough port of the raw device part of the aio-20020619.diff
over to 2.5.32 using the 2.5 aio API published so far. The changeset
comments are below. The patch hasn't been tested. Its only guaranteed
to compile.

I'd like to reiterate that this is not a fork of aio kernel code
development or any attempt to question Ben's role as maintainer ! This
was only an exercise in porting to enable a comparison of the older
(2.4) approach with whatever's coming soon.

Comments are invited on all aspects of the design and implementation.

- Shailabh



# This changeset provides a partial port of Ben LaHaise's asynchronous
# I/O patch for 2.4 kernel to 2.5. The port conforms to the aio API
# included in 2.5.32 and uses the design, data structures and functions
# of the aio-20020619.diff.txt patch.
# What this patch does
# - implements aio read/write for raw devices
# - provides the kvec data structure and helper functions
# - conforms to the kiocb data structure provided in the 2.5.32 aio API
# What this patch doesn't do
# - support read/write for regular files (including those opened with
# O_DIRECT), pipes, sockets.
# - use the dio related functions providing O_DIRECT support.
# - change any of the synchronous read/write functions.
# - allow large transfers (> 128 KB) which were done in 2.4 using the
# generic_aio_next_chunk function and kiocb->u task queue.
#
# The intent of providing this patch is to allow a performance
# comparison of the aio design provided in 2.4 with any forthcoming
# design in 2.5. Hopefully it will lead to an estimate of the
# performance impact of keeping the async and sync I/O paths separate.
# To have a fair comparison, its probably necessary for this code to
# use bios directly rather than buffer heads, allow large I/O's etc.
# The comparison will also be more complete if the missing 2.4
# functionality (regular files, pipes....) is ported over too.
#
# It is NOT intended to fork aio kernel code development or to suggest
# an alternate design for 2.5 aio kernel support.
#
# Comments, suggestion for changes welcome.
#
# - Shailabh Nagar (nagar@watson.ibm.com)
























--------------050903060105090308050609
Content-Type: text/plain;
 name="24aioport-020911.changeset.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="24aioport-020911.changeset.txt"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux Kernel 2.5
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2     -> 1.4    
#	 include/linux/aio.h	1.1     -> 1.3    
#	            Makefile	1.1     -> 1.2    
#	         fs/buffer.c	1.1     -> 1.3    
#	include/linux/types.h	1.1     -> 1.2    
#	         mm/memory.c	1.1     -> 1.3    
#	  include/linux/fs.h	1.1     -> 1.3    
#	            fs/aio.c	1.1     -> 1.3    
#	  drivers/char/raw.c	1.1     -> 1.3    
#	               (new)	        -> 1.2     include/linux/kiovec.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/11	nagar@elinux04.watson.ibm.com	1.3
# This changeset provides a partial port of Ben LaHaise's asynchronous 
# I/O patch for 2.4 kernel to 2.5. The port conforms to the aio API 
# included in 2.5.32 and uses the design, data structures and functions
# of the aio-20020619.diff.txt patch. 
# What this patch does
# - implements aio read/write for raw devices
# - provides the kvec data structure and helper functions
# - conforms to the kiocb data structure provided in the 2.5.32 aio API
# What this patch doesn't do
# - support read/write for regular files (including those opened with 
# O_DIRECT), pipes, sockets. 
# - use the dio related functions providing O_DIRECT support. 
# - change any of the synchronous read/write functions. 
# - allow large transfers (> 128 KB) which were done in 2.4 using the
# generic_aio_next_chunk function and kiocb->u task queue.
# 
# The intent of providing this patch is to allow a performance 
# comparison of the aio design provided in 2.4 with any forthcoming 
# design in 2.5. Hopefully it will lead to an estimate of the 
# performance impact of keeping the async and sync I/O paths separate.
# To have a fair comparison, its probably necessary for this code to 
# use bios directly rather than buffer heads, allow large I/O's etc. 
# The comparison will also be more complete if the missing 2.4 
# functionality (regular files, pipes....) is ported over too. 
# 
# It is NOT intended to fork aio kernel code development or to suggest
# an alternate design for 2.5 aio kernel support. 
# 
# Comments, suggestion for changes welcome.
# 
# - Shailabh Nagar (nagar@watson.ibm.com)
#   
# --------------------------------------------
# 02/09/11	nagar@elinux04.watson.ibm.com	1.4
# compilefixes
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Sep 11 14:00:00 2002
+++ b/Makefile	Wed Sep 11 14:00:00 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 32
-EXTRAVERSION =
+EXTRAVERSION = -aioportraw
 
 # *DOCUMENTATION*
 # Too see a list of typical targets execute "make help"
diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Wed Sep 11 14:00:00 2002
+++ b/drivers/char/raw.c	Wed Sep 11 14:00:00 2002
@@ -17,6 +17,7 @@
 #include <linux/capability.h>
 
 #include <asm/uaccess.h>
+#include <linux/kiovec.h>
 
 struct raw_device_data {
 	struct block_device *binding;
@@ -238,12 +239,99 @@
 	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
 }
 
+
+int	raw_kvec_rw(struct file *filp, int rw, kvec_cb_t cb, size_t size, loff_t pos)
+{
+	int		err;
+	unsigned	minor;
+	kdev_t		dev;
+	unsigned long	limit, blocknr, blocks;
+
+	unsigned	sector_size, sector_bits, sector_mask;
+	unsigned	max_sectors;
+	unsigned	i;
+
+	minor = minor(filp->f_dentry->d_inode->i_rdev);
+	dev = to_kdev_t(raw_devices[minor].binding->bd_dev);
+	sector_size = raw_devices[minor].binding->bd_block_size;
+	sector_bits = blksize_bits(sector_size);
+	sector_mask = sector_size- 1;
+	max_sectors = 25000; /* Arbitrarily chosen from 2.4 code */
+	
+	if (blk_size[major(dev)])
+		limit = (((loff_t) blk_size[major(dev)][minor(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
+	else
+		limit = INT_MAX;
+
+	/* EOF at the end */
+	err = 0;
+	if (!size || (pos >> sector_bits) == limit) {
+		pr_debug("raw_kvec_rw: %Lu > %lu, %d\n", pos >> sector_bits, limit, sector_bits);
+		cb.fn(cb.data, cb.vec, err);
+		return 0;
+	}
+
+	/* ENXIO for io beyond the end */
+	err = -ENXIO;
+	if ((pos >> sector_bits) >= limit) {
+		pr_debug("raw_kvec_rw: %Lu > %lu, %d\n", pos >> sector_bits, limit, sector_bits);
+		goto out;
+	}
+
+	err = -EINVAL;
+	if ((pos < 0) || (pos & sector_mask) || (size & sector_mask)) {
+		pr_debug("pos(%Ld)/size(%lu) wrong(%d)\n", pos, size, sector_mask);
+		goto out;
+	}
+
+	/* Verify that the scatter-gather list is sector aligned. */
+	for (i=0; i<cb.vec->nr; i++)
+		if ((cb.vec->veclet[i].offset & sector_mask) ||
+		    (cb.vec->veclet[i].length & sector_mask)) {
+			pr_debug("veclet offset/length wrong");
+			goto out;
+		}
+
+	blocknr = pos >> sector_bits;
+	blocks = size >> sector_bits;
+	if (blocks > max_sectors)
+		blocks = max_sectors;
+	if (blocks > limit - blocknr)
+		blocks = limit - blocknr;
+	err = -ENXIO;
+	if (!blocks) {
+		pr_debug("raw: !blocks %d %ld %ld\n", max_sectors, limit, blocknr);
+		goto out;
+	}
+
+	err = brw_kvec_async(rw, cb, raw_devices[minor].binding, blocks, blocknr, sector_bits);
+out:
+	if (err)
+		printk(KERN_DEBUG "raw_kvec_rw: ret is %d\n", err);
+	return err;
+	
+
+}
+int raw_kvec_read(struct file *file, kvec_cb_t cb, size_t size, loff_t pos)
+{
+	return raw_kvec_rw(file, READ, cb, size, pos);
+}
+
+int raw_kvec_write(struct file *file, kvec_cb_t cb, size_t size, loff_t pos)
+{
+	return raw_kvec_rw(file, WRITE, cb, size, pos);
+}
+
 static struct file_operations raw_fops = {
 	.read	=	raw_read,
 	.write	=	raw_write,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
+	.aio_read   =	generic_file_aio_read,
+	.aio_write  =	generic_file_aio_write,
+	.kvec_read  =   raw_kvec_read,
+	.kvec_write =   raw_kvec_write,
 	.owner	=	THIS_MODULE,
 };
 
diff -Nru a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	Wed Sep 11 14:00:00 2002
+++ b/fs/aio.c	Wed Sep 11 14:00:00 2002
@@ -44,6 +44,9 @@
 /*------ sysctl variables----*/
 atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
 unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
+unsigned aio_max_size = 0x20000;        /* 128KB per chunk */
+unsigned aio_max_pinned;                /* set to mem/4 in aio_setup */
+
 /*----end sysctl variables---*/
 
 static kmem_cache_t	*kiocb_cachep;
@@ -58,6 +61,11 @@
 static spinlock_t	fput_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(fput_head);
 
+/* forward prototypes */
+static void generic_aio_complete_read(void *_iocb, struct kvec *vec, ssize_t res);
+static void generic_aio_complete_write(void *_iocb, struct kvec *vec, ssize_t res);
+
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -74,6 +82,9 @@
 	if (!kioctx_cachep)
 		panic("unable to create kioctx cache");
 
+	aio_max_pinned = num_physpages/4;
+
+	printk(KERN_NOTICE "aio_setup: num_physpages = %u\n", aio_max_pinned);
 	printk(KERN_NOTICE "aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
 	return 0;
@@ -1110,7 +1121,91 @@
 	return ret;
 }
 
+
+ssize_t generic_aio_rw(int rw, struct kiocb *req, char *buf, size_t size, loff_t pos)
+{
+	int (*kvec_op)(struct file *, kvec_cb_t, size_t, loff_t);
+	kvec_cb_t cb;
+	ssize_t res;
+	struct file *file = req->ki_filp;
+
+	
+	if (size > aio_max_size)
+		size = aio_max_size;
+
+	cb.vec = map_user_kvec(rw, (unsigned long) buf, size);
+	cb.fn = (rw == READ) ? generic_aio_complete_read
+			     : generic_aio_complete_write;
+	cb.data = req;
+
+	kvec_op = (rw == READ) ? file->f_op->kvec_read : file->f_op->kvec_write;
+	res = kvec_op(file, cb, size, pos);
+//	if (unlikely(res != 0)) {
+//		/* If the first chunk was successful, we have to run
+//		 * the callback to attempt the rest of the io.
+//		 */
+//		if (res == size && req->buf) {
+//			cb.fn(cb.data, cb.vec, res);
+//			return 0;
+//		}
+//		unmap_kvec(cb.vec, rw == READ);
+//		free_kvec(cb.vec);
+//	}
+	return res;
+}	
+
+ssize_t generic_file_aio_read(struct kiocb *req, char *buf, size_t size, loff_t pos)
+{
+	return generic_aio_rw(READ, req, buf, size, pos);  
+}
+
+ssize_t generic_file_aio_write(struct kiocb *req, char *buf, size_t size, loff_t pos)
+{
+	return generic_aio_rw(WRITE, req, buf, size, pos);  
+}
+	
+static void generic_aio_complete_rw(int rw, void *_iocb, struct kvec *vec, ssize_t res)
+{
+	struct kiocb *iocb = _iocb;
+
+	unmap_kvec(vec, rw == READ);
+	free_kvec(vec);
+
+#if 0
+	if (res > 0)
+		iocb->nr_transferred += res;
+
+	/* Was this chunk successful?  Is there more left to transfer? */
+	if (res == iocb->this_size && iocb->nr_transferred < iocb->size) {
+		/* We may be in irq context, so queue processing in 
+		 * process context.
+		 */
+		iocb->this_size = rw;
+		INIT_TQUEUE(&iocb->u.tq, generic_aio_next_chunk, iocb);
+		schedule_task(&iocb->u.tq);
+		return;
+	}
+
+	aio_complete(iocb, iocb->nr_transferred ? iocb->nr_transferred : res,
+		     0);
+#endif
+	aio_complete(iocb, res, 0);
+}
+
+static void generic_aio_complete_read(void *_iocb, struct kvec *vec, ssize_t res)
+{
+	generic_aio_complete_rw(READ, _iocb, vec, res);
+}
+
+static void generic_aio_complete_write(void *_iocb, struct kvec *vec, ssize_t res)
+{
+	generic_aio_complete_rw(WRITE, _iocb, vec, res);
+}
+
+
 __initcall(aio_setup);
 
 EXPORT_SYMBOL(aio_complete);
 EXPORT_SYMBOL(aio_put_req);
+EXPORT_SYMBOL_GPL(generic_file_aio_read);
+EXPORT_SYMBOL_GPL(generic_file_aio_write);
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Wed Sep 11 14:00:00 2002
+++ b/fs/buffer.c	Wed Sep 11 14:00:00 2002
@@ -2586,3 +2586,171 @@
 	for (i = 0; i < ARRAY_SIZE(bh_wait_queue_heads); i++)
 		init_waitqueue_head(&bh_wait_queue_heads[i].wqh);
 }
+
+
+/* async kio interface */
+struct brw_cb {
+	kvec_cb_t		cb;
+	atomic_t		io_count;
+	int			nr;
+	struct buffer_head	*bh[1];
+};
+
+static inline void brw_cb_put(struct brw_cb *brw_cb)
+{
+	if (atomic_dec_and_test(&brw_cb->io_count)) {
+		ssize_t res = 0, err = 0;
+		int nr;
+
+		/* Walk the buffer heads associated with this kiobuf
+		 * checking for errors and freeing them as we go.
+		 */
+		for (nr=0; nr < brw_cb->nr; nr++) {
+			struct buffer_head *bh = brw_cb->bh[nr];
+			if (!err && buffer_uptodate(bh))
+				res += bh->b_size;
+			else
+				err = -EIO;
+			kmem_cache_free(bh_cachep, bh);
+		}
+
+		if (!res)
+			res = err;
+
+		brw_cb->cb.fn(brw_cb->cb.data, brw_cb->cb.vec, res);
+
+		kfree(brw_cb);
+	}
+}
+
+static void end_buffer_io_kiobuf_async(struct buffer_head *bh, int uptodate)
+{
+	struct brw_cb *brw_cb;
+	
+	if (uptodate)
+		set_bit(BH_Uptodate, &bh->b_state);
+	else 
+		clear_bit(BH_Uptodate, &bh->b_state);
+
+	brw_cb = bh->b_private;
+	unlock_buffer(bh);
+
+	brw_cb_put(brw_cb);
+}
+
+int brw_kvec_async(int rw, kvec_cb_t cb, struct block_device *bdev, unsigned blocks, unsigned long blknr, int sector_shift)
+{
+	struct kvec	*vec = cb.vec;
+	struct kveclet	*veclet;
+	int		err;
+	int		length;
+	unsigned	sector_size = 1 << sector_shift;
+	int		i;
+
+	struct brw_cb	*brw_cb;
+
+	if (!vec->nr)
+		BUG();
+
+	/* 
+	 * First, do some alignment and validity checks 
+	 */
+	length = 0;
+	for (veclet=vec->veclet, i=0; i < vec->nr; i++,veclet++) {
+		length += veclet->length;
+		if ((veclet->offset & (sector_size-1)) ||
+		    (veclet->length & (sector_size-1))) {
+			printk("brw_kiovec_async: tuple[%d]->offset=0x%x length=0x%x sector_size: 0x%x\n", i, veclet->offset, veclet->length, sector_size);
+			return -EINVAL;
+		}
+	}
+
+	if (length < (blocks << sector_shift))
+		BUG();
+
+	/* 
+	 * OK to walk down the iovec doing page IO on each page we find. 
+	 */
+	err = 0;
+
+	if (!blocks) {
+		printk("brw_kiovec_async: !i\n");
+		return -EINVAL;
+	}
+
+	/* FIXME: tie into userbeans here */
+	brw_cb = kmalloc(sizeof(*brw_cb) + (blocks * sizeof(struct buffer_head *)), GFP_KERNEL);
+	if (!brw_cb)
+		return -ENOMEM;
+
+	brw_cb->cb = cb;
+	brw_cb->nr = 0;
+
+	/* This is ugly.  FIXME. */
+	for (i=0, veclet=vec->veclet; i<vec->nr; i++,veclet++) {
+		struct page *page = veclet->page;
+		unsigned offset = veclet->offset;
+		unsigned length = veclet->length;
+
+		if (!page)
+			BUG();
+
+		while (length > 0) {
+			struct buffer_head *tmp;
+			tmp = kmem_cache_alloc(bh_cachep, GFP_NOIO);
+			err = -ENOMEM;
+			if (!tmp)
+				goto error;
+
+			tmp->b_size = sector_size;
+			set_bh_page(tmp, page, offset);
+			tmp->b_this_page = tmp;
+
+			init_buffer(tmp, end_buffer_io_kiobuf_async, NULL);
+
+			tmp->b_bdev = bdev;
+			tmp->b_blocknr = blknr++;
+			tmp->b_state = (1 << BH_Mapped) | (1 << BH_Lock)
+					| (1 << BH_Req);
+			tmp->b_private = brw_cb;
+
+			if (rw == WRITE) {
+				set_bit(BH_Uptodate, &tmp->b_state);
+				clear_bit(BH_Dirty, &tmp->b_state);
+			}
+
+			brw_cb->bh[brw_cb->nr++] = tmp;
+			length -= sector_size;
+			offset += sector_size;
+
+			if (offset >= PAGE_SIZE) {
+				offset = 0;
+				break;
+			}
+
+			if (brw_cb->nr >= blocks)
+				goto submit;
+		} /* End of block loop */
+	} /* End of page loop */		
+
+submit:
+	atomic_set(&brw_cb->io_count, brw_cb->nr+1);
+	/* okay, we've setup all our io requests, now fire them off! */
+	for (i=0; i<brw_cb->nr; i++) 
+		submit_bh(rw, brw_cb->bh[i]);
+	brw_cb_put(brw_cb);
+
+	return 0;
+
+error:
+	/* Walk brw_cb_table freeing all the goop associated with each kiobuf */
+	if (brw_cb) {
+		/* We got an error allocating the bh'es.  Just free the current
+		   buffer_heads and exit. */
+		for (i=0; i<brw_cb->nr; i++)
+			kmem_cache_free(bh_cachep, brw_cb->bh[i]);
+		kfree(brw_cb);
+	}
+
+	return err;
+}
diff -Nru a/include/linux/aio.h b/include/linux/aio.h
--- a/include/linux/aio.h	Wed Sep 11 14:00:00 2002
+++ b/include/linux/aio.h	Wed Sep 11 14:00:00 2002
@@ -2,6 +2,7 @@
 #define __LINUX__AIO_H
 
 #include <linux/tqueue.h>
+#include <linux/kiovec.h>
 #include <linux/list.h>
 #include <asm/atomic.h>
 
@@ -120,6 +121,9 @@
 {
 	return list_entry(h, struct kiocb, ki_list);
 }
+
+extern ssize_t generic_file_aio_read(struct kiocb *req, char *buf, size_t size, loff_t pos);
+extern ssize_t generic_file_aio_write(struct kiocb *req, char *buf, size_t size, loff_t pos);
 
 /* for sysctl: */
 extern unsigned aio_max_nr, aio_max_size, aio_max_pinned;
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Sep 11 14:00:00 2002
+++ b/include/linux/fs.h	Wed Sep 11 14:00:00 2002
@@ -200,6 +200,9 @@
 
 #ifdef __KERNEL__
 
+#include <linux/aio.h>
+#include <linux/aio_abi.h>
+
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
@@ -764,6 +767,10 @@
 	ssize_t (*sendfile) (struct file *, struct file *, loff_t *, size_t);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+
+	/* in-kernel fully async api */
+	int (*kvec_read)(struct file *, kvec_cb_t, size_t, loff_t);
+	int (*kvec_write)(struct file *, kvec_cb_t, size_t, loff_t);
 };
 
 struct inode_operations {
@@ -1248,6 +1255,9 @@
 				loff_t offset, size_t count);
 int generic_direct_IO(int rw, struct inode *inode, char *buf,
 			loff_t offset, size_t count, get_blocks_t *get_blocks);
+extern int generic_file_kvec_read(struct file *file, kvec_cb_t cb, size_t size, loff_t pos);
+extern int generic_file_kvec_write(struct file *file, kvec_cb_t cb, size_t size, loff_t pos);
+
 
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
diff -Nru a/include/linux/kiovec.h b/include/linux/kiovec.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/kiovec.h	Wed Sep 11 14:00:00 2002
@@ -0,0 +1,59 @@
+#ifndef __LINUX__KIOVEC_H
+#define __LINUX__KIOVEC_H
+
+struct page;
+struct block_device;
+#include <linux/list.h>
+
+struct kveclet {
+	struct page	*page;
+	unsigned	offset;
+	unsigned	length;
+};
+
+struct kvec {
+	unsigned	max_nr;
+	unsigned	nr;
+	struct kveclet	veclet[0];
+};
+
+struct kvec_cb {
+	struct kvec	*vec;
+	void		(*fn)(void *data, struct kvec *vec, ssize_t res);
+	void		*data;
+};
+
+struct kvec_cb_list {
+	struct list_head	list;
+	struct kvec_cb		cb;
+};
+
+#ifndef _LINUX_TYPES_H
+#include <linux/types.h>
+#endif
+#ifndef _LINUX_KDEV_T_H
+#include <linux/kdev_t.h>
+#endif
+#ifndef _ASM_KMAP_TYPES_H
+#include <asm/kmap_types.h>
+#endif
+
+extern struct kvec *FASTCALL(map_user_kvec(int rw, unsigned long va, size_t len));
+extern struct kvec *FASTCALL(mm_map_user_kvec(struct mm_struct *, int rw,
+				     unsigned long va, size_t len));
+extern void FASTCALL(unmap_kvec(struct kvec *, int dirtied));
+extern void FASTCALL(free_kvec(struct kvec *));
+
+/* brw_kvec_async:
+ *	Performs direct io to/from disk into cb.vec.  Count is the number
+ *	of sectors to read, sector_shift is the blocksize (which must be
+ *	compatible with the kernel's current idea of the device's sector
+ *	size) in log2.  blknr is the starting sector offset on device 
+ *      represented by bdev.
+ */
+extern int brw_kvec_async(int rw, kvec_cb_t cb, struct block_device *bdev, 
+			  unsigned count, unsigned long blknr, 
+			  int sector_shift);
+
+
+#endif /* __LINUX__KIOVEC_H */
diff -Nru a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h	Wed Sep 11 14:00:00 2002
+++ b/include/linux/types.h	Wed Sep 11 14:00:00 2002
@@ -149,4 +149,9 @@
 	char			f_fpack[6];
 };
 
+/* kernel typedefs -- they belong here. */
+#ifdef __KERNEL__
+typedef struct kvec_cb kvec_cb_t;
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_TYPES_H */
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Wed Sep 11 14:00:00 2002
+++ b/mm/memory.c	Wed Sep 11 14:00:00 2002
@@ -44,6 +44,8 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/compiler.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -455,6 +457,8 @@
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
+		struct page *page = pte_page(pte);
+		prefetch(page);
 		if (!write || (pte_write(pte) && pte_dirty(pte))) {
 			pfn = pte_pfn(pte);
 			if (pfn_valid(pfn))
@@ -1512,4 +1516,173 @@
 		}
 	}
 	return page;
+}
+
+
+/*
+ * Force in an entire range of pages from the current process's user VA,
+ * and pin them in physical memory.  
+ * FIXME: some architectures need to flush the cache based on user addresses 
+ * here.  Someone please provide a better macro than flush_cache_page.
+ */
+
+#define dprintk(x...)
+atomic_t user_pinned_pages = ATOMIC_INIT(0);
+
+struct kvec *map_user_kvec(int rw, unsigned long ptr, size_t len)
+{
+	return mm_map_user_kvec(current->mm, rw, ptr, len);
+}
+
+struct kvec *mm_map_user_kvec(struct mm_struct *mm, int rw, unsigned long ptr,
+			      size_t len)
+{
+	struct kvec		*vec;
+	struct kveclet		*veclet;
+	unsigned long		end;
+	int			err;
+	struct vm_area_struct *	vma = 0;
+	int			i;
+	int			datain = (rw == READ);
+	unsigned		nr_pages;
+
+	end = ptr + len;
+	if (unlikely(end < ptr))
+		return ERR_PTR(-EINVAL);
+
+	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nr_pages -= ptr >> PAGE_SHIFT;
+	nr_pages ++;
+
+	atomic_add(nr_pages, &user_pinned_pages);
+	err = -EAGAIN;
+	if (unlikely(atomic_read(&user_pinned_pages) >= aio_max_pinned))
+		goto out_adjust;
+
+	vec = kmalloc(sizeof(struct kvec) + nr_pages * sizeof(struct kveclet),
+			GFP_KERNEL);
+	err = -ENOMEM;
+	if (unlikely(!vec))
+		goto out_adjust;
+
+	vec->nr = 0;
+	vec->max_nr = nr_pages;
+	veclet = vec->veclet;
+	
+	down_read(&mm->mmap_sem);
+
+	err = -EFAULT;
+	
+	i = 0;
+
+	/* 
+	 * First of all, try to fault in all of the necessary pages
+	 */
+	while (ptr < end) {
+		struct page *map;
+		veclet->offset = ptr & ~PAGE_MASK;
+		veclet->length = PAGE_SIZE - veclet->offset;
+		if (len < veclet->length)
+			veclet->length = len;
+		ptr &= PAGE_MASK;
+		len -= veclet->length;
+
+		if (!vma || ptr >= vma->vm_end) {
+			vma = find_vma(mm, ptr);
+			if (unlikely(!vma))
+				goto out_unlock;
+			if (unlikely(vma->vm_start > ptr)) {
+				if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+					goto out_unlock;
+				if (unlikely(expand_stack(vma, ptr)))
+					goto out_unlock;
+			}
+			if (unlikely(((datain) && (!(vma->vm_flags & VM_WRITE))) ||
+					(!(vma->vm_flags & VM_READ)))) {
+				err = -EFAULT;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&mm->page_table_lock);
+		while (unlikely(!(map = follow_page(mm, ptr, datain)))) {
+			int ret;
+
+			spin_unlock(&mm->page_table_lock);
+			ret = handle_mm_fault(mm, vma, ptr, datain);
+			if (ret <= 0) {
+				if (!ret)
+					goto out_unlock;
+				else {
+					err = -ENOMEM;
+					goto out_unlock;
+				}
+			}
+			spin_lock(&mm->page_table_lock);
+		}			
+		map = get_page_map(map);
+		if (likely(map != NULL)) {
+			flush_dcache_page(map);
+			atomic_inc(&map->count);
+		} else
+			printk (KERN_INFO "Mapped page missing [%d]\n", i);
+		spin_unlock(&mm->page_table_lock);
+		veclet->page = map;
+		veclet++;
+
+		ptr += PAGE_SIZE;
+		vec->nr = ++i;
+	}
+
+	veclet->page = NULL;	/* dummy for the prefetch in free_kvec */
+	veclet->length = 0;	/* bug checking ;-) */
+
+	up_read(&mm->mmap_sem);
+	dprintk ("map_user_kiobuf: end OK\n");
+	return vec;
+
+ out_unlock:
+	up_read(&mm->mmap_sem);
+	unmap_kvec(vec, 0);
+	kfree(vec);
+	dprintk("map_user_kvec: err(%d) rw=%d\n", err, rw);
+	return ERR_PTR(err);
+
+ out_adjust:
+	atomic_sub(nr_pages, &user_pinned_pages);
+	dprintk("map_user_kvec: err(%d) rw=%d\n", err, rw);
+	return ERR_PTR(err);
+}
+
+/*
+ * Unmap all of the pages referenced by a kvec.  We release the pages,
+ * and unlock them if they were locked. 
+ */
+
+void unmap_kvec (struct kvec *vec, int dirtied)
+{
+	struct kveclet *veclet = vec->veclet;
+	struct kveclet *end = vec->veclet + vec->nr;
+	struct page *map = veclet->page;
+
+	prefetchw(map);
+	for (; veclet<end; map = (++veclet)->page) {
+		prefetchw(veclet[1].page);
+		if (likely(map != NULL) && !PageReserved(map)) {
+			if (dirtied) {
+				SetPageDirty(map);
+				flush_dcache_page(map);	/* FIXME */
+			}
+			__free_page(map);
+		}
+	}
+
+	atomic_sub(vec->max_nr, &user_pinned_pages);
+	vec->nr = 0;
+}
+
+void free_kvec(struct kvec *vec)
+{
+	if (unlikely(vec->nr))
+		BUG();
+	kfree(vec);
 }

--------------050903060105090308050609--

