Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWCXVAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWCXVAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCXVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:00:36 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:65219 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751347AbWCXVAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:00:35 -0500
Date: Fri, 24 Mar 2006 14:00:33 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Valerie Henson <val_henson@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324210033.GQ14852@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int> <20060324200131.GE18020@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324200131.GE18020@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006  15:01 -0500, Theodore Ts'o wrote:
> On Fri, Mar 24, 2006 at 12:28:02PM -0700, Andreas Dilger wrote:
> > The good news, is that fixing the "ext3 clearing indirect blocks" problem
> > not only allows undelete to work again, but also improves truncate
> > performance because (a) we only modify 1/32 of the blocks we would in the
> > old case (we don't need to modify any {d,t,}indirect blocks), (b) we do
> > indirect block walking in forward direction, and could submit {d,}indirect
> > block requests in a batch instead of one-at-a-time.
> 
> the thing that scares me about this is that this means we now
> have to maintain *two* horribly complicated pieces of code for which
> it will be very easy for bugs to creep in.  

That is why I propose keeping the majority of this code common (the tree
walking part), and only fix the bottom layer which adds the {d,t,}indirect
blocks into the transaction and zeroes them out, and the top layer, which
decides which path to take.

> This would be a prime candidate for trying to add the same sort of
> userspace test framework which Rusty and company did for netfilter, so
> we can try to test for race conditions, corner cases, etc.

Are you saying to make a filesystem test harness in userspace, or to
add hooks into the kernel to trigger specific cases in the running
kernel?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

