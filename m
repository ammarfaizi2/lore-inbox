Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSEYXKe>; Sat, 25 May 2002 19:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315428AbSEYXKd>; Sat, 25 May 2002 19:10:33 -0400
Received: from bitmover.com ([192.132.92.2]:21204 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315425AbSEYXKd>;
	Sat, 25 May 2002 19:10:33 -0400
Date: Sat, 25 May 2002 16:10:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Larry McVoy <lm@bitmover.com>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        rtai@rtai.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525161034.L28795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Wolfgang Denk <wd@denx.de>, Larry McVoy <lm@bitmover.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, rtai@rtai.org
In-Reply-To: <20020525150542.B17889@work.bitmover.com> <20020525221751.41FC311972@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 12:17:46AM +0200, Wolfgang Denk wrote:
> > > I'm told, and I've seen, that there substantial parts of RT/Linux in the
> > > RTAI source base.  Isn't it true that RTAI used to be called "my-rtai"
> 
> Can you please quote any such "substantial parts of RT/Linux  in  the
> RTAI source"?

Well, since you asked, how about you just go diff the include directories
of the two source bases.  That's a wonderful place to start.  Anyone who
spends 5 minutes in there will see that RTAI is derived from RTL.  Look at
the definition of the RT task struct, it's identical.  Look at the fifo.h
file, big chunks of it are identical.  Another fun thing is to just want
the directory structure of the two source trees, more clues that it is
RTL derived.  It's all been pushed around a lot but I'm not sure you can
take a source base and change it partially and then claim it is yours.
I know if this was my source base I'd be pissed off.

Here's some more, go contrast rt_task_make_periodic() in each of the 
source trees, pretty clearly RTL.  In fact, the scheduler code is really
easy to see that it's a ripoff.  Do a global substitute for 
    s/rtl_no_interrupts()/hard_save_flags_and_cli()/ 
and then start diffing, the code starts matching up more.

Furthermore, look at this:

    rtai-24.1.9/COPYING
	The intent of RTAI developers is to make the code that we write
	to be widely useful and that it can be copied and incorporated
	into other works, including libraries.	In addition, we wish
	to make it explicitly clear that linking proprietary code with
	RTAI is an acceptible use -- for these reasons, we have chosen
	the LGPL as the distribution license.

	However, at the current time, RTAI contains portions that are
	derived from GPL code, so if you are in a situation where the
	difference between GPL and LGPL is an issue, please ask.

    So which is it?  GPL or LGPL?  I thought you guys said you made it 
    clear that it was GPLed.

Anyway, you can jump up and down until you are blue in the face, it's
absolutely obvious to anyone who looks that the RTAI stuff is derived
from the RTL stuff.  Yeah, sure, it's evolved, but it's the same source
base and evolving it does not invalidate their license.  The COPYING
file in the *current* RTAI release is illegal.  You can't say "Well,
there is some GPL stuff in here, but we're releasing under the LGPL"
just because you feel like it.  Didn't you guys repeatedly state that
it was GPL, not LGPL?  And is it?  Not according to the download.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
