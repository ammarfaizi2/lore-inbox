Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWISJfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWISJfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWISJfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:35:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751832AbWISJfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:35:23 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060918191050.GA20392@infradead.org> 
References: <20060918191050.GA20392@infradead.org>  <44C9D0FE.9090004@garzik.org> <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> <20397.1157649444@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       trond.myklebust@fys.uio.no, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, tburke@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: FS-Cache patches 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 19 Sep 2006 10:34:37 +0100
Message-ID: <24436.1158658477@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Any reason the 64bit inode patches are included here?

Sorry, that's just my complete NFS patchset that I use for waving in front of
interesting parties.  Various people know about that tarball and download it
and play with it.

Feel free to ignore 1-3 and 12-16.

> I'll take a look at the actual interesting patches ASAP.  Could you please
> get all those simpler bits into -mm and resend everything else as a patch
> against -mm?

They're _all_ in -mm, I believe.

 (*) Prerequisite AFS and NFS changes:

git-nfs.patch
nfs-replace-null-dentries-that-appear-in-readdirs-list-2.patch
afs-add-lock-annotations-to-afs_proc_cell_servers_startstop.patch

 (*) General prerequisite stuff for AFS an NFS:

fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
fs-cache-release-page-private-in-failed-readahead.patch
fs-cache-release-page-private-after-failed-readahead-12.patch

 (*) FS-Cache itself:

fs-cache-generic-filesystem-caching-facility.patch

 (*) Make AFS use the cache:

fs-cache-make-kafs-use-fs-cache.patch
fs-cache-make-kafs-use-fs-cache-fix.patch
fs-cache-make-kafs-use-fs-cache-12.patch
fs-cache-make-kafs-use-fs-cache-12-fix.patch
fs-cache-make-kafs-use-fs-cache-vs-streamline-generic_file_-interfaces-and-filemap.patch

 (*) Make NFS use the cache:

nfs-use-local-caching.patch
nfs-use-local-caching-12.patch
nfs-use-local-caching-12-fix.patch

 (*) The CacheFiles cache backend:

fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-printk-format-warning.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-cachefiles_write_page-shouldnt-indicate-error-twice.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-handle-enospc-on-create-mkdir-better.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-inode-count-maintenance.patch

 (*) Plus copy_page() exports:

add-missing-page_copy-export-for-ppc-and-powerpc.patch
fs-cache-cachefiles-ia64-missing-copy_page-export.patch

 (*) Plus 64-bit inode numbers:

vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers.patch
vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-alpha-fix.patch
nfs-represent-64-bit-fileids-as-64-bit-inode-numbers-on-32-bit-systems.patch

 (*) Plus dentry squishing:

autofs-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
reiserfs-make-sure-all-dentries-refs-are-released-before-calling-kill_block_super-try-2.patch
vfs-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch


David
