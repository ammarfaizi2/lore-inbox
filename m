Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316027AbSEJPmt>; Fri, 10 May 2002 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316032AbSEJPmt>; Fri, 10 May 2002 11:42:49 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:52611 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316027AbSEJPmr>; Fri, 10 May 2002 11:42:47 -0400
Message-ID: <3CDBE92E.5060307@linuxhq.com>
Date: Fri, 10 May 2002 11:37:18 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
In-Reply-To: <26013.1021001169@kao2.melbourne.sgi.com>	<26949.1021006885@kao2.melbourne.sgi.com>	<15579.46584.447522.360378@kim.it.uu.se>	<20020510142038.A7165@flint.arm.linux.org.uk> <15579.54308.729464.625414@kim.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Russell King writes:
>  > On Fri, May 10, 2002 at 01:58:48PM +0200, Mikael Pettersson wrote:
>  > > This patch silences the sound/oss/emu10k1 warnings.
>  > 
>  > You probably want to think about these in context of 32bit vs 64bit
>  > machines.
>  > 
>  > > --- linux-2.5.15/sound/oss/emu10k1/efxmgr.h.~1~	Wed Feb 20 03:11:02 2002
>  > > +++ linux-2.5.15/sound/oss/emu10k1/efxmgr.h	Fri May 10 01:54:43 2002
>  > > @@ -50,10 +50,10 @@
>  > >          u16 code_start;
>  > >          u16 code_size;
>  > >  
>  > > -        u32 gpr_used[NUM_GPRS / 32];
>  > > -        u32 gpr_input[NUM_GPRS / 32];
>  > > -        u32 route[NUM_OUTPUTS];
>  > > -        u32 route_v[NUM_OUTPUTS];
>  > > +        unsigned long gpr_used[NUM_GPRS / 32];
>  > > +        unsigned long gpr_input[NUM_GPRS / 32];
>  > > +        unsigned long route[NUM_OUTPUTS];
>  > > +        unsigned long route_v[NUM_OUTPUTS];
>  > >  };
> 
> Ideally the emu10k1 maintainer should have fixed this by now. I'm just an emu10k user.
> 
> The problem is: 3 archs (i386, ppc, ppc64) require "unsigned long *" as the
> parameter type in bitops (set_bit et al), the others take "void *".
> "unsigned int *" triggers compiler warnings: on the 32-bitters the warnings
> are just portability hints, but for ppc64 I imagine int != long. (And
> consequently emu10k1 is already broken on ppc64.)
> 
> So what emu10k1 needs here is either
> (a) a fix to make these arrays work even if the element type is 64 bits
>     (I can't claim to understand the code so I don't want to do that), or
> (b) a typedef for a 32-bit type which is "unsigned long" on 32-bitters and
>     "unsigned int" on 64-bitters; I couldn't find a standard one but I could
>     certainly invent one for emu10k1's private use.
> 
> Suggestions?
> 
> /Mikael

I don't understand what the problem is (and I'm not being facetious).

Why wouldn't something like this be handled by declaring the variable as 
"void *"?  If the function is declared as taking "unsigned long *" then 
the cast is implicit, while if the function is declared as taking "void 
*" then it must explicitly cast the value anyway.  Either way, a "void 
*" would work.

Am I messing something up here?

