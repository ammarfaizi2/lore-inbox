Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312311AbSC2Xub>; Fri, 29 Mar 2002 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSC2XuV>; Fri, 29 Mar 2002 18:50:21 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:18949 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312311AbSC2XuN>; Fri, 29 Mar 2002 18:50:13 -0500
Date: Sat, 30 Mar 2002 00:36:52 +0100 (CET)
From: tomas szepe <kala@pinerecords.com>
To: linux-kernel@vger.kernel.org, Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.4.18 SPARC SMP oops
In-Reply-To: <Pine.LNX.3.96.1020326173956.9836A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0203300021320.240-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,


> > The following oops is more-or-less-deterministically reproducible
> > on my dual-processor SPARCstation 10 with 160MB RAM. It tends to send
> > the system down under heavy load caused by either sendmail/procmail
> > or apache. I first came across the bug at around 2.4.17, though it's
> > probably been lurking in the kernel much longer. I've gone through
> > quite a bit of trouble attempting to get the oops barf at me in 2.2.x
> > in case it's my hw config that's behind the whole problem, but I haven't
> > run into any breakdowns, 2.2.21-rc2 included.
>
> Assuming that you can handle your load, at least briefly, with a single
> CPU, have you tried booting with 'nosmp' on this machine? A serious test
> would build without SMP to get the whole locking stuff to go away, but
> this is quick and dirty.
>
> I'm convinced that there are evils still lurking in SMP after all these
> years.

Bad news, everyone. I'm definitely able to reproduce the very same fatal oops
on a UP kernel as well. Couldn't find a SPARC32 equivalent of i386's "nosmp,"
so I was forced to recompile the kernel (2.4.18-rc4) with CONFIG_SMP undefined
and do a "serious test" anyway.

Running something like the following kills the machine flat:

#!/bin/sh
i=0; while [ ! "$i" = "500" ]; do
	/bin/echo testmail.| /bin/mail -s test autoreply@localhost
	i=$(/usr/bin/expr $i + 1)
done

For a ksymoops decode of the oops in question and more, please look up my
former post in this thread.

Looks like it's back to 2.2 for all SPARC/Linux users for the time being.


-Tomas Szepe
pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84

