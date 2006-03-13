Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWCMAWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCMAWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWCMAWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:22:50 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:4520 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751093AbWCMAWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:22:49 -0500
Subject: Re: [PATCH 001 of 4] Update some VFS documentation.
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1060312235316.15942@suse.de>
References: <20060313104910.15881.patches@notabene>
	 <1060312235316.15942@suse.de>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 19:22:37 -0500
Message-Id: <1142209357.14406.10.camel@ool-44c32f98.dyn.optonline.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did a quick scan - some minor corrections in text.

On Mon, 2006-03-13 at 10:53 +1100, NeilBrown wrote:
<snip>

>    destroy_inode: this method is called by destroy_inode() to release
> -  	resources allocated for struct inode.
> +  	resources allocated for struct inode.  It is only required of

"of" -> "if"

> +  	->alloc_inode was defined and simply does a deallocate. 

"simply does a deallocate" -> "undoes anything done by ->alloc_inode"

<snip>

> +The first can be used independantly to the others.  The vm can try to

"independantly" -> "independently"

<snip>

> -  writepage: called by the VM write a dirty page to backing store.
> +  writepage: called by the VM to write a dirty page to backing store.
> +      This may happen for data integrity reason (i.e. 'sync'), or
> +      to free up memory (flush).  The difference can be seen in
> +      wbc->sync_mode.
> +      The PG_Dirty flag has been cleared and PageLocked is true.
> +      writepage should start writeout, should set PG_Writeback,
> +      and should make sure the page is Unlocked, either synchronously

"Unlocked" -> "unlocked"

<snip>

>  
>    sync_page: called by the VM to notify the backing store to perform all
>    	queued I/O operations for a page. I/O operations for other pages
> -	associated with this address_space object may also be performed.
> +	associated with this address_space object may also be
> +  	performed.

Why did this line get split?

<snip>

>    set_page_dirty: called by the VM to set a page dirty.
> +        This is particularly needed if an address space attaches
> +        private data to a page, and that data needs to be updated when
> +        a page is dirtied.  This is called, for example, when a memory
> +	mapped page gets modified.
> +	If defined, it should set the PageDirty flag, and the
> +        PAGECACHE_TAG_DIRTY tag in the radix tree.

Indentation is off by one.

>    readpages: called by the VM to read pages associated with the address_space
> -  	object.
> +  	object. This is essentailly just a vector version of

"essentailly" -> "essentially"

> +  	readpage.  Instead of just one page, several pages are
> +  	requested.
> +	readpages is only used for readahead, so read errors are
> +  	ignored.  If anything goes wrong, feel free to give up.
>  
>    prepare_write: called by the generic write path in VM to set up a write
> -  	request for a page.
> -
> -  commit_write: called by the generic write path in VM to write page to
> -  	its backing store.
> +  	request for a page.  This indicates to the address space that
> +  	the given range of bytes are about to be written.  The
> +  	address_space should check that the write will be able to
> +  	complete, by allocating space if necessary and doing any other
> +  	internal house keeping.  If the write will update parts some
> +  	some basic-blocks on storage, then those blocks should be
> +  	pre-read (if they haven't been read already) so that the
> +  	update will not leave half-blocks that need to be written out.

"some" appears twice in a row in this last sentence.  Anyway, it is
confusing.  I would re-word it to something like:
"If the write will update partial storage blocks, those blocks should be
read at this point (if they haven't been already) so that the updated
blocks can be properly written out."

<snip>


Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

