Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTHMDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271351AbTHMDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:07:27 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:23254 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S271346AbTHMDHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:07:25 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: jw schultz <jw@pegasys.ws>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 12 Aug 2003 23:07:22 -0400
User-Agent: KMail/1.5.1
References: <200308050207.18096.kernel@kolivas.org> <3F38D64C.2030109@cyberone.com.au> <20030813020808.GC23237@pegasys.ws>
In-Reply-To: <20030813020808.GC23237@pegasys.ws>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122307.22813.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.61.27] at Tue, 12 Aug 2003 22:07:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 22:08, jw schultz wrote:
>On Tue, Aug 12, 2003 at 09:58:04PM +1000, Nick Piggin wrote:
>> I have been hearing of people complaining the scheduler is worse
>> than 2.4 so its not entirely obvious to me. But yeah lots of it is
>> trial and error, so I'm not saying Con is wasting his time.
>
>I've been watching Con and Ingo's efforts with the process
>scheduler and i haven't seen people complaining that the
>process scheduler is worse.  They have complained that
>interactive processes seem to have more latency.  Con has
>rightly questioned whether that might be because the process
>scheduler has less control over CPU time allocation than in
>2.4.  Remember that the process scheduler only manages the
>CPU time not spent in I/O and other overhead.
>
>If there is something in BIO chewing cycles it will wreak
>havoc with latency no matter what you do about process
>scheduling.  The work on BIO to improve bandwidth and reduce
>latency was Herculean but the growing performance gap
>between CPU and I/O is a formidable challenge.

In thinking about this from the aspect of what I do here, this makes 
quite a bit of sense.  In running 2.6.0-test3, with anticipatory 
scheduler, it appears the i/o intensive tasks are being pushed back 
in favor of interactivity, perhaps a bit too aggressively.  An amanda 
estimate phase, which turns tar loose on the drives, had to be 
advanced to a -10 niceness for the whole tree of processes amanda 
spawns before it began to impact the setiathome use as shown by the 
nice display in gkrellm.  Normally there is a period for maybe 20 
minutes before the tape drive fires up where the machine is virtually 
unusable due to gzip hogging things, like the cpu, during which time 
seti could just as easily be swapped out.  It remained at around 60%!

It did not hog/lag near as badly as usual, and the amanda run was over 
an hour longer than it would have been in 2.4.22-rc2.

It is my opinion that all this should have been at setiathomes 
expense, which is also rather cpu intensive, but it didn't seem to be 
without lots of forceing.  This is what the original concept of 
niceness was all about.  Or at least that was my impression.  From 
what it feels like here, it seems the i/o stuff is whats being 
choked, and choked pretty badly when using the anticipatory 
scheduler.

I've read rumors that a boottime option can switch it to somethng 
else, so what do I do to switch it from the anticipatory scheduler to 
whatever the alternate is?, so that I can get a feel for the other 
methods and results.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

