Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSAUMlK>; Mon, 21 Jan 2002 07:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSAUMlA>; Mon, 21 Jan 2002 07:41:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4750 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285498AbSAUMkn>;
	Mon, 21 Jan 2002 07:40:43 -0500
Date: Mon, 21 Jan 2002 15:38:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dave Jones <davej@suse.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Boot hang in 2.5.3-pre2
In-Reply-To: <20020121132858.C2729@suse.de>
Message-ID: <Pine.LNX.4.33.0201211533400.8699-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Jan 2002, Dave Jones wrote:

>  >   Hi, Linus. FYI: 2.5.3-pre2 hangs during boot. The last couple of
>  > messages I get are:
>  > Based upon Swansea University Computer Society NET3.039
>  > apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
>  > apm: disabled - APM is not SMP safe (power off active).
>
>  Ingo's scheduler patches solved this one for me (and others).

the bug is the following: the 2.5.3-pre2 kernel in essence includes the
-I3 patch. The -I3 scheduler doesnt have the task migration fixes yet, but
has the improved load-balancer. And exactly this improved load-balancer
makes task-migration much more likely to happen during bootup =>
triggering it for ksoftirqd migration, resulting in a hang.

older versions had the migration bug as well, but the first iteration of
the load-balancer was much less accurate at balancing runqueues, so it
didnt trigger the bug.

	Ingo

