Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272480AbTHJHhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272483AbTHJHhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:37:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:8653 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272480AbTHJHhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:37:36 -0400
Message-Id: <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 09:41:46 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy 
  ...
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F35DB73.8090201@cyberone.com.au>
References: <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:43 PM 8/10/2003 +1000, Nick Piggin wrote:


>Roger Larsson wrote:
>
>>*       SCHED_FIFO requests from non root should also be treated as 
>>SCHED_SOFTRR
>>
>
>I hope computers don't one day become so fast that SCHED_SOFTRR is
>required for skipless mp3 decoding, but if they do, then I think
>SCHED_SOFTRR should drop its weird polymorphing semantics ;)

:)  My box is slow enough to handle them just fine, as long as I make sure 
that oinkers don't share the same queue with the light weight player.

The only reason I can see that some form of realtime scheduling is really 
_required_ to prevent skippage is because of the dirty page writeout thing, 
which Andrew has fixed as much as is practical for realtime tasks.  There 
is another side to that though... if you're going to make a vm scrubbing 
exception for realtime tasks, it seems to me to follow, that rt task's mm 
should be exempted from scrubbers as well (to a point).

wrt SCHED_FIFO, you couldn't handle those with SOFTRR as is, because the 
cpu restriction is calculated using the task's timeslice... which 
SCHED_FIFO tasks don't have.  Making SCHED_FIFO available in any form would 
require addition of some means of detecting cpu usage.  (and if you create 
any run limit, you may as well just use a timeslice, which turns it right 
back into SCHED_RR).

         -Mike 

