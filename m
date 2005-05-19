Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVESV3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVESV3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVESV3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:29:52 -0400
Received: from mail.adic.com ([63.81.117.2]:34879 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261262AbVESV3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:29:40 -0400
Message-ID: <428D0540.4000107@xfs.org>
Date: Thu, 19 May 2005 16:29:36 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Baker-LePain <jlb17@duke.edu>
CC: Lee Revell <rlrevell@joe-job.com>, Gregory Brauer <greg@wildbrain.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
References: <428511F8.6020303@wildbrain.com>  <20050514184711.GA27565@taniwha.stupidest.org>  <428B7D7F.9000107@wildbrain.com>  <20050518175925.GA22738@taniwha.stupidest.org>  <20050518195251.GY422@unthought.net>  <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>  <428BA8E4.2040108@wildbrain.com>  <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>  <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <1116536963.23186.2.camel@mindpipe> <Pine.LNX.4.58.0505191713540.7094@chaos.egr.duke.edu>
In-Reply-To: <Pine.LNX.4.58.0505191713540.7094@chaos.egr.duke.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2005 21:29:38.0610 (UTC) FILETIME=[DC62E120:01C55CB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Baker-LePain wrote:
> On Thu, 19 May 2005 at 5:09pm, Lee Revell wrote
> 
> 
>>On Thu, 2005-05-19 at 17:00 -0400, Joshua Baker-LePain wrote:
>>
>>>May 19 16:47:10 norbert kernel: Filesystem "md0": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/xfs/xfs_da_btree.c.  Caller 0xf8c90148
> 
> *snip*
> 
>>Couldn't this be a stack overflow?  That's a very large kernel stack.
> 
> 
> I am using 8K stacks, and that's all the kernel messages I see.
> 

The stack backtrace just converts all the code addresses it sees on
the stack, so you get extra false positives in there, it is not as
large as it seems.

Try setting /proc/sys/fs/xfs/error_level to 1 and running again,
it should spout out some more information about what it thinks
is corrupted.

Does xfs_repair report anything after this has happened, it looks
like it is trying to read a directory block up from disk to  satisfy
a lookup request and failing for some reason. My suspicion is that
the filesystem will look ok (unmount it, then remount to reply the
log, then unmount again before running repair).

anything else in the syslog shortly before this?

Steve

