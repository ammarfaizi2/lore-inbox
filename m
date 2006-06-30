Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933069AbWF3TRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933069AbWF3TRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWF3TRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:17:04 -0400
Received: from mail01hq.adic.com ([63.81.117.10]:37187 "EHLO MAIL01HQ.adic.com")
	by vger.kernel.org with ESMTP id S933069AbWF3TRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:17:02 -0400
Message-ID: <44A578AC.3010709@xfs.org>
Date: Fri, 30 Jun 2006 14:17:00 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
       "Theodore Ts'o" <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Proposal and plan for ext2/3 future development work
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <44A47B0D.7020308@garzik.org> <20060630015903.GE11640@ca-server1.us.oracle.com> <1151687586.339.5.camel@dyn9047017100.beaverton.ibm.com> <20060630182457.GH11640@ca-server1.us.oracle.com>
In-Reply-To: <20060630182457.GH11640@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2006 19:17:01.0702 (UTC) FILETIME=[C3D35260:01C69C79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Fri, Jun 30, 2006 at 10:13:06AM -0700, Badari Pulavarty wrote:
>> I tried adding "delayed allocation" for ext3 earlier. Yes. VFS level
>> infrastructure would be nice. But, I haven't found much that we can
>> do at VFS - which is common across all the filesystems (except
>> mpage_writepage(s) handling). Most of the stuff is specific to 
>> filesystem implementation (even though it could be common) - coming
>> out with VFS level interfaces to suite all the different filesystem
>> delalloc would be *interesting* exercise.
> 
> 	Well, to be fair, I'm just going by what little I know about
> XFS.  They maintain a cache of all pages waiting on delayed allocation
> for writepack.  Why have this entire cache (hash, list, whatever) when
> we could create some state on in the pagecache?  We save a large chunk
> of memory and some complex writeback code.  I suspect you were thinking
> of this when you said "mpage_writepage(s) handling".  But this is a
> large complexity win if we can do it.


No, XFS does not do this, when it gets asked to write out a page which is
delayed alloc, it goes and converts the delayed alloc extent to real disk
space. It then uses the page cache/buffer heads to find all the contiguous
pages which it can turn into a singe disk I/O. The code is made more complex
by other possible states for the data. The only information internal to XFS
though is its extent structures.

Steve
