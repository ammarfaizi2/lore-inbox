Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUHVS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUHVS1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUHVS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:27:50 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:50192 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S268065AbUHVS1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:27:38 -0400
Date: Sun, 22 Aug 2004 20:27:38 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <1093174557.24319.55.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net> 
 <87hdqyogp4.fsf@killer.ninja.frodoid.org>  <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <1093174557.24319.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-341930032-1093199258=:3003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-341930032-1093199258=:3003
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 22 Aug 2004, Alan Cox wrote:

> On Sad, 2004-08-21 at 07:03, Tomasz K?oczko wrote:
>> Again: DTrace is *ALSO* admininstration tool and this is why I can't
>> understand why in IBM KProbe/DProbe patch it is marked as "depends on
>> DEBUG_KERNEL" which is IMO bigest mistake on thinking level about this :>
>
> Because its a debugging feature

KProbe on ground/idea is very similar to DTrace -> DTrace isn't only
debuging tools -> KProbe cen be used not only for debuging.

Yes it *is* debugging feature but it is much more and can be used *also* 
for mamy other things. So marking them as DEBUG_KERNEL dependens is wrong.

>> In Solaris DTrace is enabled in _normal production_ kernel and you can
>> hang any probe or probes set without restarting system or any runed
>> application which was compiled withoud debug info.
>
> Solaris only runs on large computers. You don't want kprobes randomly on
> your phone, pda, wireless router. Solaris deals with an extremely narrow
> market segment of "big computers for people with lots of money".

No Anal. You are wrong. DTrace isn't only for big computers .. it is not 
even for computers but for *finding souce some bugs or other behaviors* 
(not only bugs or bad behaviors :) without specify system size and/or 
price and/or importance and/or is it runed on developmer computer on not.

Ones more: DTrace isn't classic tracing/debuging/measuring tool. It is
much much more and some additional DTrace abilities aren't used only by
developers but also by administrators for finding source veriouse
problems which in spe *aren't bugs* on application or system code level.
And this why DTrace is enabled in distribution/production kernel.
You can have perfect system and perfect application but because system
and applications coexist in one enviroment this will create not empty set
bad cases.
Using yor thing path: KProbe/Dtrace is for development and yes it must 
depend on DEBUG_KERNEL.
ptrace() is also for tracing and ver offen used by developers but it is 
enabled by default and it is not only for developers. So .. ptrace() must 
also depend on DEBUG_KERNEL.
This is of corse wrong .. why ? Because strace just like DTrace/KProbe 
isn't only development tool and/or for developers.

IIRC all Dtrace probes can be divided in to two classes: zero effect and 
near zero effect. First mean: if you don't use probe this do not degrade 
system speed (it uses online self modified binary code without
reservation memory by nop instructions for insert call entry on 
compilation stage). In Solaris kernel exist few thousands avalaible probes 
and IIRC only very small subset is "near zero effect" (uses nop 
instructions).
All other *do not degrade system speed* and this *why* this 
is enabled in production kernel because price this is ~nothing !!

Solaris have very well archived binary compatibilities even on kernel 
level. This offen will mean: you can use some binary modules from older 
kernels and use them with good effect in latest Solaris. Latest Solaris 
(SX) have DTrace.
1 + 1 = you can trace some old code in some limited area (not the same as 
in code prepared for kernel with DTrace) using DTrace using "zero effect" 
probes if you know some entry points in this code.
The same for usser space applications.

>> [1] Remember: if you want profile some part of code you mast _first_
>> (re)compile them with profiling enabled. If you wand debug some code
>
> OProfile doesn't require this.

As same as KProbe/DTrace. Can you use OProfile for something other tnan 
profiling ? Probably yes and this answer opens: probably it will be good 
prepare some common code for KProbe and Oprofile.

>> Some enterprise systems have limited summary time to few hours per year
>> and restart cycle can take houre or more (checking and initialize hardware
>> components). If you will try say for admin this kind system "restat your
>
> Enterprise users generally get kernels from vendors who have done the
> analysis of needs for them (and hopefully got it right). They generally
> don't ftp 2.6.8.1 type make config and try it out.

But using thins like KProbe (which is similar to DTrace) for many Linux
developers will ollow better find bugs in 2.6.8.1 :)
Are they enterprise users ? Is it realy subject _only_ chained to 
"enterprise users" or "vendors" ? IMO no.
And again: DTrace *isn't only for kernel* (current KProbe too) and it is
much more than tracinfg tool so it is importand for developers and not 
develpers too.
So it will be good stop disscuss about "yes or no ?" and start about
"how and when in Linux ?" ..

>> For bring few levels up kernel *development* speed on finding some bugs
>> source and measure some consequences adding/modifing some part of code
>> it will be good have two very well prepared on Solaris things:
>> - crash dumps,
>> - DTrace.
>
> We have crash dumps - at least all the enterprise vendors do. Linus
> doesn't seem to like that stuff so much.

Linux CD to Solaris CD have very long distance ..
Yes it work but compare to Solaris state and as says my fiend "ca~ it only 
work".
It need some more advanced additional tools for analize and report data
from CD.

To Linus: things like CD or KProbe/DProbe allow catch problem by not 
skilled person and analize them in something other in diffret location in 
much more easier way than now. If now in source tree is integrated 
OProfile it will be good integrate ASAP also things like KProbes and CD.
It is not only extenging entropy kernel tree. IMO KProbe can bring some
functionalities wich can be common also for OProfile and probably in 
future IMO OProfile can be droped.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-341930032-1093199258=:3003--
