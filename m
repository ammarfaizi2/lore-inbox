Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUHUGDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUHUGDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268859AbUHUGDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:03:17 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:44039 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S268856AbUHUGDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:03:11 -0400
Date: Sat, 21 Aug 2004 08:03:10 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Julien Oster <usenet-20040502@usenet.frodoid.org>
cc: Miles Lane <miles.lane@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <87hdqyogp4.fsf@killer.ninja.frodoid.org>
Message-ID: <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2079399573-1093058705=:3003"
Content-ID: <Pine.LNX.4.60L.0408210525210.3003@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2079399573-1093058705=:3003
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.60L.0408210525211.3003@rudy.mif.pg.gda.pl>

On Fri, 20 Aug 2004, Julien Oster wrote:

> Miles Lane <miles.lane@comcast.net> writes:
>
>> http://www.theregister.co.uk/2004/07/08/dtrace_user_take/:
>> "Sun sees DTrace as a big advantage for Solaris over other versions of Unix
>> and Linux."
>
> That article is way too hypey.
>
> It sounds like one of those strange american commercials you see
> sometimes at night, where two overenthusiastic persons are telling you
> how much that strange fruit juice machine has changed their lives,
> with making them loose 200 pounds in 6 days and improving their
> performance at beach volleyball a lot due to subneutronic antigravity
> manipulation. You usually can't watch those commercials for longer
> than 5 minutes.

Probably you did try use DTrace even less than 5 minutes :->

> The same applies to that article, I couldn't even read it completely,
> it was just too much.
>
> And is it just me or did that article really take that long to
> mentioning what dtrace actually IS?
>
> Come on, it's profiling.

Bullsh* :-|

DTrace is development tool for kernel and *application* develepers
because it have some tracing functionalities .. but *ALSO* .. not mainly.
It can be used *ALSO* as profiling tool but this functionality is small 
piece of this and most exciting part of DTrace is outhere both above 
areas. *ALSO* DTrace can bring classic profiling/tracing tasks to new much 
more effective level (look below on [1]).
For many cases where I try use DTrace and which I heard where it was uses 
by my friends it was used on normal *administration* tasks (look for 
example on SysAdmin DTrace article where on beging this article was used 
example how DTrace can be used for finding source of some 
system misconfiguration) where before was used tools like variouse 
{k,vm,prt,net,io,nfs,lock,...}stat tools and in mamy cases it allow answer 
for the same administrators question where this tools can't be used in
simple way or where answering on some question can take so much time where 
many people will say "huh .. _maybe_ I will try this later".

Again: DTrace is *ALSO* admininstration tool and this is why I can't
understand why in IBM KProbe/DProbe patch it is marked as "depends on
DEBUG_KERNEL" which is IMO bigest mistake on thinking level about this :>

In Solaris DTrace is enabled in _normal production_ kernel and you can 
hang any probe or probes set without restarting system or any runed
application which was compiled withoud debug info.

[1] Remember: if you want profile some part of code you mast _first_
(re)compile them with profiling enabled. If you wand debug some code first 
you must (re)compile code with enabled generate debug info. All this takes 
time .. and in all this cases you must restart system or traced
application (also takes time).
In many cases (even not trivial) using DTrace you can perform 
tracing/profiling/measuring _without recompiling and also without_
_restating_ runed code (which is *very valueable*) .. all this in few
seconds.

Some enterprise systems have limited summary time to few hours per year 
and restart cycle can take houre or more (checking and initialize hardware
components). If you will try say for admin this kind system "restat your
system using this kernel image which have enabled some additional printk() 
and show me syslog output" probaly you will never see this admin again.
Also mamy bugs can be observed _only_ on highly loaded systems where
adding ptrace() based tracing can even kill system (trace using DTrace
takes less power from system than ptrace()).

For bring few levels up kernel *development* speed on finding some bugs 
source and measure some consequences adding/modifing some part of code
it will be good have two very well prepared on Solaris things:
- crash dumps,
- DTrace.
On Solaris also you can combine above (you can generate crash dump using 
signal from DTrace program and you can review DTrace data from system 
crash dump image).

When you see some strange behavior without system destabization 
current/cassic Linux kernel development look now like:
1) if you have good kernel knowledge you can imagine which part of them
    is source of same observed strange behavior,
2) after looking on kernel source you can cut of area to part where bug
    exist,
3) after few recompilations you can say in which area bug exist and after
    few other iteration stage 3) you can say what maust be fixed.
This classic way.

New way using DTrace can look like:
1) by using few times modified DTrace *programs* (in many cases
    prepared in one line command line parameters) you can locate which part
    of runng code (for example by what is on stack) is source of observed
    behavior,
2) after locate bad area code you can find associated to this source code,
3) and now from this limited area you can start thinging about "what I
    must know about kernel" for finding source of problem.

New way is kind of anal development. In much more cases it will allow
find source of bug and have source even prepare better or worse fix
by _not only_ highly expirinced kernel developers.
Also stage 1) and 2) can be performed by *not real developer* (?!).

In classic way if you are not skilled you can't even try pass 1) stage :>
Passing classic variant stage 3) requires installed development 
enviroment.

kloczek
PS. Very interesting commens about this thread is on Bryan Cantrill 
(DTrace developer) blog:
http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
Bryan blog is also yet another Dtrace knowledge source ..
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-2079399573-1093058705=:3003--
