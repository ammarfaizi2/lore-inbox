Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282817AbRK0G27>; Tue, 27 Nov 2001 01:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282819AbRK0G2t>; Tue, 27 Nov 2001 01:28:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62947 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282818AbRK0G2j>;
	Tue, 27 Nov 2001 01:28:39 -0500
Date: Tue, 27 Nov 2001 09:26:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linux maillist account <l-k@mindspring.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a nohup-like interface to cpu affinity
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
Message-ID: <Pine.LNX.4.33.0111270921020.3061-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Linux maillist account wrote:

> A nohup-like interface to the cpu affinity service would be useful.  It
> could work like the
> following example:
>
>     $ cpuselect -c 1,3-5 gcc -c module.c

yep, this can be done via the chaff utility i posted:

	gcc -c module.c & ./chaff $! 0x6

or, it can be done by changing the affinity of the current shell, every
new child process will inherit it:

	./chaff $$ 0x6; gcc -c module.c

(or a cpuselect utility can be written.)

> On another subject -- capabilities -- any process should be able to
> reduce the number of cpus in its own cpu affinity mask without any
> special permission.  To add cpus to a reduced mask, or to change the
> cpu affinity mask of other processes, should require the appropriate
> capability, be it CAP_SYS_NICE, CAP_SYS_ADMIN, or whatever is decided.

yep, this is how sched_set_affinity() is workig - it allows the setting of
affinities if either CAP_SYS_NICE is set, or the process' uid/gid matches
that of the target process' effective uid/gid.

	Ingo

