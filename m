Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWKOLXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWKOLXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWKOLXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:23:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932838AbWKOLXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:23:35 -0500
Message-ID: <455AF8A7.3020204@RedHat.com>
Date: Wed, 15 Nov 2006 06:23:19 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el4 SeaMonkey/1.0.5
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH 06/19] FS-Cache: NFS: Only obtain cache cookies on file
 open, not on inode read
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200634.12943.6815.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200634.12943.6815.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Howells wrote:
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 5ead2bf..b2e5e86 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -205,6 +205,7 @@ #define NFS_INO_REVALIDATING	(0)		/* rev
>  #define NFS_INO_ADVISE_RDPLUS	(1)		/* advise readdirplus */
>  #define NFS_INO_STALE		(2)		/* possible stale inode */
>  #define NFS_INO_ACL_LRU_SET	(3)		/* Inode is on the LRU list */
> +#define NFS_INO_CACHEABLE	(4)		/* inode can be cached by FS-Cache */
>  
>  static inline struct nfs_inode *NFS_I(struct inode *inode)
>  {
> @@ -230,6 +231,7 @@ #define NFS_ATTRTIMEO_UPDATE(inode)	(NFS
>  
>  #define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
>  #define NFS_STALE(inode)		(test_bit(NFS_INO_STALE, &NFS_FLAGS(inode)))
> +#define NFS_CACHEABLE(inode)		(test_bit(NFS_INO_CACHEABLE, &NFS_FLAGS(inode)))
A small nit..

To stay with the coding style NFS uses, could you please changes
these variables to:

+#define NFS_INO_FSCACHE	(4)		/* inode can be cached by FS-Cache */
and
+#define NFS_FSCACHE(inode)		(test_bit(NFS_INO_FSCACHE, &NFS_FLAGS(inode))


steved.
