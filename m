Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSIWSnA>; Mon, 23 Sep 2002 14:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSIWSmr>; Mon, 23 Sep 2002 14:42:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261405AbSIWSmd>;
	Mon, 23 Sep 2002 14:42:33 -0400
Message-ID: <3D8F2F4C.BC5B82C@opersys.com>
Date: Mon, 23 Sep 2002 11:12:12 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209230929010.2659-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I think we've agreed on most of the issues already. Just a couple of
details:

Ingo Molnar wrote:
> yes. And in fact i'd suggest to not make it a driver but create a new
> kernel/trace.c file - if it's a central mechanism then it should live in a
> central place.

OK, will do. Need to add a syscall for controlling tracing though (currently
done through device ioctl()).

[...]
Regarding callbacks:

Will be removed.

> are you sure you want to copy filenames? File descriptor and inode numbers
> ought to be enough.

We record the filename only once (i.e. upon exec or open). After that,
the fd is used.

> > - Synchronize with trace daemon to save trace data. (A single per-CPU
> > circular buffer may be useful when doing kernel devleopment, but user
> > tracing often requires N buffers).
> >
> > In addition, because this data is available from user-space, you need to
> > be able to deal with many buffers. For example, you don't want some
> > random user to know everything that's happening on the entire system for
> > obvious security reasons. So the tracer will need to be able to have
> > per-user and per-process buffers.
> 
> in fact i have the feeling that you should not expose any of this to
> ordinary users. Performance measurements are to be done by administrator
> types - all this stuff has heavy memory allocation impact anyway.

Sure, for performance measurements it's the admin, but per my earlier
descriptions:
- users who want to debug synchronization problems of their own tasks
shouldn't see the kernel's behavior.
- users who want to log custom events separate from the kernel events
don't want to see the kernel's beavhior.

In any case, what the admin sees and what the users see of the tracing
facility will certainly be different (i.e. not the same level of
flexibility).

> in exactly which cases do you want to have multiple trace buffers? A
> single (large enough if needed) buffer should be enough. This i think is
> one of the core issues of your design.

OK, we'll revisit this issue.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
