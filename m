Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSLVWwT>; Sun, 22 Dec 2002 17:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSLVWwT>; Sun, 22 Dec 2002 17:52:19 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:8340 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265484AbSLVWwS> convert rfc822-to-8bit; Sun, 22 Dec 2002 17:52:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Date: Sun, 22 Dec 2002 23:59:53 +0100
User-Agent: KMail/1.4.3
Cc: "J.A. Magallon" <jamagallon@able.es>
References: <200212221439.28075.m.c.p@wolk-project.de> <200212221557.11563.m.c.p@wolk-project.de> <20021222222108.GA2482@werewolf.able.es>
In-Reply-To: <20021222222108.GA2482@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212222352.11560.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 December 2002 23:21, J.A. Magallon wrote:

Hi J.A.

> On 2002.12.22 Marc-Christian Petersen wrote:
> >On Sunday 22 December 2002 15:38, Marc-Christian Petersen wrote:
> >
> >And hi again ^3,
> >
> >> root@codeman:[/] # uname -r
> >> 2.4.20-rmap15b
> >> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384
> >> count=131072 131072+0 records in
> >> 131072+0 records out
> >> 2147483648 bytes transferred in 140.460427 seconds (15288887 bytes/sec)
> >
> >root@codeman:[/] # uname -r
> >2.4.20aa1
> >root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384
> > count=131072 131072+0 records in
> >131072+0 records out
> >2147483648 bytes transferred in 286.054011 seconds (7507266 bytes/sec)
>
> Check you timer...
the timer is right.

> Box is a dual PII@400, 950Mb of RAM. FS is ext3.
> So about 83 seconds on -jam2, which is mainly just 2.4.20aa1 with ext3
> fixes. Ah, no special options to ext3 mount (no  data=ordered). That's the
> point ?
nono, ordered is default if nothing is specified.

Seems it makes a big difference with DUAL and 1GB RAM. Now with Dual P3 1GHz, 
1GB RAM, ext3 ordered mode:

root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 55.741130 seconds (38526016 bytes/sec)

Anyway, the comparison to the different kernels shows up again a better 
throughput than with -aa. That is pretty obvious because of the lowlatency 
elevator in -aa. But that's not the point. The point is that with 
every new kernel release the performance drops. So it shows by dd. Not to 
mention the pauses/stops grow up with every new release. It cannot be true 
that compared 2.4.18 to 2.4.20 there is a 6mb/s performance loss.
What the hell we can get with $MONSTER-BOX w/o the performance issues ;)
Anyway, that dd call with those options is pretty expensive to mem_load.

I wonder why this doesn't affect contest [tm]. Or am I blind?

ciao, Marc
