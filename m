Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319017AbSHSUBF>; Mon, 19 Aug 2002 16:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319018AbSHSUBF>; Mon, 19 Aug 2002 16:01:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319017AbSHSUBC>; Mon, 19 Aug 2002 16:01:02 -0400
Date: Mon, 19 Aug 2002 13:06:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <Pine.LNX.4.44.0208192146580.32337-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0208191305130.1758-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Ingo Molnar wrote:
> 
> The main problem is that there's the old-style SysV IPC interface that
> uses 16-bit PIDs still. All recent SysV applications (linked against glibc
> 2.2 or newer) use IPC_64, but any application linked against pre-2.2
> glibcs will fail. glibc 2.2 was released 2 years ago, is this enough of a
> timeout to obsolete the non-IPC_64 interfaces?

I actually did the pid changes partly to flush out problems spots, on 
purpose making it 30 bits even though I actually eventually still think 
that we may want to use a few bits for things like node ID numbers etc.

> if that is the case then can i rip all the non-IPC_64 parts out of ipc/*,
> and let non-IPC_64 calls fail? Right now it's silent breakage that
> happens.

Add a warning for now, the same way we did with stat() etc when moving to 
64 bits.

> or, in my threading tree, i introduced a /proc/sys/kernel/pid_max tunable,
> which has the safe conservative value of 32K PIDs, but which can be
> changed by the admin to have higher PIDs.

Fair enough.

		Linus

