Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270814AbTHFTKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHFTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:10:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:41379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270814AbTHFTKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:10:36 -0400
Message-Id: <200308061910.h76JAYw16323@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@osdl.org>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression 
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Tue, 05 Aug 2003 22:23:54 PDT." <20030805222354.66dbdb8d.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Aug 2003 12:10:34 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> > 
> > I see 2.6.0-test2-mm4 is already in our queue, so this may be
> > Old News. ( serves me right for taking a weekend off )
> > Performance of -mm3 falls off on the 4-cpu machines. 
> > 
> > 2-cpu ssytems
> > Kernel 			JPM 
> > 2.6.0-test2-mm3		1313.53
> > linux-2.6.0-test2	1320.68 (0.54 % +)
> > 
> > 4-cpu systems
> > 2.6.0-test2-mm3		4824.96
> > linux-2.6.0-test2	5381.20 ( 11.53 % + )
> > 
> > Full details at
> > http://developer.osdl.org/cliffw/reaim/index.html
> > code at 
> > bk://developer.osdl.org/osdl-aim-7
> > 
> 
> OK, I can reproduce this on 4way.
> 
> Binary searching (insert gratuitous rant about benchmarks that take more
> than two minutes to complete) reveals that the slowdown is due to
> sched-2.6.0-test2-mm2-A3.

[Rant response]
For a short test run, you can run a small number of iterations like this:
./reaim -s2 -e10 -i2 -f./workfile.new_dbase

( 2->10 users, increment by 2)

That takes about 5 minutes on our 4-way.

Or, run one iteration with a large user count:

./reaim -s25 -e25 -f ./workifile.foo

cliffw


> 
> So mm4 with everthing up to but not including sched-2.6.0-test2-mm2-A3:
> 
> 	Max Jobs per Minute 1467.06
> 	Max Jobs per Minute 1478.82
> 	Max Jobs per Minute 1473.36
> 
> 	3853.55s user 264.31s system 370% cpu 18:31.95 total
> 
> After adding sched-2.6.0-test2-mm2-A3:
> 
>         Max Jobs per Minute 1375.63
>         Max Jobs per Minute 1278.40
>         Max Jobs per Minute 1293.11
> 
>         4416.70s user 275.61s system 374% cpu 20:53.58 total
> 
> A 10% regression there, mainly user time.
> 
> 
> The test is:
> 
> - build bk://developer.osdl.org/osdl-aim-7
> 
> - cd src
> 
> - time ./reaim -s4 -q -t -i4 -f./workfile.new_dbase -r3 -b -l./reaim.config
> 
> 
> 


