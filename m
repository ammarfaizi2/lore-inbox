Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270551AbTGNHFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270554AbTGNHFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:05:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10881 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270551AbTGNHFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:05:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 00:12:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
In-Reply-To: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307140004390.3435@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Mike Galbraith wrote:

> At 02:51 PM 7/13/2003 -0700, Davide Libenzi wrote:
>
> >This should (hopefully) avoid other tasks starvation exploits :
> >
> >http://www.xmailserver.org/linux-patches/softrr.html
>
> Yes, that ~works.  I couldn't starve root to death as a SCHED_SOFTRR user,
> but the system was very sluggish, with keystrokes taking uncomfortably
> long.  I also had some sound skips due to inheritance.  If I activate
> xmms's gl visualization under load, it inherits SCHED_SOFTRR, says "oink"
> in a very deep voice, and other xmms threads expire.  Maybe tasks shouldn't
> inherit SCHED_SOFTRR?

You might want to increase the K_something from 4 (25% CPU time) to a
lower value. Also, SOFTRR tasks should get a lower timeslice while they're
currently getting the RR one. The SOFTRR policy should be used by MM apps
in a way that the thread that uses it does the minimum amount of work in
there. Like the thing we do with IRQ processing.



> While testing, I spotted something pretty strange.  It's not specific to
> SCHED_SOFTRR, SCHED_RR causes it too.  If I fire up xmms's gl visualization
> with either policy, X stops getting enough sleep credit to stay at a usable
> priority even when cpu usage is low.  Fully repeatable weirdness.  See
> attached top snapshots.

RT tasks are pretty powerfull and should not be used to run everything ;)
What I was seeking with this patch was 1) deterministic latency 2) stave
protection.



- Davide

