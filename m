Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280014AbRKFSys>; Tue, 6 Nov 2001 13:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKFSyj>; Tue, 6 Nov 2001 13:54:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16654 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280014AbRKFSyc>; Tue, 6 Nov 2001 13:54:32 -0500
Message-ID: <3BE830B2.8957E8B@zip.com.au>
Date: Tue, 06 Nov 2001 10:49:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven N. Hirsch" <shirsch@adelphia.net>
CC: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-0.9.15 against linux-2.4.14
In-Reply-To: <3BE7AB6C.97749631@zip.com.au> <Pine.LNX.4.33.0111061305540.8366-100000@atx.fast.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven N. Hirsch" wrote:
> 
> On Tue, 6 Nov 2001, Andrew Morton wrote:
> 
> > Download details and documentation are at
> >
> >       http://www.uow.edu.au/~andrewm/linux/ext3/
> >
> > Changes since ext3-0.9.13 (which was against linux-2.4.13):
> >
> > - For a long time, the ext3 patch has used a semaphore in the core
> >   kernel to prevent concurrent pagein and truncate of the same
> >   file.  This was to prevent a race wherein the paging-in task
> >   would wake up after the truncate and would instantiate a page
> >   in the process's page tables which had attached buffers.  This
> >   leads to a BUG() if the swapout code tries to swap the page out.
> >
> >   This semaphore has been removed.  The swapout code has been altered
> >   to simply detect and ignore these pages.
> >
> >   This is an incredibly obscure and hard-to-hit situation.  The testcase
> >   which used to trigger it can no longer do so.  So if anyone sees the
> >   message "try_to_swap_out: page has buffers!", please shout out.
> 
> Andrew,
> 
> I have been getting thousands of these when the system was under heavy
> load, but didn't realize it was from the ext3 code!  I'm using Linus's
> 2.4.14-pre7 + ext3 patch from Neil Brown's site (the latter is identified
> as "ZeroNineFourteen".)  Would you like me to upgrade kernel and patch?
> 

Now that's interesting.  The printk is in there so I can ensure
that the codepath gets tested and is known to work.

Could you please send me details of the hardware setup, URL
for Neil's patch and a description of the workload?  Whatever
I need to make it happen locally.

If the message bothers you, please just remove the printk from 
vmscan.c.
