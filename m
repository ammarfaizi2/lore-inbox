Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTBJIoY>; Mon, 10 Feb 2003 03:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTBJIoY>; Mon, 10 Feb 2003 03:44:24 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51899 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264739AbTBJIoX>;
	Mon, 10 Feb 2003 03:44:23 -0500
Date: Mon, 10 Feb 2003 09:53:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302081754340.5231-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302100951540.2724-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Linus Torvalds wrote:

> Interesting. Especially as the last thing exit_notify() does (just a few
> lines above the schedule()) is to do
> 
>         tsk->state = TASK_ZOMBIE;
> 
> and that schedule() _really_ really shouldn't return. Regardless of any
> signal handler changes.

the proper way to avoid such scenarios (besides removing tasks from all
waitqueues) is to remove the thread from all the PID-hashes prior setting
it to TASK_ZOMBIE. Since any signal-sending needs a task pointer, and the
task pointer can only be found by looking it up in the hash, the proper
way to exclude signal related wakeups (without introducing special
handling into the wakeup code), is to remove the thread from the hash.

	Ingo

