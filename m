Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTEYBMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 21:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTEYBMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 21:12:44 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:5002 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261249AbTEYBMn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 21:12:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Sun, 25 May 2003 11:27:20 +1000
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305231405.54599.christian.klose@freenet.de> <20030524142809.GZ8978@holomorphy.com> <200305250242.58269.christian.klose@freenet.de>
In-Reply-To: <200305250242.58269.christian.klose@freenet.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305251127.40516.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 25 May 2003 10:43, Christian Klose wrote:
> On Saturday 24 May 2003 16:28, William Lee Irwin III wrote:
>
> Hi wli,
>
> > > --- old/kernel/sched.c	2003-05-24 14:45:57.000000000 +0200
> > > +++ 2.5-mcp/kernel/sched.c	2003-05-24 16:18:42.000000000 +0200
> > > @@ -65,7 +65,7 @@
> > >   * they expire.
> > >   */
> > >  #define MIN_TIMESLICE		( 10 * HZ / 1000)
> > > -#define MAX_TIMESLICE		(200 * HZ / 1000)
> > > +#define MAX_TIMESLICE		( 10 * HZ / 1000)
> > >  #define CHILD_PENALTY		50
> > >  #define PARENT_PENALTY		100
> > >  #define EXIT_WEIGHT		3
> >
> > This looks highly suspicious as it essentially removes dynamic timeslice
> > sizing. If this fixes something, then dynamic timeslice heuristics are
> > going wrong somewhere that should be properly described and handled, not
> > this kind of shenanigan.
>
> I somewhat agree with you but this "properly described" are all the bug
> reports on lkml containing "bad interactivity in 2.5, cpu starving in 2.5"
> and such...
>
> This isn't a shenanigan, at least not for the interactivity for a desktop.
> This is a workaround for users who are complaining about bad interactivity
> in 2.5!
>
> ciao, Marc

Even though you're not Marc I do agree with you. The problem is well described 
as either poor interactivity (the window wiggle test) or starvation in the 
presence of certain scheduler hogs (for whatever reason) since the 
interactivity patch from mingo. Dropping the max timeslice is a bandaid but 
destroys priority based timeslice scheduling. Dropping the min timeslice will 
bring this back, but at some point the timeslice will be so low that low 
priority cpu intensive tasks will spend most of their time cache trashing.

A reasonable compromise for the desktop would be
min 5 
max 25
but some granularity will be lost in the different sizes of timeslices at 
different priorities.

is there any point having longer timeslices than this?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+0Bv6F6dfvkL3i1gRAhpfAKCG3fjkK02lYbAs1p3978rSL/PYAQCcCeK7
gHqR6bgrITE3CSjKCqntw+g=
=rq1o
-----END PGP SIGNATURE-----

