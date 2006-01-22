Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWAVVDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWAVVDN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWAVVDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:03:13 -0500
Received: from thunk.org ([69.25.196.29]:37838 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751359AbWAVVDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:03:12 -0500
Date: Sun, 22 Jan 2006 13:31:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, sho@tnes.nec.co.jp,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060122183128.GB7082@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>,
	Andreas Dilger <adilger@clusterfs.com>, sho@tnes.nec.co.jp,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp> <20060118185249.GN4124@schatzie.adilger.int> <20060120231016.40b40fd7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120231016.40b40fd7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:10:16PM -0800, Andrew Morton wrote:
> Andreas Dilger <adilger@clusterfs.com> wrote:
> > Just for others' info - the fill_super change has been tested in the past
> > by Sonny Rao at IBM also.  e2fsprogs has supported this for a long time
> > already.
> 
> I have a vague memory that there's some piece of metadata (per-block-group
> info, I think) which will overflow at 8kb blocksize.  I say this in the
> hope that you'll remmeber what it was ;)

The limiting factor is bg_free_blocks_count (and to some extent,
possibly bg_free_inodes_dir), which is a 16 bit field.  At 8kb, the
default block group size is 8kb * 8 bits/byte == 65536.  At 16kb, a
block group size of 131072 would overflow bg_free_blocks_count.  You
could of course artificially limit the block group size to 65536 for
block sizes > 16kb.  The better thing to do would be to use the extra
space in the per-block group metadata to extend those fields to 32
bits.

						- Ted
