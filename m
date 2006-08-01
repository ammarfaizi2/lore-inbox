Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWHABbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWHABbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWHABbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:31:37 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:55211 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1030386AbWHABbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:31:37 -0400
Message-ID: <44CEAEF4.9070100@slaphack.com>
Date: Mon, 31 Jul 2006 20:31:32 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>, David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org>
In-Reply-To: <20060801010215.GA24946@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Mon, 31 Jul 2006, Nate Diller wrote:
> 
>> this is only a limitation for filesystems which do in-place data and
>> metadata updates.  this is why i mentioned the similarities to log
>> file systems (see rosenblum and ousterhout, 1991).  they observed an
>> order-of-magnitude increase in performance for such workloads on their
>> system.
> 
> It's well known that transactions that would thrash on UFS or ext2fs may
> have quieter access patterns with shorter strokes can benefit from
> logging, data journaling, whatever else turns seeks into serial writes.
> And then, the other question with wandering logs (to avoid double
> writes) and such, you start wondering how much fragmentation you get as
> the price to pay for avoiding seeks and double writes at the same time.

So you use a repacker.  Nice thing about a repacker is, everyone has 
downtime.  Better to plan to be a little sluggish when you'll have 
1/10th or 1/50th of the users than be MUCH slower all the time.

You're right, though, to ask the question:

> TANSTAAFL, or how long the system can sustain such access patterns,
> particularly if it gets under memory pressure and must move.

Anyone care to run some very long benchmarks?

> Even with
> lazy allocation and other optimizations, I question the validity of
> 3000/s or faster transaction frequencies. Even the 500 on ext3 are
> suspect, particularly with 7200/min (s)ATA crap. This sounds pretty much
> like the drive doing its best to shuffle blocks around in its 8 MB cache
> and lazily writing back.

Oh, I'm curious -- do hard drives ever carry enough battery/capacitance 
to cover their caches?  It doesn't seem like it would be that 
hard/expensive, and if it is done that way, then I think it's valid to 
leave them on.  You could just say that other filesystems aren't taking 
as much advantage of newer drive features as Reiser :P

Anyway, remember that the primary tool of science is not logic.  Logic 
is the primary tool of philosophy.  The primary tool of science is 
observation.

Sorry, the only machines I could really run this on are about to be in 
remote only mode for a couple weeks.  I'm hesitant to hit them too hard.
