Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSLYHV2>; Wed, 25 Dec 2002 02:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSLYHV2>; Wed, 25 Dec 2002 02:21:28 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:30860 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266115AbSLYHV0>;
	Wed, 25 Dec 2002 02:21:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: scott@thomasons.org, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Wed, 25 Dec 2002 18:29:23 +1100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212200850.32886.conman@kolivas.net> <1040341293.2521.71.camel@phantasy> <200212241626.26478.scott@thomasons.org>
In-Reply-To: <200212241626.26478.scott@thomasons.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212251829.33553.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 25 Dec 2002 09:26 am, scott thomason wrote:
> On Thursday 19 December 2002 05:41 pm, Robert Love wrote:
> > On Thu, 2002-12-19 at 18:18, Andrew Morton wrote:
> > > That is too often not the case.
> >
> > I knew you would say that!
> >
> > > I can get the desktop machine working about as comfortably
> > > as 2.4.19 with:
> > >
> > > # echo 10 > max_timeslice
> > > # echo 0 > prio_bonus_ratio
> > >
> > > ie: disabling all the fancy new scheduler features :(
> > >
> > > Dropping max_timeslice fixes the enormous stalls which happen
> > > when an interactive process gets incorrectly identified as a
> > > cpu hog.  (OK, that's expected)
>
> My experiences to add to the pot...I started by booting 2.5.52-mm2 and
> launching KDE3. I have a dual AMD MP2000+, 1GB RAM, with most of the
> data used below on striped/RAID0 ATA/133 drives. Taking Andrew's
> advice, I created a continuous load with:
>
>     while [ 1 ]; do ( make -j4 clean; make -j4 bzImage ); done
>
> ...in a kernel tree, then sat down for a leisurely email and web
> cruising session. After about fifteen minutes, it became apparent I
> wasn't suffering any interactive slowdown. So I increased the load:
>
>     while [ 1 ]; do ( make -j8 clean; make -j8 bzImage ); done
>     while [ 1 ]; do ( cp dump1 dump2; rm dump2; sync ); done
>
> ...where file "dump1" is 100MB. Now we're seeing some impact :)
>
>  To combat this I tried:
>
>     echo 3000 > starvation_limit
>     echo 4 > interactive_delta
>     echo 200 max_timeslice
>     echo 20 min_timeslice
>
> This works pretty well. The "spinning envelope" on the email monitor
> of gkrellm actually corresponds quite nicely with the actual feel of
> my system, so after awhile, I just sat back and observed it. Both the
> tactile response and the gkrellm obervations show this: it's common
> to experience maybe a .1--.3 second lag every 2 or 3 seconds with
> this load, with maybe the odd .5 second lag occurring once or twice a
> minute. Watching the compile job in the background scroll by, I
> noticed that there are times when it comes to a dead stop. The next
> step, I guess, needs to be a ConTest with the final settings...
>
> child_penalty: 95
>
> exit_weight: 3
>
> interactive_delta: 4
>
> max_sleep_avg: 2000
>
> max_timeslice: 300
>
> min_timeslice: 10
>
> parent_penalty: 100
>
> prio_bonus_ratio: 25
>
> starvation_limit: 3000

Scott

These don't correspond to your values listed above. Typo?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+CV5XF6dfvkL3i1gRAn+7AJ0Qq0oEo0LE2GG1jpju4cHqH+k6/QCfV1AU
/7JI1ApZoQYwyBmFpH/50FY=
=MAZ5
-----END PGP SIGNATURE-----
