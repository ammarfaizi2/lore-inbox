Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWHAJDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWHAJDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWHAJDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:03:37 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:34398 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S1751341AbWHAJDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:03:36 -0400
Date: Tue, 1 Aug 2006 11:03:00 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/30] VFS: Destroy the dentries contributed by a superblock on unmounting [try #11]
Message-ID: <20060801090259.GB10032@X40.localnet>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> <20060727205333.8443.97943.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727205333.8443.97943.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, David Howells wrote:

> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 44605be..63f64a9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -230,6 +230,7 @@ extern struct dentry * d_alloc_anon(stru
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  extern void shrink_dcache_sb(struct super_block *);
>  extern void shrink_dcache_parent(struct dentry *);
> +extern void shrink_dcache_for_umount(struct super_block *);
>  extern int d_invalidate(struct dentry *);
>  
>  /* only used at mount-time */

I don't see the point that we need two different versions of
shrink_dcache_sb(). IMHO it is better to fix shrink_dcache_for_umount() so
that it is a replacement for shrink_dcache_sb().

BTW: Talking about shrink_dcache_sb(): is it really necessary to call
shrink_dcache_sb() when remounting a filesystem? The only reason I can see are
changes to the lookup mechanism (hash algorithm etc) but a quick look into the
different filesystems forbid the change of this options during remount.

Jan
