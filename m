Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbTCLATd>; Tue, 11 Mar 2003 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbTCLARQ>; Tue, 11 Mar 2003 19:17:16 -0500
Received: from motgate.mot.com ([129.188.136.100]:31229 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id <S261730AbTCLAPM>;
	Tue, 11 Mar 2003 19:15:12 -0500
Date: Tue, 11 Mar 2003 18:25:15 -0600
Subject: Re: [patch] oprofile for ppc
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: <mikpe@csd.uu.se>, Segher Boessenkool <segher@koffie.nl>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       <oprofile-list@lists.sourceforge.net>,
       <linuxppc-dev@lists.linuxppc.org>, <o.oppitz@web.de>,
       <linux-kernel@vger.kernel.org>
To: Albert Cahalan <albert@users.sourceforge.net>
From: Andrew Fleming <afleming@motorola.com>
In-Reply-To: <1047424400.5972.44.camel@cube>
Message-Id: <189E30F2-5421-11D7-BAD1-000393C30512@motorola.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> It would be nice if this bug were added to the notes
> for the MPC7400 processor, if indeed it is present.
>
> Even without this bug, I suspect oprofile is a major
> security hazard. It lets you time things in the kernel.
> Just set BAMR (to choose a kernel address) as desired,
> and you can follow the jumps taken in crypto code, etc.

Well, I can confirm that it is in the errata internally available in a 
document marked 5/14/2001.  I had difficulty finding any errata 
listings for the 7400 on our external site, though.

>
> There's more than just a process difference though.
> The version number is seriously different. It's not
> just one bit changing to indicate a different process.
> Here I am, with a version 2.9 chip:
>
> cpu             : 7400, altivec supported
> temperature     : 35-40 C (uncalibrated)
> clock           : 450MHz
> revision        : 2.9 (pvr 000c 0209)

Yeah, the 7410 had some small microarchitectural and architectural 
changes.  Changes that mean it can't necessarily be used in the same 
socket as the 7400.  Votages were modified, and some memory interfacing 
was changed.  Also, it was a significantly different process (a major 
shrink), so it gets a new name.  The various versions of the 7400 are 
all in the same sized process (with slightly different transistors, I 
think).

>
> Any one of the counters would do; the event can be
> moved around as needed. Also note the TBSEL bits in
> MMCR0. TBSEL gives another way to get an interrupt,
> without giving up any of the counters.

True.  But I'm going to have to think about this one more, before I 
agree with you.  :)


>
> Pardon me for being a pessimist. I have to imagine
> that the counters don't turn off fast enough too.

I'm fairly certain they do shut off the instant the interrupt happens 
if they aren't supposed to count privileged events, but I'd have to do 
some testing to prove it.  The issue is that MSR[EE] takes 2 cycles to 
be written.


>> Is this bug restricted to 7400/7410 only, or does it
>> affect the 750 (and relatives) and 604/604e too?
>>
>> I'm thinking about ppc support for my perfctr driver,
>> and whether overflow interrupts are worth supporting
>> or not given the errata.
>
> 604/604e doesn't even have performance monitoring AFAIK.
> I've heard nothing to suggest that the 750 is affected.
>
> I'll give you a hand; point me to the latest perfctr code
> and explain how it is supposed to interact with oprofile.

The 604 and 604e both have performance monitors.  I can't find anything 
which says that this is a bug in them.  However, being as this bug 
managed to creep into the 7400/7410, I'm not willing to say that the 
bug didn't exist in all of those processors.  More testing would be 
necessary.

BTW, I am also interested in helping out with this code.  Meanwhile, 
I'll attempt to find the answers to those questions.


Andy Fleming

PowerPC Software Enablement
Motorola, Inc

Note that my opinions are not Motorola's, even the good ones!

