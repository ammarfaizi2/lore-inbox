Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUJERaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUJERaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUJERai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:30:38 -0400
Received: from clusterfw.beelinegprs.net ([217.118.66.232]:31874 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S269117AbUJER35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:29:57 -0400
Date: Tue, 5 Oct 2004 21:22:34 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Jeffrey Mahoney <jeffm@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] I/O Error Handling for ReiserFS v3
Message-ID: <20041005172233.GE28617@backtop.namesys.com>
References: <20041005150819.GA30046@locomotive.unixthugs.org> <4162C156.3030108@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4162C156.3030108@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 08:44:22AM -0700, Hans Reiser wrote:
> These have received design approval from zam (and thus me), but zam, did 
> they receive stress testing by Elena under your guidance?

No. We have a long queue of test tasks.  There are fsck.reiser4 testing,
reiser4/dmapper crashes and the benchmarks in the queue. 

> 
> Hans
> 
> Jeffrey Mahoney wrote:
> 
> >Hey all -
> >
> >One of the most common complaints I've heard about ReiserFS is how graceless
> >it is in handling critical I/O errors.
> >
> >ext[23] can handle I/O errors anywhere, with the results being up to the
> >system admin to determine: continue, go read only, or panic.
> >
> >ReiserFS doesn't offer the admin any such choice, instead panicking on any
> >I/O error in the journal.
> >
> >The available options are read only or panic, since ReiserFS does not
> >currently support operations without the journal.
> >
> >In the four messages that follow, you'll find: *
> >reiserfs-cleanup-buffer-heads.diff - Cleans up handling of buffer head
> >bitfields - uses the kernel supplied FNS_BUFFER macros instead.  *
> >reiserfs-cleanup-sb-journal.diff - Cleans up accessing of the journal
> >structure, prefering to create a temporary variable in functions that access
> >the journal structure non-trivially. Should make 0 difference at compile
> >time.  * reiserfs-io-error-handling.diff - Allows ReiserFS to gracefully
> >handle I/O errors in critical code paths. The admin has the option to go
> >read-only or panic.  Since ReiserFS has no option to ignore the use of the
> >journal, the "continue" method is not enabled.  * reiserfs-write-lock.diff -
> >Fixes two missing reiserfs_write_unlock() calls on error paths that are
> >unrelated to reiserfs-io-error-handling.diff
> >
> >These patches have seen a lot of testing in the SuSE Linux Enterprise Server
> >9 kernel, and are considered ready for mainline.
> >
> >They've received approval[1] from the ReiserFS maintainers also.
> >
> >Andrew - Apologies for the previous format; Please apply.
> >
> >Thanks.
> >
> >-Jeff
> >
> >[1] http://marc.theaimsgroup.com/?l=reiserfs&m=109587254714180
> >
> >-- Jeff Mahoney SuSE Labs
> > 
> >
> 

-- 
Alex.
