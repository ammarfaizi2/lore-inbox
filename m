Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKRHBN>; Mon, 18 Nov 2002 02:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKRHBN>; Mon, 18 Nov 2002 02:01:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:49336 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261559AbSKRHBN>;
	Mon, 18 Nov 2002 02:01:13 -0500
Message-ID: <3DD891D6.93E8E5E4@digeo.com>
Date: Sun, 17 Nov 2002 23:08:06 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Connors <tconnors@astro.swin.edu.au>
CC: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.47 scheduler problems?
References: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de> <slrn-0.9.7.4-16621-21084-200211181750-j.$random.luser@swin.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 07:08:07.0152 (UTC) FILETIME=[3EBA9700:01C28ED1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:
> 
> > I used to be able to wave a window poorly at make -j25 (swapping heftily),
> > fairly smoothly at make -j20, and smoothly at make -j15 or below.  This
> > with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like this in
> > quite a while though)
> 
> Perhaps you should consider buying an extra 29 CPU's for you desktop?
> 

No.  He's saying that it used to be OK, but it has got worse.

A much simpler test is to start a big compilation and then madly
waggle an X window around.  Goes OK for a few seconds, and then
seizes up quite horridly.  Presumably because the scheduler has
suddenly decided that the X server has become a "batch" process
and is scheduling it in a similar manner to the compilation.

If you stop wiggling the window for 5-10 seconds it comes back.
Presumably because the scheduler has decided that the X server is
"interactive" again.

When it happens, it's *very* bad.  The mouse cursor doesn't move
for 0.5-1.0 seconds and then takes great leaps.  It is unusable.

Strangely it does not happen (much) when the background load is
a few busywaits.  It has to be a compilation - maybe short-lived
batch processes is what triggers it.

For me, the X server is sometimes the victim, and the MUA (netscape4)
is frequently victimised.  This is because the MUA alternates between
periods of interactivity and periods of compute-intensive work (parsing
large mailboxes).   When this problem strikes you have to just sit there
with your arms folded waiting for it to stop.

It needs fixing.
