Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTGRNjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271744AbTGRNjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:39:22 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8355 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265922AbTGRNjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:39:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jul 2003 06:46:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
In-Reply-To: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307180630450.5077@bigblue.dev.mcafeelabs.com>
References: <200307170030.25934.kernel@kolivas.org> <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Mike Galbraith wrote:

> At 03:12 PM 7/16/2003 -0700, Davide Libenzi wrote:
>
> >http://www.xmailserver.org/linux-patches/irman2.c
> >
> >and run it with different -n (number of tasks) and -b (CPU burn ms time).
> >At the same time try to build a kernel for example. Then you will realize
> >that interactivity is not the bigger problem that the scheduler has right
> >now.
>
> I added an irman2 load to contest.  Con's changes 06+06.1 stomped it flat
> [1].  irman2 is modified to run for 30s at a time, but with default parameters.

In my case I cannot even estimate the time. It takes 8:33 ususally to do a
bzImage, and after 15 minutes I ctrl-c with only two lines printed in the
console. If you consider the ratio between the total number of lines that
a kernel build spits out, this couls have taken hours. Also, you might
want also to try a low number of processes with a short burn, like the new
patch seems to do to better hit mm players. Something like:

irman2 -n 10 -b 40

Guys, I'm saying this not because I do not appreciate the time Con is
spending on it. I just hate to see time spent in the wrong priorities.
Whatever super privileged sleep->burn pattern you code, it can be
exploited w/out a global throttle for the CPU time assigned to interactive
and non interactive tasks. This is Unix guys and it is used in multi-user
environments, we cannot ship with a flaw like this.



- Davide

