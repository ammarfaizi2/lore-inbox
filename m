Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVDRSHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVDRSHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVDRSHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:07:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19668 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262155AbVDRSHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:07:01 -0400
Subject: Re: [patch 130/198] ext2 corruption - regression between 2.6.9 and
	2.6.10
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       bernard@blackham.com.au
In-Reply-To: <20050418112213.GA22356@infradead.org>
References: <200504121032.j3CAWhE5005660@shell0.pdx.osdl.net>
	 <20050418112213.GA22356@infradead.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 18 Apr 2005 11:06:52 -0700
Message-Id: <1113847613.13550.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 12:22 +0100, Christoph Hellwig wrote:
> > Mingming Cao <cmm@us.ibm.com> said:
> > The ext2 handle discard preallocation differently at that time, it discard the
> > preallocation at each iput(), not in input_final(), so we think it's
> > unnecessary to thrash it so frequently, and the right thing to do, as we did
> > for ext3 reservation, discard preallocation on last iput().  So we moved the
> > ext2_discard_preallocation from ext2_put_inode(0 to ext2_clear_inode.
> > 
> > Since ext2 preallocation is doing pre-allocation on disk, so it is possible
> > that at the unmount time, someone is still hold the reference of the inode, so
> > the preallocation for a file is not discard yet, so we still mark those blocks
> > allocated on disk, while they are not actually in the inode's block map, so
> > fsck will catch/fix that error later.
> > 
> > This is not a issue for ext3, as ext3 reservation(pre-allocation) is done in
> > memory.
> 
> Shouldn't we have a pass to discard on unmount instead?  ->put_inode is
> a really bad interface and all usages including this one are racy (not that
> it matters too much here, but I'd like to get rid of it eventually).

> As a band-aid to avoid the corruption it's certainly okay (and needed), but
> we should try to fix this for real.  Mingming, do you want to look into it
> or should I put it on my TODO list?
> 
> 
Hi Christoph,

I dislike the fact that ext2 discard preallocation on every iput rather
than the last iput.  Yes, I think doing a check of the preallocated
blocks at umount time is doable.  Please go for it. Thanks for asking.

Mingming

