Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWCXFxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWCXFxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCXFxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:53:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32409 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932524AbWCXFxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:53:13 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 16:51:04 +1100
Message-Id: <1060324055104.2268@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] More corrections to vfs.txt update
References: <20060324165031.2250.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks "Randy.Dunlap" <rdunlap@xenotime.net>

Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/filesystems/vfs.txt |   50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff ./Documentation/filesystems/vfs.txt~current~ ./Documentation/filesystems/vfs.txt
--- ./Documentation/filesystems/vfs.txt~current~	2006-03-24 12:06:14.000000000 +1100
+++ ./Documentation/filesystems/vfs.txt	2006-03-24 12:07:53.000000000 +1100
@@ -458,7 +458,7 @@ address-space can provide.  These includ
 pressure, page lookup by address, and keeping track of pages tagged as
 Dirty or Writeback.
 
-The first can be used independantly to the others.  The vm can try to
+The first can be used independently to the others.  The VM can try to
 either write dirty pages in order to clean them, or release clean
 pages in order to reuse them.  To do this it can call the ->writepage
 method on dirty pages, and ->releasepage on clean pages with
@@ -466,7 +466,7 @@ PagePrivate set. Clean pages without Pag
 references will be released without notice being given to the
 address_space.
 
-To achieve this functionality, pages need to be placed on an lru with
+To achieve this functionality, pages need to be placed on an LRU with
 lru_cache_add and mark_page_active needs to be called whenever the
 page is used.
 
@@ -478,20 +478,20 @@ quickly.
 The Dirty tag is primarily used by mpage_writepages - the default
 ->writepages method.  It uses the tag to find dirty pages to call
 ->writepage on.  If mpage_writepages is not used (i.e. the address
-provides it's own ->writepages) , the PAGECACHE_TAG_DIRTY tag is
+provides its own ->writepages) , the PAGECACHE_TAG_DIRTY tag is
 almost unused.  write_inode_now and sync_inode do use it (through
 __sync_single_inode) to check if ->writepages has been successful in
 writing out the whole address_space.
 
 The Writeback tag is used by filemap*wait* and sync_page* functions,
-though wait_on_page_writeback_range, to wait for all writeback to
+via wait_on_page_writeback_range, to wait for all writeback to
 complete.  While waiting ->sync_page (if defined) will be called on
-each page that is found to require writeback
+each page that is found to require writeback.
 
 An address_space handler may attach extra information to a page,
 typically using the 'private' field in the 'struct page'.  If such
 information is attached, the PG_Private flag should be set.  This will
-cause various mm routines to make extra calls into the address_space
+cause various VM routines to make extra calls into the address_space
 handler to deal with that data.
 
 An address space acts as an intermediate between storage and
@@ -500,7 +500,7 @@ time, and provided to the application ei
 or by memory-mapping the page.
 Data is written into the address space by the application, and then
 written-back to storage typically in whole pages, however the
-address_space has finner control of write sizes.
+address_space has finer control of write sizes.
 
 The read process essentially only requires 'readpage'.  The write
 process is more complicated and uses prepare_write/commit_write or
@@ -546,7 +546,7 @@ struct address_space_operations {
 };
 
   writepage: called by the VM to write a dirty page to backing store.
-      This may happen for data integrity reason (i.e. 'sync'), or
+      This may happen for data integrity reasons (i.e. 'sync'), or
       to free up memory (flush).  The difference can be seen in
       wbc->sync_mode.
       The PG_Dirty flag has been cleared and PageLocked is true.
