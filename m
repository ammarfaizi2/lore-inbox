Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315405AbSEBUXQ>; Thu, 2 May 2002 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSEBUXO>; Thu, 2 May 2002 16:23:14 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:41994 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315405AbSEBUXM>; Thu, 2 May 2002 16:23:12 -0400
Message-ID: <3CD1A02B.7BF3E163@linux-m68k.org>
Date: Thu, 02 May 2002 22:23:07 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Karim Yaghmour <karim@opersys.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Trace Toolkit 0.9.5
In-Reply-To: <Pine.LNX.4.21.0204251154510.31280-100000@serv> <3CD15883.2FF10B60@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Karim Yaghmour wrote:

> > You should consider using more inline functions, instead of lots of "do
> > {...} while(0)" macros.
> 
> Sure, but what particular advantages do you see in this case?

Type safety, it's also easier to read and edit.

> > Do we really need more usages of uint32_t or uint8_t in the kernel?
> 
> I'd really like to avoid using them, but I don't see any other way
> since the binary traces have to be readable on multiple machine
> architectures and, indeed, multiple OSes. pid_t, for example, isn't
> a universally agreed upon type, hence the need for uintXYZ_t.

There is u32 or u8, which is usually used in the kernel. In user space
you can map them to whatever you like.

> > Instead of using lots of "#ifdef __arch__" you should move this into
> > <asm/trace.h>.
> 
> I hadn't thought of it, thanks. Actually, there are only 2 files needing
> this, drivers/trace/tracer.h and drivers/trace/tracer.c. The variations
> among architectures in tracer.h will be dropped in any case in the near
> future. So there's only tracer.c who has a portion of isolated code which
> has lots of "#ifdef __arch__". Given that this code is very isolated (i.e.
> in only one segment of one function) and there will never be any need for
> it to propagate elsewhere in the trace code, is it worth it to create an
> <asm/trace.h> which will only have 2 lines for most archs?

It might be useful for other things, e.g. for using something more
efficient than do_gettimeofday.

> > Comments are nice, but IMO your code does a bit too much of it, e.g.:
> 
> I understand your point of view, but there is a rational behind this
> way of coding. The purpose is to have the code and the explanation in
> the same place. So to come back to the snippet you were refering to:
> 
> >   /* Everything is OK */
> >   return 0;
> 
> I often see return's without explanations. The question is then: what
> does the value returned mean? This is what this comment is about.

You already have this above the function and it describes the return
value at single place and not all over the function.

> But I don't want to get into a religious fight over code commentary.
> The point is, I've been maintaining the kernel and user-space code this
> way for a while and it's paid off (i.e. most people reading the code
> understand it the first way through). If the comments weren't in sync
> with the code I'd agree that comments are dangerous, but this isn't
> the case so I don't see that there is any harm in this level of
> commenting.

IMO most comments are too obvious, I think it would be useful to
describe the more general things (e.g. like locking strategies) at a
single place and comments in functions should concentrate more on the
nonobvious stuff.

> BTW, what about an m68k port? ;)

As soon as I need it. :)

BTW to make it easier for other people to review your patch, I suggest
you include a direct link next time. Splitting the patch in a core part
and tracepoints part also helps reading the patch.

bye, Roman
