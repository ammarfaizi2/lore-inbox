Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <160913-2781>; Fri, 8 Jan 1999 03:00:10 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:38921 "EHLO lsmls02.we.mediaone.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <161166-13684>; Thu, 7 Jan 1999 10:33:24 -0500
Message-ID: <3694F557.FC0B5156@alumni.caltech.edu>
Date: Thu, 07 Jan 1999 09:56:39 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
X-Mailer: Mozilla 4.5 [de] (Win95; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
CC: Egil Kvaleberg <egil@kvaleberg.no>
Subject: Re: [PATCH] HZ change for ix86
References: <19990105094830.A17862@kg1.ping.de> <%gPxk2ciEs@draugen.kvaleberg.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Egil Kvaleberg schrieb:
> IMHO, the right thing would be to implement CLK_TCK properly as a true
> reflection of HZ. Now, it seems to be fixed: e.g. 100 for i386, and 1024
> for alpha.
> 
> The easiest approach would be to make "timebits.h" pick up HZ from the
> kernel, thus:
>         #include <asm/param.h>
>         #define CLK_TCK HZ
> The downside is of course that programs would need to be recompiled for any
> change in HZ. 
> The best thing would be to fix CLK_TCK at runtime. 
e.g.
          #define CLK_TCK new_function_to_get_HZ()
> But could this possibly break anything?

Yes, it would break user programs that were compiled before your change.
I know of two ways for user code to access system time right now: 
clock() and times().  Both of these have constants (CLOCKS_PER_SECOND and
CLK_TCK)
that can't be changed without breaking user applications.
IMHO we need to leave those alone.  I don't want to have to recompile my apps
to move them from 2.0.36 to 2.2.0.  (I do like the idea of changing
HZ to a power-of-two multiple of CLK_TCK.)

Maybe we should create a new interface for user applications to get the true 
system time in its native units, with the value of the native tick available 
at runtime only.  e.g. long sys_ticks(), long sys_ticks_per_second().
- Dan
-- 
Speaking only for myself, not for my employer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
