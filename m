Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSAIGmE>; Wed, 9 Jan 2002 01:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSAIGlx>; Wed, 9 Jan 2002 01:41:53 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:34757 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S288917AbSAIGlo>; Wed, 9 Jan 2002 01:41:44 -0500
Date: Tue, 8 Jan 2002 22:40:36 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Brian <hiryuu@envisiongames.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <0GPN00CMLRC7U8@mtaout45-01.icomcast.net>
Message-ID: <Pine.LNX.4.33.0201082238530.10084-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Brian wrote:

> Can this be correct?
>
> Intuitively, I would expect several CPUs hammering away at the compile to
> finish faster than one.  Given these numbers, I would have to conclude
> that is not just wrong, but absolutely wrong.  Compile time increases
> linearly with the number of jobs, regardless of the number of CPUs.
>
> What would cause this?  Severe memory bottlenecks?

Mike ran make -j 8 which means 8 compiler processes for each "# Makes" in
the table.  Thus, the first row has 8 parallel processes on a 2-way and
the last row has 48 processes on an 8-way.  The best ratio is 8 processes
on an 8-way which not incidentally also has the lowest time: 57 seconds.

-jwb

>
> 	-- Brian
>
> On Tuesday 08 January 2002 10:39 pm, Mike Kravetz wrote:
> > --------------------------------------------------------------------
> > mkbench - Time how long it takes to compile the kernel.
> >         We use 'make -j 8' and increase the number of makes run
> >         in parallel.  Result is average build time in seconds.
> >         Lower is better.
> > --------------------------------------------------------------------
> > # CPUs      # Makes         Vanilla         O(1)	haMQ
> > --------------------------------------------------------------------
> > 2           1                188             192        184
> > 2           2                366             372        362
> > 2           4                730             742        600
> > 2           6               1096            1112        853
> > 4           1                102             101         95
> > 4           2                196             198        186
> > 4           4                384             386        374
> > 4           6                576             579        487
> > 8           1                 58              57         58
> > 8           2                109             108        105
> > 8           4                209             213        186
> > 8           6                309             312        280
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

