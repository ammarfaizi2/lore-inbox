Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSICQny>; Tue, 3 Sep 2002 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSICQny>; Tue, 3 Sep 2002 12:43:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28065 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317257AbSICQnx>;
	Tue, 3 Sep 2002 12:43:53 -0400
Date: Tue, 3 Sep 2002 18:51:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209031844430.30462-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Tobias Ringstrom wrote:

> [...] It's a deadline driven semi realtime process.

> [...] I see three simple ways to solve the problem without changing the
> scheduler.  Either run the process with nice -20, use SCHED_RR, or use a
> dedicated server with no other processes (such as crond, httpd, etc).  
> The first two might be OK, but you need root privilegies to run renice
> and to change the scheduler policy.  The third one is not an option for
> all users, and definately not for the video playback case.

do you see the conflict between your two statements?

if it's a "semi-realtime" process that needs more CPU time and needs it
sooner than other 'unimportant' processes in the system like httpd or
remote shells, then give it a higher priority.

under the O(1) scheduler this will now do something meaningful. Yes, this
needs root privileges, otherwise it could be abused to lift priority and
effectively lock out eg. the root shell.

under the old scheduler the nice levels were just a rough mechanism to
determine how CPU hogs use the CPU - interactiveness-wise it did not make
a big difference.

but, i have a spare plan for this, mentioned previously: to enable
unprivileged processes to lower their priority to -5 if they want to.
Could you please test your game server, does it feel interactive enough at
-5?

(allowing -10 might be too much of a stretch.)

	Ingo

