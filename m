Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbRGRQHR>; Wed, 18 Jul 2001 12:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267900AbRGRQHH>; Wed, 18 Jul 2001 12:07:07 -0400
Received: from zeus.kernel.org ([209.10.41.242]:25824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267901AbRGRQGv>;
	Wed, 18 Jul 2001 12:06:51 -0400
Message-ID: <3B55B3A4.5E266E7D@freesoft.org>
Date: Wed, 18 Jul 2001 12:04:52 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Do kernel threads need their own stack?
In-Reply-To: <8F87F416D97@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On 18 Jul 01 at 3:16, Brent Baccala wrote:
> 
> > The first thing I notice is that this function refers not only to the
> > clone flags in ebx, but also to a "newsp" in ecx - and ecx went
> > completely unmentioned in kernel_thread()!  A disassembly of
> >
> > Anyway, I'm confused.  My analysis might be wrong, since I don't spend
> > that much time in the Linux kernel, but bottom line - doesn't
> > kernel_thread() need to allocate stack space for the child?  I mean,
> > even if everything else is shared, doesn't the child at least need it's
> > own stack?
> 
> ecx specifies where userspace stack lives, not kernel space one, and
> each process gets its own kernel stack automagically. As you must not
> ever return to userspace from kernel_thread(), it is not a problem.
> Because of exiting from kernel_thread() to userspace is not trivial
> task, I do not think that is worth of effort.

OK, now I see it.  The kernel stack lives at the top of the task
structure, which is allocated as a full page at the beginning of
do_fork(), then type cast down to a struct task_struct.  The copy_thread
code looks past the end of the task_struct and sets up esp0 to point to
the end of the page.

Thanks.

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
