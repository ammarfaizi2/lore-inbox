Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263520AbUJ2WZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263520AbUJ2WZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUJ2WX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:23:29 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:25001 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263581AbUJ2UwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:52:01 -0400
Message-Id: <200410292051.i9TKptOi007283@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 22:33:20 +0200."
             <20041029203320.GC5186@elte.hu> 
Date: Fri, 29 Oct 2004 16:51:55 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 15:51:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [ I trimmed the CC: line because several people there are on
    jackit-devel. ]

>> compiles and boots fine. no observable change in xrun behaviour though. 
>
>ok, so there's something else going on as well - or i missed an ioctl. 

i really don't think the ioctl's are relevant. 

consider what will happen if jackd does make a system call that causes
a major delay (say, because of the BKL). we will get an xrun, yes, but
this will cause jackd to stop the audio interface and
restart. max_delay is not affected by this behaviour.
 
as far as i can tell, the number reported by max_delay entirely (or
almost entirely) represents problems in kernel scheduling, specifically
with a combination of:

     a) handling the audio interface interrupt in time.
     b) marking the relevant jackd thread runnable
     c) context switching back to the relevant jackd thread

things that jackd does once its running do not, it appear to me, have
any impact on max_delay, which is based on the simple observation: 

   "i was just woken, i expect to be awakened again in N usecs or
   less.

--p
