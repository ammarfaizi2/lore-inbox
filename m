Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314562AbSEBPUn>; Thu, 2 May 2002 11:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEBPUl>; Thu, 2 May 2002 11:20:41 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:4612 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S314562AbSEBPU3>; Thu, 2 May 2002 11:20:29 -0400
Message-ID: <3CD15883.2FF10B60@opersys.com>
Date: Thu, 02 May 2002 11:17:23 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Trace Toolkit 0.9.5
In-Reply-To: <Pine.LNX.4.21.0204251154510.31280-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> > As I said earlier, a 2.5.x patch is available and LTT is ready to
> > be integrated into the 2.5 series.
> 
> I'd really like to see it go in,

Thanks :)

> but I think some small problems are left,
> mostly formatting. Please read Documentation/CodingStyle.
> Please use tabs for indentation and not spaces.

I'm aware of the formatting issues. I will correct the patch to conform with
the kernel's coding style.

> You should consider using more inline functions, instead of lots of "do
> {...} while(0)" macros.

Sure, but what particular advantages do you see in this case?

> Do we really need more usages of uint32_t or uint8_t in the kernel?

I'd really like to avoid using them, but I don't see any other way
since the binary traces have to be readable on multiple machine
architectures and, indeed, multiple OSes. pid_t, for example, isn't
a universally agreed upon type, hence the need for uintXYZ_t.

> Instead of using lots of "#ifdef __arch__" you should move this into
> <asm/trace.h>.

I hadn't thought of it, thanks. Actually, there are only 2 files needing
this, drivers/trace/tracer.h and drivers/trace/tracer.c. The variations
among architectures in tracer.h will be dropped in any case in the near
future. So there's only tracer.c who has a portion of isolated code which
has lots of "#ifdef __arch__". Given that this code is very isolated (i.e.
in only one segment of one function) and there will never be any need for
it to propagate elsewhere in the trace code, is it worth it to create an
<asm/trace.h> which will only have 2 lines for most archs?

There's no problem in doing this, but I just want to make sure I'm not
contributing to creating more files in the kernel source which won't
be of use to anyone else.

> Comments are nice, but IMO your code does a bit too much of it, e.g.:

I understand your point of view, but there is a rational behind this
way of coding. The purpose is to have the code and the explanation in
the same place. So to come back to the snippet you were refering to:

>   /* Everything is OK */
>   return 0;

I often see return's without explanations. The question is then: what
does the value returned mean? This is what this comment is about.

But I don't want to get into a religious fight over code commentary.
The point is, I've been maintaining the kernel and user-space code this
way for a while and it's paid off (i.e. most people reading the code
understand it the first way through). If the comments weren't in sync
with the code I'd agree that comments are dangerous, but this isn't
the case so I don't see that there is any harm in this level of
commenting.

BTW, what about an m68k port? ;)

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
