Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSGCM0W>; Wed, 3 Jul 2002 08:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSGCM0V>; Wed, 3 Jul 2002 08:26:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316951AbSGCM0R>;
	Wed, 3 Jul 2002 08:26:17 -0400
Date: Wed, 3 Jul 2002 13:28:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Paul Menage <pmenage@ensim.com>
Cc: Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com,
       linux-fsdevel@ensim.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs()
Message-ID: <20020703132848.M27706@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.21.0207030208080.6472-100000@weyl.math.psu.edu> <E17Pf1Q-0004ip-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17Pf1Q-0004ip-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Wed, Jul 03, 2002 at 12:57:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 12:57:56AM -0700, Paul Menage wrote:
> All ->statfs() implementations have been modified to take the BKL,
> except for the following:
> 
> - those that don't reference any external mutable data:

... also adfs_statfs, 

> - those that already have their own locking:

... also affs_statfs, bfs_statfs, ext3_statfs, hfs_statfs, jffs2_statfs,
jfs_statfs

I think ufs_statfs needs lock_super() due to its handling of fragments.

qnx4 looks terribly broken for read-write anyway... probably just keep the
lock_kernel / unlock_kernel around the call to qnx4_count_free_blocks().

I haven't audited coda, hpfs, jffs, nfs, smbfs & udf.

-- 
Revolutions do not require corporate support.