@@ -555,10 +555,10 @@ struct address_space_operations {
       or asynchronously when the write operation completes.
 
       If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
-      try too hard if there are problems, and may choose to write out a
-      different page from the mapping if that would be more
-      appropriate.  If it chooses not to start writeout, it should
-      return AOP_WRITEPAGE_ACTIVATE so that the VM will not keep
+      try too hard if there are problems, and may choose to write out
+      other pages from the mapping if that is easier (e.g. due to
+      internal dependencies).  If it chooses not to start writeout, it
+      should return AOP_WRITEPAGE_ACTIVATE so that the VM will not keep
       calling ->writepage on that page.
 
       See the file "Locking" for more details.
@@ -568,7 +568,7 @@ struct address_space_operations {
        unlocked and marked uptodate once the read completes.
        If ->readpage discovers that it needs to unlock the page for
        some reason, it can do so, and then return AOP_TRUNCATED_PAGE.
-       In this case, the page will be re-located, re-locked and if
+       In this case, the page will be relocated, relocked and if
        that all succeeds, ->readpage will be called again.
 
   sync_page: called by the VM to notify the backing store to perform all
@@ -579,12 +579,12 @@ struct address_space_operations {
   	PG_Writeback set while waiting for the writeback to complete.
 
   writepages: called by the VM to write out pages associated with the
-  	address_space object.  If WBC_SYNC_ALL, then the
-  	writeback_control will specify a range of pages that must be
-  	written out.  If WBC_SYNC_NONE, then a nr_to_write is given
+  	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
+  	the writeback_control will specify a range of pages that must be
+  	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
 	and that many pages should be written if possible.
 	If no ->writepages is given, then mpage_writepages is used
-  	instead.  This will choose pages from the addresspace that are
+  	instead.  This will choose pages from the address space that are
   	tagged as DIRTY and will pass them to ->writepage.
 
   set_page_dirty: called by the VM to set a page dirty.
@@ -599,15 +599,15 @@ struct address_space_operations {
   	object. This is essentially just a vector version of
   	readpage.  Instead of just one page, several pages are
   	requested.
-	readpages is only used for readahead, so read errors are
+	readpages is only used for read-ahead, so read errors are
   	ignored.  If anything goes wrong, feel free to give up.
 
   prepare_write: called by the generic write path in VM to set up a write
   	request for a page.  This indicates to the address space that
-  	the given range of bytes are about to be written.  The
+  	the given range of bytes is about to be written.  The
   	address_space should check that the write will be able to
   	complete, by allocating space if necessary and doing any other
-  	internal house keeping.  If the write will update parts of
+  	internal housekeeping.  If the write will update parts of
   	any basic-blocks on storage, then those blocks should be
   	pre-read (if they haven't been read already) so that the
   	updated blocks can be written out properly.
@@ -625,9 +625,9 @@ struct address_space_operations {
         errors should have been handled by prepare_write.
 
   bmap: called by the VFS to map a logical block offset within object to
-  	physical block number. This method is used by for the FIBMAP
+  	physical block number. This method is used by the FIBMAP
   	ioctl and for working with swap-files.  To be able to swap to
-  	a file, the file must have as stable mapping to a block
+  	a file, the file must have a stable mapping to a block
   	device.  The swap system does not go through the filesystem
   	but instead uses bmap to find out where the blocks in the file
   	are and uses those addresses directly.
@@ -635,7 +635,7 @@ struct address_space_operations {
 
   invalidatepage: If a page has PagePrivate set, then invalidatepage
         will be called when part or all of the page is to be removed
-	from the address space.  This generally corresponds either a
+	from the address space.  This generally corresponds to either a
 	truncation or a complete invalidation of the address space
 	(in the latter case 'offset' will always be 0).
 	Any private data associated with the page should be updated
@@ -663,13 +663,13 @@ struct address_space_operations {
         they believe the cache may be out of date with storage) by
         calling invalidate_inode_pages2().
 	If the filesystem makes such a call, and needs to be certain
-        that all pages are invalidated, then it's releasepage will
+        that all pages are invalidated, then its releasepage will
         need to ensure this.  Possibly it can clear the PageUptodate
         bit if it cannot free private data yet.
 
   direct_IO: called by the generic read/write routines to perform
         direct_IO - that is IO requests which bypass the page cache
-        and tranfer data directly between the storage and the
+        and transfer data directly between the storage and the
         application's address space.
 
   get_xip_page: called by the VM to translate a block number to a page.
