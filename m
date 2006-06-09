Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWFIKtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWFIKtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWFIKtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:49:43 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:48001 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S965087AbWFIKtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:49:42 -0400
Date: Fri, 9 Jun 2006 04:49:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609104947.GZ5964@schatzie.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609091327.GA3679@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  10:13 +0100, Christoph Hellwig wrote:
> the block numbers are't the big problem concerning scalability, there's
> a lot more to it, like btree(-like) structures in the allocator, parallel
> alloocator algorithms and a better allocation group concept.

All of the allocator changes are already written and well tested, and gave
ext3 a 30% performance improvement while at the same time reducing CPU
usage by 50% - not trivial.  See Holger Kiehl's post
http://marc.theaimsgroup.com/?l=linux-kernel&m=114958967600822&w=4

> If you guys want big storage on linux please help improving the filesystems
> design for that, e.g. jfs or xfs instead of showhorning it onto ext3 thus
> both making ext3 less reliable for us desktop/small server users and not get
> the full thing for the big storage people either.

XFS = 108844 lines, and a complete mess to understand.
ext3+jbd = 27749 lines (includes ~6000 lines extent/allocation changes)

Also, ext3 is just much more robust in the face of on-disk corruption
than xfs or jfs because of its "static" layout, and e2fsck is way
better than the alternatives.  Despite their "big storage" designs ext3
is still competitive in performance, especially with the allocation
improvements.  See also:

http://marc.theaimsgroup.com/?l=ext2-devel&m=108194477207334&w=4
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110112879929869&w=4
	http://samba.org/~tridge/xattr_results/xfs-ext3-tuning.png

If the XFS or JFS maintainers want to fix their filesystems, they are free
to do so, the ext3 maintainers (all of them, btw) want these changes.


The extent code (prior to some minor cleanups for landing on the vanilla
kernel) has already seen many millions of hours of testing in very heavy
IO environments, so it isn't something that was just written.  If extents
aren't enabled it amounts to a couple of extra conditionals in the
allocation path and basically no modifications to the existing code, so
you can safely avoid this code if you feel the need to.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

