Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWCVKxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWCVKxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCVKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:53:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWCVKxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:53:44 -0500
Date: Wed, 22 Mar 2006 02:50:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: VFS: Convert abuses of sector_t
Message-Id: <20060322025025.662999e9.akpm@osdl.org>
In-Reply-To: <1142961196.7987.17.camel@lade.trondhjem.org>
References: <1142961196.7987.17.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> From: Trond Myklebust <Trond.Myklebust@netapp.com>
> 
> The type "sector_t" is heavily tied in to the block layer interface as an
> offset/handle to a block, and is subject to a supposedly block-specific
> configuration option: CONFIG_LBD. Despite this, it is used in struct
> kstatfs to save a couple of bytes on the stack whenever we call the
> filesystems' ->statfs().
> 
> One consequence is that networked filesystems may break if CONFIG_LBD is
> not set, since it is quite common to have multi-TB remote filesystems.
> 
> The following patch just converts struct kstatfs to use the standard type u64.
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
> 
>  include/linux/statfs.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index ad83a2b..b34cc82 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -8,11 +8,11 @@
>  struct kstatfs {
>  	long f_type;
>  	long f_bsize;
> -	sector_t f_blocks;
> -	sector_t f_bfree;
> -	sector_t f_bavail;
> -	sector_t f_files;
> -	sector_t f_ffree;
> +	u64 f_blocks;
> +	u64 f_bfree;
> +	u64 f_bavail;
> +	u64 f_files;
> +	u64 f_ffree;
>  	__kernel_fsid_t f_fsid;
>  	long f_namelen;
>  	long f_frsize;

This change also appears (for different reasons) in
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/2tb-files-change-type-of-kstatfs-entries.patch,
so we should be OK.
