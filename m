Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUD3T2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUD3T2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUD3T2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:28:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4568 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265230AbUD3T2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:28:13 -0400
Subject: Re: [CHECKER] Transcation is not fully aborted upon failure in JFS
	(jfs 2.4, kernel 2.4.19)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0404262349260.7369-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404262349260.7369-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083353278.14140.52.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 14:27:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 01:54, Junfeng Yang wrote:
> Hi,
> 
> We checked JFS filesystem on linux 2.4.19 recently and found 1 case that
> looks like bugs.
> 
> When doing jfs_rename, if dtDelete fails, the transaction won't be fully
> aborted (even if txAbort is called).

Looking back at an old version of the code, the original coder had the
kernel trap if dtDelete failed.  It really would be a rare case for
dtDelete to fail here.  I had changed the trap to the txAbort call to
make the unlikely failure a little more friendly.  I recognized that
everything wouldn't be completely consistent, so I had txAbort mark the
superblock dirty, which will force a complete fsck run before the volume
can be mounted again.

I can probably improve on this and leave the system in better
condition.  I'll treat this as a low priority bug.

Thanks for your work auditing the code and reporting the problem.
-- 
David Kleikamp
IBM Linux Technology Center

