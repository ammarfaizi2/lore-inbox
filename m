Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUGLNfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUGLNfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266828AbUGLNfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:35:45 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:26495 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266820AbUGLNfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:35:31 -0400
Message-ID: <40F2939B.2000905@yahoo.com.au>
Date: Mon, 12 Jul 2004 23:35:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: aivils@unibanka.lv
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Voluntary Preemption + concurent games
References: <20040709182638.GA11310@elte.hu> <20040711143853.GA6555@elte.hu> <20040711201753.GA11073@elte.hu> <200407121123.11520.aivils@unibanka.lv>
In-Reply-To: <200407121123.11520.aivils@unibanka.lv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aivils wrote:
> Hi All!
> 
> 	I still use in my home minicomputer under Linux, where
> 3 users use one CPU/RAM , but own video.
> 	By default 2.6.XX task scheduler don' t like concurent applications
> at all. 2.6.XX task scheduler allways raise on top of tasks only one
> task and keep it on top until user stop it.
> 	This rule is very unwanted for minicomputers, because multile
> local users will use one CPU and feel lucky.
> 

The CPU scheduler in 2.6 does a lot of special casing in order
to boost interactivity. This can cause weird behaviour and
imbalances like you are seeing when multiple things are running.

> 	As point of reference i use 2.4.XX tack scheduler, which is very
> "righteous" and allways give CPU time for all tasks. Under 2.4.XX
> concurent games run smooth.
> 
> 	2.6.XX non-preemptive and 2.6.XX voluntary-preemptive task
> scheduling looks very similar. My gamer' s eye report me very
> thiny and very subjective difference - preferable is voluntary-preemtive.
> Anyway all concurent CPU intensive tasks should be started with
> nice -n +19 game-bin . Any other nice value remake one of
> running game to slide show or both running games became slide show.
> 
> 	So we should start any game with nice +19. In is this set goes in
> netscape and konqueror because of java web-chat and games.
> 
> 	At least voluntary-preemptive allow me move away from 2.4.26
> 

2.6's CPU scheduler gives nice +19 tasks shorter timeslices, so you
are effectively giving everything better latency.

I have a patchset for 2.6 with some scheduler changes that you might
like to try, here: http://www.kerneltrap.org/~npiggin/2.6.7-np8/, and
let me know how it goes if you do try it. If you need any help getting
it going, please email me privately.
