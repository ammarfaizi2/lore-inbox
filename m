Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVDFLus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVDFLus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDFLup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:50:45 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:61887 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262176AbVDFLrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:47:07 -0400
Message-Id: <20050406114654.049702000@faui31y>
References: <20050406114610.287064000@faui31y>
Date: Wed, 06 Apr 2005 13:46:13 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/6] DocBook: fix some descriptions
Content-Disposition: inline; filename=docbook-fix-missing-desc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix some descriptions

Some KernelDoc descriptions are updated to match the current code.
No code changes.

Signed-off-by: Martin Waitz <tali@admingilde.org>

 drivers/acpi/scan.c     |    4 -
 drivers/base/platform.c |    4 -
 drivers/pci/hotplug.c   |    4 +
 drivers/pci/rom.c       |   14 +++---
 drivers/pnp/manager.c   |    2 
 fs/bio.c                |    2 
 fs/buffer.c             |   11 ++---
 fs/fs-writeback.c       |    4 +
 fs/mpage.c              |   92 ++++++++++++++++++++++----------------------
 fs/proc/base.c          |    2 
 fs/seq_file.c           |    9 +++-
 fs/sysfs/file.c         |    4 -
 include/linux/fs.h      |  100 ++++++++++++++++++++++++------------------------
 include/linux/skbuff.h  |    5 +-
 include/net/sock.h      |    1 
 kernel/sched.c          |    3 -
 kernel/sysctl.c         |    2 
 lib/kobject.c           |    3 -
 mm/filemap.c            |   17 ++++----
 mm/page-writeback.c     |    6 +-
 mm/truncate.c           |    4 -
 net/core/datagram.c     |    4 -
 22 files changed, 160 insertions(+), 137 deletions(-)

