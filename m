Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbTCLXHZ>; Wed, 12 Mar 2003 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbTCLXHZ>; Wed, 12 Mar 2003 18:07:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16143 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262096AbTCLXHX>; Wed, 12 Mar 2003 18:07:23 -0500
Date: Wed, 12 Mar 2003 18:14:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, Richard Henderson <rth@twiddle.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.44.0303120735410.13807-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1030312180304.27586C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Linus Torvalds wrote:

> 
> On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> > 
> > Some data points, in time order.
> > 
> > SuSE 8.0 	2.95.3-216      no bug yet [1]
> > Debian 3.0      2.95.4-14       no bug yet [1]
> > Red Hat 7.[23]  2.96-81         no bug yet [2,3]
> > Red Hat 7.[23]  2.96-98         bug introduced [2,3]
> > Mandrake 8.1    2.96-0.62mdk    bug introduced [4]
> > Red Hat 7.[23]  2.96-103        bug fixed  [2,3]
> > SuSE 8.0        3.0.4 (SuSE)    bug fixed [1]
> > Mandrake 9.1    3.2.2-2mdk      bug fixed [1]
> 
> Ok. So the test really is for one particular version only.
> 
> That's easy. I'll just add a
> 
> 	#ifdef CONFIG_FRAME_POINTER
> 	#if __GNUC__ == 2 && __GNUC_MINOR__ == 96
> 	#error This compiler is not safe with frame pointers
> 	#endif
> 	#endif
> 
> to <linux/compiler.h>. Yeah, it will get some fixed compilers too, but 
> that's just not worth worrying about - people will just have to turn off 
> CONFIG_FRAME_POINTER and be happy.

Please don't use a hammer on that tack... The Redhat errata gcc (as an
example) seems to be fine (see the nice list in the first post) and id's
as: 
   oddball:davidsen> gcc -v
   Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
   gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)

People trying to get 2.5 kernels working want frame pointers and kernel
symbols so problems can be reported in a useful way. People running 2.5
kernels are probably more likely to have installed errata.

Perhaps a warning (UNSAFE?) in the config would be better, or whatever
else would avoid just blocking the ability to compile a debug kernel.

Yes, I see there's another newer yet gcc, 2.96-113, but it's been working
since -103.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

