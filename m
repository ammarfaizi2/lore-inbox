Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSIBNth>; Mon, 2 Sep 2002 09:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSIBNth>; Mon, 2 Sep 2002 09:49:37 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:34441 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318299AbSIBNth>; Mon, 2 Sep 2002 09:49:37 -0400
Date: Mon, 2 Sep 2002 15:54:07 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209021535330.5160-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209021542060.7718-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Ingo Molnar wrote:

> On Sun, 1 Sep 2002, Tobias Ringstrom wrote:
> 
> > While the O(1) scheduler has performed very well for me in most
> > situations, I have one big problem with it.  When running a
> > Counter-Strike game server on Linux 2.4.19 with the sched-2.4.19-rc2-A4
> > patch applied, the server process is niced from the default value of 15
> > (interactive) to 25 (background).  This means that every time crond
> > wakes up or a mail arrives the game latency becomes extremely bad and
> > the users experience lag.
> 
> does the same problem happen if you renice the game server to -10 or -15?

The process was at nice level 0, which I think corresponds to prio 15-25
for interactive to background tasks if I understand things correctly.  
When I used top to renice the process to -10, the prio became 15, i.e. it
was still considered non-interactive.  I even tried -20 (or maybe -19),
and it was still at the non-interactive prio.

In other words:  For all nice values I tried (-20, -10, 0), the prio was
20+nice+5.  When the server is lightly loaded, the prio is 20+nice-5.

Note that even when the server was loaded, it only used 70% CPU, which I
suppose must mean that it does not use up the time slices, which I thought
should make the kernel treat the process as interactive.  Is there a
description of the criteria somewhere (other than in the source code)?

/Tobias

