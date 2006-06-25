Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWFYT2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFYT2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFYT2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:28:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWFYT2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:28:46 -0400
Date: Sun, 25 Jun 2006 12:28:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Subject: Re: [GIT] Please pull NFS updates...
In-Reply-To: <1151232744.13127.40.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0606251218500.3747@g5.osdl.org>
References: <1151232744.13127.40.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jun 2006, Trond Myklebust wrote:
> 
> Please pull from the repository at
> 
>    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This is broken.

	  CC      fs/nfs/nfs2xdr.o
	In file included from fs/nfs/nfs2xdr.c:28:
	fs/nfs/internal.h:7: error: redefinition of 'struct nfs_clone_mount'
	fs/nfs/internal.h:99: error: redefinition of 'nfs4_path'
	fs/nfs/internal.h:99: error: previous definition of 'nfs4_path' was here
	fs/nfs/internal.h:113: error: redefinition of 'nfs_devname'
	fs/nfs/internal.h:113: error: previous definition of 'nfs_devname' was here
	fs/nfs/internal.h:122: error: redefinition of 'nfs_block_bits'
	fs/nfs/internal.h:122: error: previous definition of 'nfs_block_bits' was here
	fs/nfs/internal.h:141: error: redefinition of 'nfs_calc_block_size'
	fs/nfs/internal.h:141: error: previous definition of 'nfs_calc_block_size' was here
	fs/nfs/internal.h:151: error: redefinition of 'nfs_block_size'
	fs/nfs/internal.h:151: error: previous definition of 'nfs_block_size' was here
	fs/nfs/internal.h:165: error: redefinition of 'nfs_super_set_maxbytes'
	fs/nfs/internal.h:165: error: previous definition of 'nfs_super_set_maxbytes' was here
	fs/nfs/internal.h:175: error: redefinition of 'valid_ipaddr4'
	fs/nfs/internal.h:175: error: previous definition of 'valid_ipaddr4' was here
	make[2]: *** [fs/nfs/nfs2xdr.o] Error 1
	make[1]: *** [fs/nfs] Error 2
	make: *** [fs] Error 2

Looks like a merge error, causing that "internal.h" file to be included
twice. 

Alternatively, you're applying patches without "--fuzz=0", which allowed
Andrew's "git-nfs-build-fixes" patch to be applied wice.

In either case, it came from your tree, and had apparently never even
been compile-tested. 

Tssk, tssk..

		Linus
