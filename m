Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSDSOQV>; Fri, 19 Apr 2002 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSDSOQU>; Fri, 19 Apr 2002 10:16:20 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:55417 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312331AbSDSOQS>; Fri, 19 Apr 2002 10:16:18 -0400
Message-Id: <5.1.0.14.2.20020419150509.00a8c580@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 19 Apr 2002 15:16:32 +0100
To: Dave Jones <davej@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [2.5.9 patch] Fix bluesmoke/mce compiler warnings.
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020419150048.E15517@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:00 19/04/02, Dave Jones wrote:
>On Fri, Apr 19, 2002 at 11:18:05AM +0100, Anton Altaparmakov wrote:
>  > Please consider below patch for inclusion. It fixes compiler warnings
>  > from arch/i386/kernel/bluesmoke.c which appear due to smp_call_function
>  > expecting a function pointer taking an argument to a void * but
>  > mce_checkregs takes an int argument...
>
>Robert Love's patch to fix these up did it with less unnecessary casts,
>and seems to be ok in my testing.
>http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/linux-dj/linux-2.5/arch/i386/kernel/bluesmoke.c

Yes this is nicer (sorry must have missed the patch), even though this bit 
unnecessary:
<snip, line 228 in above file:>
         unsigned int *cpu = info;

         BUG_ON (*cpu != smp_processor_id());
<snip>

If gcc optimizes the "cpu" into a register then fine but if not, it would 
be IMHO preferable to use this instead:

         BUG_ON(*(unsigned int *)info != smp_processor_id());

>(This contains some other bits too that I intend to push to Linus after
>  a pre1 appears)

Why not push now considering 2.5.9 isn't out yet?

Considering the current bitkeeper tree on bkbits does not compile on ia32 
UP at all by any close margin, the more fixes that go in now the better...

I spent two hours this morning try to get it to compile on UP but I got 
stuck in arch/i386/kernel/msr.c: gcc complains about cpu_data not being 
defined even though the right include file is included. Obviously a nasty 
out of scope included headers interdependency which I haven't managed to see...

And adding to that that the ia32 SMP compiled kernel doesn't manage to boot 
on my machine yet (as of this morning, containing up to IDE39 patch still 
didn't boot due to hanging after detecting hda but before hdc as I have 
reported before).

Releasing 2.5.9 in current state would not be too useful for people like me 
who experience the ide problems...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

