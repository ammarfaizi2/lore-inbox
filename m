Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269143AbRHBUwz>; Thu, 2 Aug 2001 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269144AbRHBUwq>; Thu, 2 Aug 2001 16:52:46 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:63495 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S269143AbRHBUwj>; Thu, 2 Aug 2001 16:52:39 -0400
Message-ID: <3B69BDA0.89E25CA9@freesoft.org>
Date: Thu, 02 Aug 2001 16:52:48 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: enhanced spinlock debugging code for intel
In-Reply-To: <3B68FAF4.2B3C9064@freesoft.org> <8zh2vnqc.wl@nisaaru.open.nm.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Brent Baccala wrote:
> >
> > I've had to add some hideous code to get the processor ID:
> >
> >       #define my_processor_id (((int *)current)[13])
> >
> > since sched.h includes spinlock.h, so task_struct isn't defined when
> > this file is parsed, so we can't just dereference current to find the
> > processor ID.  Any better suggestions would be welcome.


I've been thinking more about my own problem here.

I think it could be solved by splitting the spinlock include file in
two:

  spinlockdef.h   - the structure definitions for spinlocks and their
initializers
  spinlock.h      - includes spinlockdef.h and defines the functions to
manipulate spinlocks

This would have to been done in include/linux, as well as all the
include/asm* directories.

Most stuff would include spinlock.h, get both files, and see no change.

sched.h would be changed to include spinlockdef.h, since that's all it
needs.

asm-i386/spinlock.h could then include sched.h and spinlockdef.h without
creating a self-referential loop, so smp_processor_id would work in this
file.

Comments?  a new include file in all the asm dirs?  think Linus would
take it?

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