Index: linux-docbook/kernel/sysctl.c
===================================================================
--- linux-docbook.orig/kernel/sysctl.c	2005-04-06 12:12:50.869129883 +0200
+++ linux-docbook/kernel/sysctl.c	2005-04-06 12:25:15.526488679 +0200
@@ -1969,6 +1969,7 @@ int proc_dointvec_jiffies(ctl_table *tab
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1991,6 +1992,7 @@ int proc_dointvec_userhz_jiffies(ctl_tab
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: the current position in the file
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
Index: linux-docbook/lib/kobject.c
===================================================================
--- linux-docbook.orig/lib/kobject.c	2005-04-06 12:12:50.870129732 +0200
+++ linux-docbook/lib/kobject.c	2005-04-06 12:25:15.527488527 +0200
@@ -217,13 +217,12 @@ int kobject_register(struct kobject * ko
 /**
  *	kobject_set_name - Set the name of an object
  *	@kobj:	object.
- *	@name:	name. 
+ *	@fmt:	format string used to build the name
  *
  *	If strlen(name) >= KOBJ_NAME_LEN, then use a dynamically allocated
  *	string that @kobj->k_name points to. Otherwise, use the static 
  *	@kobj->name array.
  */
-
 int kobject_set_name(struct kobject * kobj, const char * fmt, ...)
 {
 	int error = 0;
Index: linux-docbook/kernel/sched.c
===================================================================
--- linux-docbook.orig/kernel/sched.c	2005-04-06 12:12:50.870129732 +0200
+++ linux-docbook/kernel/sched.c	2005-04-06 12:25:15.532487770 +0200
@@ -2906,6 +2906,7 @@ static void __wake_up_common(wait_queue_
  * @q: the waitqueue
  * @mode: which threads
  * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ * @key: is directly passed to the wakeup function
  */
 void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode,
 				int nr_exclusive, void *key)
@@ -2928,7 +2929,7 @@ void fastcall __wake_up_locked(wait_queu
 }
 
 /**
- * __wake_up - sync- wake up threads blocked on a waitqueue.
+ * __wake_up_sync - wake up threads blocked on a waitqueue.
  * @q: the waitqueue
  * @mode: which threads
  * @nr_exclusive: how many wake-one or wake-many threads to wake up
Index: linux-docbook/fs/buffer.c
===================================================================
--- linux-docbook.orig/fs/buffer.c	2005-04-06 12:12:50.875128976 +0200
+++ linux-docbook/fs/buffer.c	2005-04-06 12:25:15.536487165 +0200
@@ -774,15 +774,14 @@ repeat:
 /**
  * sync_mapping_buffers - write out and wait upon a mapping's "associated"
  *                        buffers
- * @buffer_mapping - the mapping which backs the buffers' data
- * @mapping - the mapping which wants those buffers written
+ * @mapping: the mapping which wants those buffers written
  *
  * Starts I/O against the buffers at mapping->private_list, and waits upon
  * that I/O.
  *
- * Basically, this is a convenience function for fsync().  @buffer_mapping is
- * the blockdev which "owns" the buffers and @mapping is a file or directory
- * which needs those buffers to be written for a successful fsync().
+ * Basically, this is a convenience function for fsync().
+ * @mapping is a file or directory which needs those buffers to be written for
+ * a successful fsync().
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
@@ -1263,6 +1262,7 @@ __getblk_slow(struct block_device *bdev,
 
 /**
  * mark_buffer_dirty - mark a buffer_head as needing writeout
+ * @bh: the buffer_head to mark dirty
  *
  * mark_buffer_dirty() will set the dirty bit against the buffer, then set its
  * backing page dirty, then tag the page as dirty in its address_space's radix
@@ -1501,6 +1501,7 @@ EXPORT_SYMBOL(__breadahead);
 
 /**
  *  __bread() - reads a specified block and returns the bh
+ *  @bdev: the block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  * 
Index: linux-docbook/drivers/pci/rom.c
===================================================================
--- linux-docbook.orig/drivers/pci/rom.c	2005-04-06 12:12:50.884127615 +0200
+++ linux-docbook/drivers/pci/rom.c	2005-04-06 12:25:15.537487014 +0200
@@ -14,7 +14,7 @@
 
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
- * @dev: PCI device to enable
+ * @pdev: PCI device to enable
  *
  * Enable ROM decoding on @dev.  This involves simply turning on the last
  * bit of the PCI ROM BAR.  Note that some cards may share address decoders
@@ -32,7 +32,7 @@ static void pci_enable_rom(struct pci_de
 
 /**
  * pci_disable_rom - disable ROM decoding for a PCI device
- * @dev: PCI device to disable
+ * @pdev: PCI device to disable
  *
  * Disable ROM decoding on a PCI device by turning off the last bit in the
  * ROM BAR.
@@ -47,7 +47,7 @@ static void pci_disable_rom(struct pci_d
 
 /**
  * pci_map_rom - map a PCI ROM to kernel space
- * @dev: pointer to pci device struct
+ * @pdev: pointer to pci device struct
  * @size: pointer to receive size of pci window over ROM
  * @return: kernel virtual pointer to image of ROM
  *
@@ -132,7 +132,7 @@ void __iomem *pci_map_rom(struct pci_dev
 
 /**
  * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
- * @dev: pointer to pci device struct
+ * @pdev: pointer to pci device struct
  * @size: pointer to receive size of pci window over ROM
  * @return: kernel virtual pointer to image of ROM
  *
@@ -166,7 +166,7 @@ void __iomem *pci_map_rom_copy(struct pc
 
 /**
  * pci_unmap_rom - unmap the ROM from kernel space
- * @dev: pointer to pci device struct
+ * @pdev: pointer to pci device struct
  * @rom: virtual address of the previous mapping
  *
  * Remove a mapping of a previously mapped ROM
@@ -187,7 +187,7 @@ void pci_unmap_rom(struct pci_dev *pdev,
 
 /**
  * pci_remove_rom - disable the ROM and remove its sysfs attribute
- * @dev: pointer to pci device struct
+ * @pdev: pointer to pci device struct
  *
  * Remove the rom file in sysfs and disable ROM decoding.
  */
@@ -206,7 +206,7 @@ void pci_remove_rom(struct pci_dev *pdev
 /**
  * pci_cleanup_rom - internal routine for freeing the ROM copy created
  * by pci_map_rom_copy called from remove.c
- * @dev: pointer to pci device struct
+ * @pdev: pointer to pci device struct
  *
  * Free the copied ROM if we allocated one.
  */
Index: linux-docbook/include/linux/skbuff.h
===================================================================
--- linux-docbook.orig/include/linux/skbuff.h	2005-04-06 12:24:11.954112753 +0200
+++ linux-docbook/include/linux/skbuff.h	2005-04-06 12:25:15.539486711 +0200
@@ -173,13 +173,14 @@ struct skb_shared_info {
  *	@h: Transport layer header
  *	@nh: Network layer header
  *	@mac: Link layer header
- *	@dst: FIXME: Describe this field
+ *	@dst: destination entry
+ *	@sp: the security path, used for xfrm
  *	@cb: Control buffer. Free for use by every layer. Put private vars here
  *	@len: Length of actual data
  *	@data_len: Data length
  *	@mac_len: Length of link layer header
  *	@csum: Checksum
- *	@__unused: Dead field, may be reused
+ *	@local_df: allow local fragmentation
  *	@cloned: Head may be cloned (check refcnt to be sure)
  *	@nohdr: Payload reference only, must not modify header
  *	@pkt_type: Packet class
Index: linux-docbook/include/linux/fs.h
===================================================================
--- linux-docbook.orig/include/linux/fs.h	2005-04-06 12:24:11.951113207 +0200
+++ linux-docbook/include/linux/fs.h	2005-04-06 12:25:15.542486257 +0200
@@ -1065,71 +1065,75 @@ int sync_inode(struct inode *inode, stru
  *    with a particular exported file system  - particularly enabling nfsd and
  *    the filesystem to co-operate when dealing with file handles.
  *
- *    export_operations contains two basic operation for dealing with file handles,
- *    decode_fh() and encode_fh(), and allows for some other operations to be defined
- *    which standard helper routines use to get specific information from the
- *    filesystem.
+ *    export_operations contains two basic operation for dealing with file
+ *    handles, decode_fh() and encode_fh(), and allows for some other
+ *    operations to be defined which standard helper routines use to get
+ *    specific information from the filesystem.
  *
  *    nfsd encodes information use to determine which filesystem a filehandle
- *    applies to in the initial part of the file handle.  The remainder, termed a
- *    file handle fragment, is controlled completely by the filesystem.
- *    The standard helper routines assume that this fragment will contain one or two
- *    sub-fragments, one which identifies the file, and one which may be used to
- *    identify the (a) directory containing the file.
+ *    applies to in the initial part of the file handle.  The remainder, termed
+ *    a file handle fragment, is controlled completely by the filesystem.  The
+ *    standard helper routines assume that this fragment will contain one or
+ *    two sub-fragments, one which identifies the file, and one which may be
+ *    used to identify the (a) directory containing the file.
  *
  *    In some situations, nfsd needs to get a dentry which is connected into a
- *    specific part of the file tree.  To allow for this, it passes the function
- *    acceptable() together with a @context which can be used to see if the dentry
- *    is acceptable.  As there can be multiple dentrys for a given file, the filesystem
- *    should check each one for acceptability before looking for the next.  As soon
- *    as an acceptable one is found, it should be returned.
+ *    specific part of the file tree.  To allow for this, it passes the
+ *    function acceptable() together with a @context which can be used to see
+ *    if the dentry is acceptable.  As there can be multiple dentrys for a
+ *    given file, the filesystem should check each one for acceptability before
+ *    looking for the next.  As soon as an acceptable one is found, it should
+ *    be returned.
  *
  * decode_fh:
- *    @decode_fh is given a &struct super_block (@sb), a file handle fragment (@fh, @fh_len)
- *    and an acceptability testing function (@acceptable, @context).  It should return
- *    a &struct dentry which refers to the same file that the file handle fragment refers
- *    to,  and which passes the acceptability test.  If it cannot, it should return
- *    a %NULL pointer if the file was found but no acceptable &dentries were available, or
- *    a %ERR_PTR error code indicating why it couldn't be found (e.g. %ENOENT or %ENOMEM).
+ *    @decode_fh is given a &struct super_block (@sb), a file handle fragment
+ *    (@fh, @fh_len) and an acceptability testing function (@acceptable,
+ *    @context).  It should return a &struct dentry which refers to the same
+ *    file that the file handle fragment refers to,  and which passes the
+ *    acceptability test.  If it cannot, it should return a %NULL pointer if
+ *    the file was found but no acceptable &dentries were available, or a
+ *    %ERR_PTR error code indicating why it couldn't be found (e.g. %ENOENT or
+ *    %ENOMEM).
  *
  * encode_fh:
- *    @encode_fh should store in the file handle fragment @fh (using at most @max_len bytes)
- *    information that can be used by @decode_fh to recover the file refered to by the
- *    &struct dentry @de.  If the @connectable flag is set, the encode_fh() should store
- *    sufficient information so that a good attempt can be made to find not only
- *    the file but also it's place in the filesystem.   This typically means storing
- *    a reference to de->d_parent in the filehandle fragment.
- *    encode_fh() should return the number of bytes stored or a negative error code
- *    such as %-ENOSPC
+ *    @encode_fh should store in the file handle fragment @fh (using at most
+ *    @max_len bytes) information that can be used by @decode_fh to recover the
+ *    file refered to by the &struct dentry @de.  If the @connectable flag is
+ *    set, the encode_fh() should store sufficient information so that a good
+ *    attempt can be made to find not only the file but also it's place in the
+ *    filesystem.   This typically means storing a reference to de->d_parent in
+ *    the filehandle fragment.  encode_fh() should return the number of bytes
+ *    stored or a negative error code such as %-ENOSPC
  *
  * get_name:
- *    @get_name should find a name for the given @child in the given @parent directory.
- *    The name should be stored in the @name (with the understanding that it is already
- *    pointing to a a %NAME_MAX+1 sized buffer.   get_name() should return %0 on success,
- *    a negative error code or error.
- *    @get_name will be called without @parent->i_sem held.
+ *    @get_name should find a name for the given @child in the given @parent
+ *    directory.  The name should be stored in the @name (with the
+ *    understanding that it is already pointing to a a %NAME_MAX+1 sized
+ *    buffer.   get_name() should return %0 on success, a negative error code
+ *    or error.  @get_name will be called without @parent->i_sem held.
  *
  * get_parent:
- *    @get_parent should find the parent directory for the given @child which is also
- *    a directory.  In the event that it cannot be found, or storage space cannot be
- *    allocated, a %ERR_PTR should be returned.
+ *    @get_parent should find the parent directory for the given @child which
+ *    is also a directory.  In the event that it cannot be found, or storage
+ *    space cannot be allocated, a %ERR_PTR should be returned.
  *
  * get_dentry:
- *    Given a &super_block (@sb) and a pointer to a file-system specific inode identifier,
- *    possibly an inode number, (@inump) get_dentry() should find the identified inode and
- *    return a dentry for that inode.
- *    Any suitable dentry can be returned including, if necessary, a new dentry created
- *    with d_alloc_root.  The caller can then find any other extant dentrys by following the
- *    d_alias links.  If a new dentry was created using d_alloc_root, DCACHE_NFSD_DISCONNECTED
- *    should be set, and the dentry should be d_rehash()ed.
+ *    Given a &super_block (@sb) and a pointer to a file-system specific inode
+ *    identifier, possibly an inode number, (@inump) get_dentry() should find
+ *    the identified inode and return a dentry for that inode.  Any suitable
+ *    dentry can be returned including, if necessary, a new dentry created with
+ *    d_alloc_root.  The caller can then find any other extant dentrys by
+ *    following the d_alias links.  If a new dentry was created using
+ *    d_alloc_root, DCACHE_NFSD_DISCONNECTED should be set, and the dentry
+ *    should be d_rehash()ed.
  *
- *    If the inode cannot be found, either a %NULL pointer or an %ERR_PTR code can be returned.
- *    The @inump will be whatever was passed to nfsd_find_fh_dentry() in either the
- *    @obj or @parent parameters.
+ *    If the inode cannot be found, either a %NULL pointer or an %ERR_PTR code
+ *    can be returned.  The @inump will be whatever was passed to
+ *    nfsd_find_fh_dentry() in either the @obj or @parent parameters.
  *
  * Locking rules:
- *  get_parent is called with child->d_inode->i_sem down
- *  get_name is not (which is possibly inconsistent)
+ *    get_parent is called with child->d_inode->i_sem down
+ *    get_name is not (which is possibly inconsistent)
  */
 
 struct export_operations {
Index: linux-docbook/net/core/datagram.c
===================================================================
--- linux-docbook.orig/net/core/datagram.c	2005-04-06 12:24:11.964111239 +0200
+++ linux-docbook/net/core/datagram.c	2005-04-06 12:25:15.543486105 +0200
@@ -203,7 +203,7 @@ void skb_free_datagram(struct sock *sk, 
  *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
  *	@skb: buffer to copy
  *	@offset: offset in the buffer to start copying from
- *	@iovec: io vector to copy to
+ *	@to: io vector to copy to
  *	@len: amount of data to copy from buffer to iovec
  *
  *	Note: the iovec is modified during the copy.
@@ -379,7 +379,7 @@ fault:
  *	skb_copy_and_csum_datagram_iovec - Copy and checkum skb to user iovec.
  *	@skb: skbuff
  *	@hlen: hardware length
- *	@iovec: io vector
+ *	@iov: io vector
  * 
  *	Caller _must_ check that skb will fit to this iovec.
  *
Index: linux-docbook/fs/mpage.c
===================================================================
--- linux-docbook.orig/fs/mpage.c	2005-04-06 12:12:50.874129127 +0200
+++ linux-docbook/fs/mpage.c	2005-04-06 12:25:15.545485803 +0200
@@ -160,52 +160,6 @@ map_buffer_to_page(struct page *page, st
 	} while (page_bh != head);
 }
 
-/**
- * mpage_readpages - populate an address space with some pages, and
- *                       start reads against them.
- *
- * @mapping: the address_space
- * @pages: The address of a list_head which contains the target pages.  These
- *   pages have their ->index populated and are otherwise uninitialised.
- *
- *   The page at @pages->prev has the lowest file offset, and reads should be
- *   issued in @pages->prev to @pages->next order.
- *
- * @nr_pages: The number of pages at *@pages
- * @get_block: The filesystem's block mapper function.
- *
- * This function walks the pages and the blocks within each page, building and
- * emitting large BIOs.
- *
- * If anything unusual happens, such as:
- *
- * - encountering a page which has buffers
- * - encountering a page which has a non-hole after a hole
- * - encountering a page with non-contiguous blocks
- *
- * then this code just gives up and calls the buffer_head-based read function.
- * It does handle a page which has holes at the end - that is a common case:
- * the end-of-file on blocksize < PAGE_CACHE_SIZE setups.
- *
- * BH_Boundary explanation:
- *
- * There is a problem.  The mpage read code assembles several pages, gets all
- * their disk mappings, and then submits them all.  That's fine, but obtaining
- * the disk mappings may require I/O.  Reads of indirect blocks, for example.
- *
- * So an mpage read of the first 16 blocks of an ext2 file will cause I/O to be
- * submitted in the following order:
- * 	12 0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16
- * because the indirect block has to be read to get the mappings of blocks
- * 13,14,15,16.  Obviously, this impacts performance.
- * 
- * So what we do it to allow the filesystem's get_block() function to set
- * BH_Boundary when it maps block 11.  BH_Boundary says: mapping of the block
- * after this one will require I/O against a block which is probably close to
- * this one.  So you should push what I/O you have currently accumulated.
- *
- * This all causes the disk requests to be issued in the correct order.
- */
 static struct bio *
 do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
 			sector_t *last_block_in_bio, get_block_t get_block)
@@ -320,6 +274,52 @@ confused:
 	goto out;
 }
 
+/**
+ * mpage_readpages - populate an address space with some pages, and
+ *                       start reads against them.
+ *
+ * @mapping: the address_space
+ * @pages: The address of a list_head which contains the target pages.  These
+ *   pages have their ->index populated and are otherwise uninitialised.
+ *
+ *   The page at @pages->prev has the lowest file offset, and reads should be
+ *   issued in @pages->prev to @pages->next order.
+ *
+ * @nr_pages: The number of pages at *@pages
+ * @get_block: The filesystem's block mapper function.
+ *
+ * This function walks the pages and the blocks within each page, building and
+ * emitting large BIOs.
+ *
+ * If anything unusual happens, such as:
+ *
+ * - encountering a page which has buffers
+ * - encountering a page which has a non-hole after a hole
+ * - encountering a page with non-contiguous blocks
+ *
+ * then this code just gives up and calls the buffer_head-based read function.
+ * It does handle a page which has holes at the end - that is a common case:
+ * the end-of-file on blocksize < PAGE_CACHE_SIZE setups.
+ *
+ * BH_Boundary explanation:
+ *
+ * There is a problem.  The mpage read code assembles several pages, gets all
+ * their disk mappings, and then submits them all.  That's fine, but obtaining
+ * the disk mappings may require I/O.  Reads of indirect blocks, for example.
+ *
+ * So an mpage read of the first 16 blocks of an ext2 file will cause I/O to be
+ * submitted in the following order:
+ * 	12 0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16
+ * because the indirect block has to be read to get the mappings of blocks
+ * 13,14,15,16.  Obviously, this impacts performance.
+ * 
+ * So what we do it to allow the filesystem's get_block() function to set
+ * BH_Boundary when it maps block 11.  BH_Boundary says: mapping of the block
+ * after this one will require I/O against a block which is probably close to
+ * this one.  So you should push what I/O you have currently accumulated.
+ *
+ * This all causes the disk requests to be issued in the correct order.
+ */
 int
 mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block)
Index: linux-docbook/include/net/sock.h
===================================================================
--- linux-docbook.orig/include/net/sock.h	2005-04-06 12:24:11.956112450 +0200
+++ linux-docbook/include/net/sock.h	2005-04-06 12:25:15.546485651 +0200
@@ -161,6 +161,7 @@ struct sock_common {
   *	@sk_sndmsg_page: cached page for sendmsg
   *	@sk_sndmsg_off: cached offset for sendmsg
   *	@sk_send_head: front of stuff to transmit
+  *	@sk_security: used by security modules
   *	@sk_write_pending: a write to stream socket waits to start
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
Index: linux-docbook/fs/fs-writeback.c
===================================================================
--- linux-docbook.orig/fs/fs-writeback.c	2005-04-06 12:12:50.877128674 +0200
+++ linux-docbook/fs/fs-writeback.c	2005-04-06 12:25:15.548485349 +0200
@@ -512,7 +512,8 @@ restart:
 }
 
 /**
- * sync_inodes
+ * sync_inodes - writes all inodes to disk
+ * @wait: wait for completion
  *
  * sync_inodes() goes through each super block's dirty inode list, writes the
  * inodes out, waits on the writeout and puts the inodes back on the normal
@@ -604,6 +605,7 @@ EXPORT_SYMBOL(sync_inode);
 /**
  * generic_osync_inode - flush all dirty data for a given inode to disk
  * @inode: inode to write
+ * @mapping: the address_space that should be flushed
  * @what:  what to write and wait upon
  *
  * This can be called by file_write functions for files which have the
Index: linux-docbook/fs/seq_file.c
===================================================================
--- linux-docbook.orig/fs/seq_file.c	2005-04-06 12:12:50.876128825 +0200
+++ linux-docbook/fs/seq_file.c	2005-04-06 12:25:15.548485349 +0200
@@ -51,7 +51,10 @@ EXPORT_SYMBOL(seq_open);
 
 /**
  *	seq_read -	->read() method for sequential files.
- *	@file, @buf, @size, @ppos: see file_operations method
+ *	@file: the file to read from
+ *	@buf: the buffer to read to
+ *	@size: the maximum number of bytes to read
+ *	@ppos: the current position in the file
  *
  *	Ready-made ->f_op->read()
  */
@@ -219,7 +222,9 @@ Eoverflow:
 
 /**
  *	seq_lseek -	->llseek() method for sequential files.
- *	@file, @offset, @origin: see file_operations method
+ *	@file: the file in question
+ *	@offset: new position
+ *	@origin: 0 for absolute, 1 for relative position
  *
  *	Ready-made ->f_op->llseek()
  */
Index: linux-docbook/mm/page-writeback.c
===================================================================
--- linux-docbook.orig/mm/page-writeback.c	2005-04-06 12:12:50.872129430 +0200
+++ linux-docbook/mm/page-writeback.c	2005-04-06 12:25:15.550485046 +0200
@@ -255,7 +255,7 @@ static void balance_dirty_pages(struct a
 
 /**
  * balance_dirty_pages_ratelimited - balance dirty memory state
- * @mapping - address_space which was dirtied
+ * @mapping: address_space which was dirtied
  *
  * Processes which are dirtying memory should call in here once for each page
  * which was newly dirtied.  The function will periodically check the system's
@@ -562,8 +562,8 @@ int do_writepages(struct address_space *
 /**
  * write_one_page - write out a single page and optionally wait on I/O
  *
- * @page - the page to write
- * @wait - if true, wait on writeout
+ * @page: the page to write
+ * @wait: if true, wait on writeout
  *
  * The page must be locked by the caller and will be unlocked upon return.
  *
Index: linux-docbook/drivers/pnp/manager.c
===================================================================
--- linux-docbook.orig/drivers/pnp/manager.c	2005-04-06 12:12:50.887127162 +0200
+++ linux-docbook/drivers/pnp/manager.c	2005-04-06 12:25:15.551484894 +0200
@@ -253,7 +253,7 @@ void pnp_init_resource_table(struct pnp_
 
 /**
  * pnp_clean_resources - clears resources that were not manually set
- * @res - the resources to clean
+ * @res: the resources to clean
  *
  */
 static void pnp_clean_resource_table(struct pnp_resource_table * res)
Index: linux-docbook/fs/bio.c
===================================================================
--- linux-docbook.orig/fs/bio.c	2005-04-06 12:12:50.876128825 +0200
+++ linux-docbook/fs/bio.c	2005-04-06 12:25:15.552484743 +0200
@@ -140,6 +140,7 @@ inline void bio_init(struct bio *bio)
  * bio_alloc_bioset - allocate a bio for I/O
  * @gfp_mask:   the GFP_ mask given to the slab allocator
  * @nr_iovecs:	number of iovecs to pre-allocate
+ * @bs:		the bio_set to allocate from
  *
  * Description:
  *   bio_alloc_bioset will first try it's on mempool to satisfy the allocation.
@@ -629,6 +630,7 @@ out:
 
 /**
  *	bio_map_user	-	map user address into bio
+ *	@q: the request_queue_t for the bio
  *	@bdev: destination block device
  *	@uaddr: start of user address
  *	@len: length in bytes
Index: linux-docbook/fs/sysfs/file.c
===================================================================
--- linux-docbook.orig/fs/sysfs/file.c	2005-04-06 12:12:50.877128674 +0200
+++ linux-docbook/fs/sysfs/file.c	2005-04-06 12:25:15.553484592 +0200
@@ -96,7 +96,7 @@ static int fill_read_buffer(struct dentr
 /**
  *	flush_read_buffer - push buffer to userspace.
  *	@buffer:	data buffer for file.
- *	@userbuf:	user-passed buffer.
+ *	@buf:		user-passed buffer.
  *	@count:		number of bytes requested.
  *	@ppos:		file position.
  *
@@ -164,7 +164,7 @@ out:
 /**
  *	fill_write_buffer - copy buffer from userspace.
  *	@buffer:	data buffer for file.
- *	@userbuf:	data from user.
+ *	@buf:		data from user.
  *	@count:		number of bytes in @userbuf.
  *
  *	Allocate @buffer->page if it hasn't been already, then
Index: linux-docbook/fs/proc/base.c
===================================================================
--- linux-docbook.orig/fs/proc/base.c	2005-04-06 12:24:11.948113661 +0200
+++ linux-docbook/fs/proc/base.c	2005-04-06 12:25:15.555484289 +0200
@@ -1740,7 +1740,7 @@ struct dentry *proc_pid_unhash(struct ta
 
 /**
  * proc_pid_flush - recover memory used by stale /proc/@pid/x entries
- * @proc_entry: directoy to prune.
+ * @proc_dentry: directoy to prune.
  *
  * Shrink the /proc directory that was used by the just killed thread.
  */
Index: linux-docbook/mm/truncate.c
===================================================================
--- linux-docbook.orig/mm/truncate.c	2005-04-06 12:12:50.872129430 +0200
+++ linux-docbook/mm/truncate.c	2005-04-06 12:25:15.556484138 +0200
@@ -242,7 +242,7 @@ EXPORT_SYMBOL(invalidate_inode_pages);
 
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
- * @mapping - the address_space
+ * @mapping: the address_space
  * @start: the page offset 'from' which to invalidate
  * @end: the page offset 'to' which to invalidate (inclusive)
  *
@@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(invalidate_inode_pages
 
 /**
  * invalidate_inode_pages2 - remove all pages from an address_space
- * @mapping - the address_space
+ * @mapping: the address_space
  *
  * Any pages which are found to be mapped into pagetables are unmapped prior to
  * invalidation.
Index: linux-docbook/drivers/pci/hotplug.c
===================================================================
--- linux-docbook.orig/drivers/pci/hotplug.c	2005-04-06 12:12:50.883127766 +0200
+++ linux-docbook/drivers/pci/hotplug.c	2005-04-06 12:25:15.557483986 +0200
@@ -120,6 +120,10 @@ static int pci_visit_bridge (struct pci_
 
 /**
  * pci_visit_dev - scans the pci buses.
+ * @fn: callback functions that are called while visiting
+ * @wrapped_dev: the device to scan
+ * @wrapped_parent: the bus where @wrapped_dev is connected to
+ *
  * Every bus and every function is presented to a custom
  * function that can act upon it.
  */
Index: linux-docbook/drivers/base/platform.c
===================================================================
--- linux-docbook.orig/drivers/base/platform.c	2005-04-06 12:12:50.885127464 +0200
+++ linux-docbook/drivers/base/platform.c	2005-04-06 12:25:15.558483835 +0200
@@ -115,7 +115,7 @@ int platform_add_devices(struct platform
 
 /**
  *	platform_device_register - add a platform-level device
- *	@dev:	platform device we're adding
+ *	@pdev:	platform device we're adding
  *
  */
 int platform_device_register(struct platform_device * pdev)
@@ -174,7 +174,7 @@ int platform_device_register(struct plat
 
 /**
  *	platform_device_unregister - remove a platform-level device
- *	@dev:	platform device we're removing
+ *	@pdev:	platform device we're removing
  *
  *	Note that this function will also release all memory- and port-based
  *	resources owned by the device (@dev->resource).
Index: linux-docbook/mm/filemap.c
===================================================================
--- linux-docbook.orig/mm/filemap.c	2005-04-06 12:12:50.871129581 +0200
+++ linux-docbook/mm/filemap.c	2005-04-06 12:25:15.561483381 +0200
@@ -152,9 +152,10 @@ static int sync_page(void *word)
 /**
  * filemap_fdatawrite_range - start writeback against all of a mapping's
  * dirty pages that lie within the byte offsets <start, end>
- * @mapping: address space structure to write
- * @start: offset in bytes where the range starts
- * @end : offset in bytes where the range ends
+ * @mapping:	address space structure to write
+ * @start:	offset in bytes where the range starts
+ * @end:	offset in bytes where the range ends
+ * @sync_mode:	enable synchronous operation
  *
  * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
  * opposed to a regular memory * cleansing writeback.  The difference between
@@ -518,8 +519,8 @@ EXPORT_SYMBOL(find_trylock_page);
 /**
  * find_lock_page - locate, pin and lock a pagecache page
  *
- * @mapping - the address_space to search
- * @offset - the page index
+ * @mapping: the address_space to search
+ * @offset: the page index
  *
  * Locates the desired pagecache page, locks it, increments its reference
  * count and returns its address.
@@ -558,9 +559,9 @@ EXPORT_SYMBOL(find_lock_page);
 /**
  * find_or_create_page - locate or add a pagecache page
  *
- * @mapping - the page's address_space
- * @index - the page's index into the mapping
- * @gfp_mask - page allocation mode
+ * @mapping: the page's address_space
+ * @index: the page's index into the mapping
+ * @gfp_mask: page allocation mode
  *
  * Locates a page in the pagecache.  If the page is not present, a new page
  * is allocated using @gfp_mask and is added to the pagecache and to the VM's
Index: linux-docbook/drivers/acpi/scan.c
===================================================================
--- linux-docbook.orig/drivers/acpi/scan.c	2005-04-06 12:12:50.886127313 +0200
+++ linux-docbook/drivers/acpi/scan.c	2005-04-06 12:25:15.562483229 +0200
@@ -379,8 +379,8 @@ ACPI_DEVICE_ATTR(eject, 0200, NULL, acpi
 
 /**
  * setup_sys_fs_device_files - sets up the device files under device namespace
- * @@dev:	acpi_device object
- * @@func:	function pointer to create or destroy the device file
+ * @dev:	acpi_device object
+ * @func:	function pointer to create or destroy the device file
  */
 static void
 setup_sys_fs_device_files (

--
Martin Waitz
