Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155049-13684>; Wed, 6 Jan 1999 07:34:45 -0500
Received: by vger.rutgers.edu id <154623-13684>; Wed, 6 Jan 1999 06:28:51 -0500
Received: from smtp2.gte.net ([207.115.153.31]:9618 "EHLO smtp2.mailsrvcs.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154719-13684>; Tue, 5 Jan 1999 20:40:58 -0500
Message-ID: <3692DF1C.C03DD162@gte.net>
Date: Tue, 05 Jan 1999 22:57:16 -0500
From: Benjamin Scherrey <scherrey@gte.net>
Reply-To: scherrey@proteus-tech.com
Organization: Proteus Technologies, Inc.
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <K.Garloff@ping.de>
CC: Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
References: <19990105094830.A17862@kg1.ping.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Kurt -

    Thanx for the insightful information about the impact of changing the HZ
values. Questions: a) how platform specific is this setting (i86, ALPHA, et al),
and b) Does increasing the HZ value increases context switches or increases
duration of each context?

    This sounds like an excellent developer's config option to me.... Any chance
of this happening soon?

    regards,

        Ben Scherrey

Kurt Garloff wrote:
<snip>

> lately, I've seen a couple of questions about changing HZ in the kernel for
> ix86. Your scheduler will run more often and your system might feel snappier
> when increasing HZ, that's why we want it. Overhead for doing so got
> relativlely low with recent CPUs, so me might really want it.
>
> Basically, you can change it without causing any problems within the kernel.
> However the HZ based value is reported by a system call sys_times() to the
> userspace and as well from the proc fs.
>
> So, this has to be fixed to have a seamless HZ change.
>
> I created a patch which changes the values of HZ to 400 and fixed all places
> I could spot which report the jiffies value to userspace. I think I caught
> all of them. Note that 400 is a nice value, because we have to divide the
> values by 4 then, which the gcc optimizes to shift operations, which can be
> done in one or two cycles each and even parallelized on modern CPUs. Integer
> divisions are slow on the ix86 (~20 cycles) and the sys_times() needs four of
> them. You can easily change HZ to 500 and HZ_TO_STD to 5 in asm-i386/param.h,
> but then you would loose 80 CPU cycles per sys_times() syscall, which you
> might want to avoid.

<snip>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
