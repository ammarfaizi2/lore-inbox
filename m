Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUHXAR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUHXAR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHXAOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:14:55 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:15372 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S266870AbUHWTtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:49:53 -0400
Date: Mon, 23 Aug 2004 21:48:57 +0200 (CEST)
From: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <1093174557.24319.55.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net> 
 <87hdqyogp4.fsf@killer.ninja.frodoid.org>  <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <1093174557.24319.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2108238993-1093290537=:13955"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2108238993-1093290537=:13955
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 22 Aug 2004, Alan Cox wrote:
> On Sad, 2004-08-21 at 07:03, Tomasz K=B3oczko wrote:
>> In Solaris DTrace is enabled in _normal production_ kernel and you can
>> hang any probe or probes set without restarting system or any runed
>> application which was compiled withoud debug info.
>
> Solaris only runs on large computers. You don't want kprobes randomly on
> your phone, pda, wireless router. Solaris deals with an extremely narrow
> market segment of "big computers for people with lots of money".

Overstatement.
Solaris runs on x86 platform, and runs quite well.
And guess what - DTrace runs on x86 like a charm.

>> [1] Remember: if you want profile some part of code you mast _first_
>> (re)compile them with profiling enabled. If you wand debug some code
>
> OProfile doesn't require this.

I must admit I don't know OProfile.
But can you profile already running application without interuption (not=20
to mention stopping it) to it? Sure, DTrace introduces some overhead but=20
if it's not acceptable just stop DTrace and application again runs with=20
its original speed.
What about getting structure contents, function arguments and returns,=20
etc... all on the fly. And then D languages which saves a lot of time with=
=20
its aggregations, thread local variables, speculations. Sure you can use=20
Perl, AWK, and so on - but it takes time - a lot of time.


>> Some enterprise systems have limited summary time to few hours per year
>> and restart cycle can take houre or more (checking and initialize hardwa=
re
>> components). If you will try say for admin this kind system "restat your
>
> Enterprise users generally get kernels from vendors who have done the
> analysis of needs for them (and hopefully got it right). They generally
> don't ftp 2.6.8.1 type make config and try it out.


I think you missed the point.
DTrace is not only about kernel, and it's definitly not a tool for ONLY=20
kernel developers. It's a great tool for user land developers and for sys=
=20
admins. And it's really easy (well...) to corelate data from kernel and=20
application. All in production and it just works.

I think Tomasz was writing not only about kernel/system uptimes but also=20
about application uptimes. And DTrace can help in both cases.

Coming back to kernel - if you have for example some kind of memory leak=20
in kernel then support guys can provide you with DTrace script, see what's=
=20
going on and get problem solved without unnecessary system restarts. Then
provide you with new kernel (patch). So even if enterprise user do not=20
want recompile its own kernel, if there's a kernel problem DTrace can save=
=20
him some downtime.


> Actually I generally
> -=09Glance across the load meters
> -=09Ask ps where everything is waiting
> -=09Potentially turn on oprofile
> -=09Potentially use netfilter to see who is causing all my traffic
> -=09Maybe strace a few apps to see what is up
> -=09Educate the user concerned (if needed)
>
> I've already got the symbols (and they are in the debuginfo package from
> the rpm build too). I could insmod kgdb but that level of
> debugging is generally inappropriate.
>
> DTrace value is ease of use value.


Sure it's one of its values.
I would add safety of running DTrace in a production. In fact it sould be=
=20
number one feature. DTrace does great job in preventing you from crashing=
=20
system or applications.
I would add that there is easy (at least a lot easier then without DTrace)
way to understand what's going on in system and which appliacation and why=
=20
is cousing it. For example Bryan example with xcalls. And all of that in=20
production systems.

Sure, you can make your own module on Linux, load it and trace whatever=20
you want. But:

   1. it's not easy
   2. requires quite knowledge about kernel
   3. could easly crash your kernel
   4. takes time
   5. only kernel level - what about applications and correlation between
      apps and kernel?
   ...
   ...


My point is DTrace is really awesome tool.
Sure you can do many things without DTrace but it will take much more=20
time. And there are a lot of things you can do with DTrace which are=20
really hard to do in a production using it.

It just saves your time and gives you answers to questions you would not=20
even ask before DTrace 'coz of inacceptable time it would take to answer=20
them. It's really 'fun' to see what's going on in system and/or=20
appliactions with DTrace.

My post sounds almost like marketing crap - but it is really what I find=20
in DTrace. I must admit that I did not really appreciate this tool until=20
I've started using it.


--=20
 =09=09=09=09=09=09Robert Milkowski
 =09=09=09=09=09=09milek@rudy.mif.pg.gda.pl

--8323328-2108238993-1093290537=:13955--
