Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSLNUDO>; Sat, 14 Dec 2002 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSLNUDO>; Sat, 14 Dec 2002 15:03:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:41915 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265863AbSLNUDN>;
	Sat, 14 Dec 2002 15:03:13 -0500
Message-ID: <3DFB904F.2ADDE2D4@digeo.com>
Date: Sat, 14 Dec 2002 12:10:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com> <20021214222053.A10506@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 20:10:59.0423 (UTC) FILETIME=[EB1FD6F0:01C2A3AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Sat, Dec 14, 2002 at 10:42:38AM -0800, Andrew Morton wrote:
> > > Find below the patch that address all the issues you've brought.
> > > It is on top of previous one.
> > > Do you think it is ok now?
> > I addresses the things I noticed and raised, thanks.  Except for the
> > stack-space use.  People are waving around 4k-stack patches, and we
> > do need to be careful there.
> 
> Well, 450 bytes is way below 4k (~7 times less if we'd take task struct
> into account) ;)
> I can replace that on-stack array with kmalloc, but that probably
> would be a lot of overhead for no benefit.

It would be a little overhead.  kmalloc is damn quick, and remember
that this data has to be copied from userspace and has go to disk
sometime.   These things will make the kmalloc overhead very small.

> What do you think is safe stack usage limit for a function?

As little as possible?

One way of measuring these things is with your trusty linusometer.
Manfred and I were sent back to the drawing board last week for a
function which used 400 bytes...

> (and btw you have not even seen reiser4 stack usage ;) )

uh-oh.   We need to be very sparing indeed.

I had a patch once which would print out "maximum stack space
ever used by this process" on exit, but Alan fumbled it.  I shall
resurrect it.
