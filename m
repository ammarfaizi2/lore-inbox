Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWCMEPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWCMEPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWCMEPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:15:30 -0500
Received: from ns2.suse.de ([195.135.220.15]:15309 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751463AbWCMEP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:15:28 -0500
From: Neil Brown <neilb@suse.de>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
Date: Mon, 13 Mar 2006 15:14:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17428.61849.528648.270282@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 001 of 4] Update some VFS documentation fix
In-Reply-To: message from Avishay Traeger on Sunday March 12
References: <20060313104910.15881.patches@notabene>
	<1060312235316.15942@suse.de>
	<1142209357.14406.10.camel@ool-44c32f98.dyn.optonline.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 12, atraeger@cs.sunysb.edu wrote:
> Did a quick scan - some minor corrections in text.

Thanks. The following patch incorporated most of them.
I didn't fix the indenting oddity that you noticed.  The file is
wildly inconsistent in its uses of tabs or spaces for indenting.  That
should be fixed up in a separate patch.

Thanks.


-----------------
Corrections to recent updates for vfs.txt

Thanks Avishay Traeger <atraeger@cs.sunysb.edu>

Cc: Avishay Traeger <atraeger@cs.sunysb.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/filesystems/vfs.txt |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff ./Documentation/filesystems/vfs.txt~current~ ./Documentation/filesystems/vfs.txt
--- ./Documentation/filesystems/vfs.txt~current~	2006-03-13 10:58:13.000000000 +1100
+++ ./Documentation/filesystems/vfs.txt	2006-03-13 15:09:24.000000000 +1100
@@ -236,8 +236,9 @@ or bottom half).
  	contains a 'struct inode' embedded within it.
 
   destroy_inode: this method is called by destroy_inode() to release
-  	resources allocated for struct inode.  It is only required of
-  	->alloc_inode was defined and simply does a deallocate.
+  	resources allocated for struct inode.  It is only required if
+  	->alloc_inode was defined and simply undoes anything done by
+	->alloc_inode.
 
   read_inode: this method is called to read a specific inode from the
         mounted filesystem.  The i_ino member in the struct inode is
@@ -550,7 +551,7 @@ struct address_space_operations {
       wbc->sync_mode.
       The PG_Dirty flag has been cleared and PageLocked is true.
       writepage should start writeout, should set PG_Writeback,
-      and should make sure the page is Unlocked, either synchronously
+      and should make sure the page is unlocked, either synchronously
       or asynchronously when the write operation completes.
 
       If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
@@ -572,8 +573,8 @@ struct address_space_operations {
 
   sync_page: called by the VM to notify the backing store to perform all
   	queued I/O operations for a page. I/O operations for other pages
-	associated with this address_space object may also be
-  	performed.
+	associated with this address_space object may also be performed.
+
 	This function is optional and is called only for pages with
   	PG_Writeback set while waiting for the writeback to complete.
 
@@ -595,7 +596,7 @@ struct address_space_operations {
         PAGECACHE_TAG_DIRTY tag in the radix tree.
 
   readpages: called by the VM to read pages associated with the address_space
-  	object. This is essentailly just a vector version of
+  	object. This is essentially just a vector version of
   	readpage.  Instead of just one page, several pages are
   	requested.
 	readpages is only used for readahead, so read errors are
@@ -606,10 +607,10 @@ struct address_space_operations {
   	the given range of bytes are about to be written.  The
   	address_space should check that the write will be able to
   	complete, by allocating space if necessary and doing any other
-  	internal house keeping.  If the write will update parts some
-  	some basic-blocks on storage, then those blocks should be
+  	internal house keeping.  If the write will update parts of
+  	any basic-blocks on storage, then those blocks should be
   	pre-read (if they haven't been read already) so that the
-  	update will not leave half-blocks that need to be written out.
+  	updated blocks can be written out properly.
 	The page will be locked.  If prepare_write wants to unlock the
   	page it, like readpage, may do so and return
   	AOP_TRUNCATED_PAGE.
