Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129711AbRBTQdA>; Tue, 20 Feb 2001 11:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTQcv>; Tue, 20 Feb 2001 11:32:51 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:38090 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129711AbRBTQcm>; Tue, 20 Feb 2001 11:32:42 -0500
Date: Tue, 20 Feb 2001 17:26:36 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dek_ml@konerding.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net, mason@suse.com
Subject: Re: [NFS] Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: <14994.35407.280038.934149@charged.uio.no>
Message-ID: <Pine.GSO.4.10.10102201632210.1090-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Feb 2001, Trond Myklebust wrote:

> If I read the code correctly, we set the dentry d_flag
> DCACHE_NFSD_DISCONNECTED on such dummy dentries.  We only force a
> lookup of the full path if the inode represents a directory or the
> NFSEXP_NOSUBTREECHECK export flag is not set.

IMO you can't safely delay the release of the dummy entry without help of
vfs. Are these dummy entries always properly released?
It seems I forgot about the subtree check, so it seems a fs that can't
provide a get_parent, can only be exported completely?

> It doesn't seem like a major change to delay that full path lookup of
> the dentry until nfsd_lookup('..') is actually called (in the case
> where the 'subtree_check' flag isn't used).
> However, outright banning lookups of '..' by any one filesystem isn't
> an option: path lookups are used for a lot more than just
> `getcwd'. Imagine for instance trying to follow a relative soft link
> across such a filesystem.

AFAIK this is already done in the generic code (in path_walk(), which is 
also called by vfs_follow_link()).

bye, Roman

