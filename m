Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSLMWqA>; Fri, 13 Dec 2002 17:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLMWqA>; Fri, 13 Dec 2002 17:46:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2834 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265508AbSLMWp7>; Fri, 13 Dec 2002 17:45:59 -0500
Message-ID: <3DFA64D9.2020002@zytor.com>
Date: Fri, 13 Dec 2002 14:53:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Terje Eggestad <terje.eggestad@scali.com>
CC: Ville Herva <vherva@niksula.hut.fi>, "J.A. Magallon" <jamagallon@able.es>,
       Mark Mielke <mark@mark.mielke.cc>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
References: <1039610907.25187.190.camel@pc-16.office.scali.no>	<3DF78911.5090107@zytor.com>	<1039686176.25186.195.camel@pc-16.office.scali.no>	<20021212203646.GA14228@mark.mielke.cc>	<20021212205655.GA1658@werewolf.able.es>	<1039771270.29298.41.camel@pc-16.office.scali.no> 	<20021213155859.GC1095@niksula.cs.hut.fi> <1039816682.10496.13.camel@eggis1>
In-Reply-To: <1039816682.10496.13.camel@eggis1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad wrote:
> I haven't tried the vsyscall patch, but there was a sysenter patch
> floating around that I tried. It reduced the syscall overhead with 1/3
> to 1/4, but I never tried it on P4.
> 
> FYI: Just note that I say overhead, which I assume to be the time it
> take to do someting like getpid(), write(-1,...), select(-1, ...) (etc
> that is immediatlely returned with -EINVAL by the kernel). 
> Since the kernel do execute a quite afew instructions beside the
> int/iret sysenter/sysexit, it's an assumption that the int 80  is the
> culprit. 
> 

IRET in particular is a very slow instruction.

As far as I know, though, the SYSENTER patch didn't deal with several of
the corner cases introduced by the generally weird SYSENTER instruction
(such as the fact that V86 tasks can execute it despite the fact there
is in general no way to resume execution of the V86 task afterwards.)

In practice this means that vsyscalls is pretty much the only sensible
way to do this.  Also note that INT 80h will need to be supported
indefinitely.

Personally, I wonder if it's worth the trouble, when x86-64 takes care
of the issue anyway :)

	-hpa


