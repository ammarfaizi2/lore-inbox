Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWFIKIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWFIKIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFIKIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:08:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964853AbWFIKIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:08:24 -0400
Date: Fri, 9 Jun 2006 03:07:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609030759.48cd17a0.akpm@osdl.org>
In-Reply-To: <20060609091327.GA3679@infradead.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 10:13:27 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Jun 08, 2006 at 06:20:54PM -0700, Mingming Cao wrote:
> > Current ext3 filesystem is limited to 8TB(4k block size), this is
> > practically not enough for the increasing need of bigger storage as
> > disks in a few years (or even now).
> > 
> > To address this need, there are co-effort from RedHat, ClusterFS, IBM
> > and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
> > expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
> > ext3 is build on top of extent map changes for ext3, originally from
> > Alex Tomas. In short, the new ext3 on-disk extents format is:
> 
> What a horrible idea!  The nice things about ext3 are:
> 
>  - the rather simple and thus reliable implementation

JBD isn't simple.  I don't think there's a need in this project to make
algorithmic changes in either JBD or htree, thankfully.

>  - the lack of incompatible ondisk changes

Ted&co have been pretty good at avoiding compatibility problems.

> and the block numbers are't the big problem concerning scalability, there's
> a lot more to it, like btree(-like) structures in the allocator, parallel
> alloocator algorithms and a better allocation group concept.

The performance testing results I've seen for a few of the components of
this project have been rather good, and that's the bottom line.

I don't know how the end result would compare in a bakeoff against XFS, and
I doubt if we know how much XFS performance would be improved if this
effort were diverted into that project.

But I don't think it's all as clear-cut as you imply.

> If you guys want big storage on linux please help improving the filesystems
> design for that, e.g. jfs or xfs instead of showhorning it onto ext3 thus
> both making ext3 less reliable for us desktop/small server users and not get
> the full thing for the big storage people either.

There have been pretty big changes in ext3 post-2.6.early and we've been OK
at avoiding breakage thus far.  It all comes down to how well the new
codepaths manage to avoid altering the existing ones.

That being said, ext3 isn't exactly ....  modern.  One day we'll need
something better.
