Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSAUR5E>; Mon, 21 Jan 2002 12:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbSAUR4z>; Mon, 21 Jan 2002 12:56:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31502 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S287208AbSAUR4p>; Mon, 21 Jan 2002 12:56:45 -0500
Date: Mon, 21 Jan 2002 12:55:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Matthew Johnson <matthew@psychohorse.com>
cc: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: vm philosophising
In-Reply-To: <200201180540.g0I5eu015167@barn.psychohorse.com>
Message-ID: <Pine.LNX.3.96.1020121123948.22038L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Matthew Johnson wrote:

> How does one test the VM precisley? Sorry for the ignorance on this subject.

Having been active doing just that, I have been triggering my favorite bad
behaviour and trying to evaluate which (if either) makes the system run
better, as defined by both measurements and "feel."

The two problems I have been seeing are (1) load with low to moderate
memory, and (2) sudden i/o bursts freezing the system when doing large
writes (CD image creation).

My test for #1 is simple, I compile the 2.4.16 stock kernel after booting
with mem=64m or mem=128m options. I have a batch of files to hack into
something I can post, and I ran on an Athlon 1400 and dual Celeron 500
system, so I have moderate UP and SMP machines of similar performance when
full memory is used. I compile with:
  make clean; make dep
  make bzImage modules MAKE='make -j7'

I took all these numbers with the intent of posting, but the runs finished
at 0630 this morning and I haven't the time yet. Gut feeling is that
17-rmap-11c works better under small memory, 18pre2aa2 was better when
creating CD images on the Athlon, ran out of time for the SMP.

Neither crashed, hung, or caused the OOM to commit procedural genocide,
which plain 2.4.17 does. the -aa kernel was also tested with my own patch
for intermediate disk loads, I will post when I'm sure it's actually
better by enough to matter. I believe the extra tuning in -aa allows
better large i/o performance if you match bdflush to your load.

Chech large i/o by sync() followed by a fast CD build from wav files, on
fast disk. When the disk light come on hard, grab a window and try to wave
it around, or change X virtual desktops. Chances are that you will get bad
to nil response if you have fast disk and CPU. I get a whole 600MB in
memory before the light comes on :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

