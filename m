Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933013AbWF3S2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbWF3S2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbWF3S2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:28:20 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:16582 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933013AbWF3S2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:28:19 -0400
Date: Fri, 30 Jun 2006 11:24:57 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, "Theodore Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Proposal and plan for ext2/3 future development work
Message-ID: <20060630182457.GH11640@ca-server1.us.oracle.com>
Mail-Followup-To: Badari Pulavarty <pbadari@us.ibm.com>,
	Jeff Garzik <jeff@garzik.org>, Theodore Ts'o <tytso@mit.edu>,
	lkml <linux-kernel@vger.kernel.org>
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <44A47B0D.7020308@garzik.org> <20060630015903.GE11640@ca-server1.us.oracle.com> <1151687586.339.5.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151687586.339.5.camel@dyn9047017100.beaverton.ibm.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 10:13:06AM -0700, Badari Pulavarty wrote:
> I tried adding "delayed allocation" for ext3 earlier. Yes. VFS level
> infrastructure would be nice. But, I haven't found much that we can
> do at VFS - which is common across all the filesystems (except
> mpage_writepage(s) handling). Most of the stuff is specific to 
> filesystem implementation (even though it could be common) - coming
> out with VFS level interfaces to suite all the different filesystem
> delalloc would be *interesting* exercise.

	Well, to be fair, I'm just going by what little I know about
XFS.  They maintain a cache of all pages waiting on delayed allocation
for writepack.  Why have this entire cache (hash, list, whatever) when
we could create some state on in the pagecache?  We save a large chunk
of memory and some complex writeback code.  I suspect you were thinking
of this when you said "mpage_writepage(s) handling".  But this is a
large complexity win if we can do it.
	The same with metadata/data ordering issues.  ie, data=ordered
or even plain "creat(2); write(2)".  I don't know how generic the
ordering is for each filesystem, but there is always room for play.
	On-disk, of course each filesystem is going to be different.
I'm not sure we could fit a fully-generic aops->reserve_space() &
aops->commit_space() API.  But I don't think we need to.

Joel
-- 

"Well-timed silence hath more eloquence than speech."  
         - Martin Fraquhar Tupper

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
