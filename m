Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279873AbRKFSJg>; Tue, 6 Nov 2001 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279874AbRKFSJV>; Tue, 6 Nov 2001 13:09:21 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:8851 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S279873AbRKFSIn>; Tue, 6 Nov 2001 13:08:43 -0500
Date: Tue, 6 Nov 2001 13:09:42 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
X-X-Sender: <hirsch@atx.fast.net>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-0.9.15 against linux-2.4.14
In-Reply-To: <3BE7AB6C.97749631@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Andrew Morton wrote:

> Download details and documentation are at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
> 
> Changes since ext3-0.9.13 (which was against linux-2.4.13):
> 
> - For a long time, the ext3 patch has used a semaphore in the core
>   kernel to prevent concurrent pagein and truncate of the same
>   file.  This was to prevent a race wherein the paging-in task
>   would wake up after the truncate and would instantiate a page
>   in the process's page tables which had attached buffers.  This
>   leads to a BUG() if the swapout code tries to swap the page out.
> 
>   This semaphore has been removed.  The swapout code has been altered
>   to simply detect and ignore these pages.
> 
>   This is an incredibly obscure and hard-to-hit situation.  The testcase
>   which used to trigger it can no longer do so.  So if anyone sees the
>   message "try_to_swap_out: page has buffers!", please shout out.

Andrew,

I have been getting thousands of these when the system was under heavy 
load, but didn't realize it was from the ext3 code!  I'm using Linus's 
2.4.14-pre7 + ext3 patch from Neil Brown's site (the latter is identified 
as "ZeroNineFourteen".)  Would you like me to upgrade kernel and patch?

Steve


