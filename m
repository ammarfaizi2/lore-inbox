Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUDTWqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUDTWqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUDTWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:46:37 -0400
Received: from waste.org ([209.173.204.2]:17843 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263750AbUDTWFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:05:52 -0400
Date: Tue, 20 Apr 2004 17:05:34 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [RFC] extents,delayed allocation,mballoc for ext3
Message-ID: <20040420220534.GD28459@waste.org>
References: <m365c3pthi.fsf@bzzz.home.net> <20040414040101.GO1175@waste.org> <m3llkyojcx.fsf@bzzz.home.net> <1082404030.2237.72.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082404030.2237.72.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 08:47:10PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, 2004-04-14 at 13:05, Alex Tomas wrote:
> 
> >  MM> I'm going to assume that there's no way for ext3 without extents
> >  MM> support to mount such a filesystem, so I think this means changing the
> >  MM> FS name. Is there a simple migration path to extents for existing filesystems?
> > 
> > yeah. you're right. I see no way to make it backward-compatible. in fact,
> > I haven't think much about name. probably you're right again and this
> > "ext3 on steroids" should have another name.
> 
> We've already got feature compatibility bits that can deal with this
> sort of thing.  There are various other proposed incompatible features,
> such as large inodes and dynamically placed metadata (eg. placing inode
> tables into an inode "file"), too.  Rather than invent new names for
> each combination of incompatible feature set, we're probably better off
> just using the feature masks.

I'm aware of the existence of such features, I just think it's yet to
be demonstrated that they're actually a good idea for real deployment
by themselves. ext3+{btree,extents} is not backwards compatible in any
useful sense, unlike features such as journalling, directory hashing,
sparse superblocks, wandering journals, etc. Given that you can't
mount the new filesystem with an old kernel, not changing the name can
only result in confusion.

But I see your point about dealing with a cartesian product of
features. So if and when this stuff approaches beta, we should
probably use the feature flags _and_ change the name to something like
ext3+be (btrees, extents) or ext3+i (inode in file) to indicate the
presence of experimental, incompatible features, and when the feature
set is actually pinned down, rename it simply ext3+ or ext4 or whatever.

It might be possible to have ext4 actually be a family of filesystems
where extents or large inodes are optional, but I suspect the value of
that would be minimal and again, all such features would have to be
available in every kernel tree that claimed to support ext4.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
