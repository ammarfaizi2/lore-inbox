Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319010AbSHSTtl>; Mon, 19 Aug 2002 15:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSHSTtl>; Mon, 19 Aug 2002 15:49:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36548 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319010AbSHSTtk>;
	Mon, 19 Aug 2002 15:49:40 -0400
Date: Mon, 19 Aug 2002 21:55:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: MAX_PID changes in 2.5.31
Message-ID: <Pine.LNX.4.44.0208192146580.32337-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

afaics, you did the PID_MAX changes in v2.5.31? This is a change i had for
(surprise) threading purposes already, but done a bit differently.

The main problem is that there's the old-style SysV IPC interface that
uses 16-bit PIDs still. All recent SysV applications (linked against glibc
2.2 or newer) use IPC_64, but any application linked against pre-2.2
glibcs will fail. glibc 2.2 was released 2 years ago, is this enough of a
timeout to obsolete the non-IPC_64 interfaces?

if that is the case then can i rip all the non-IPC_64 parts out of ipc/*,
and let non-IPC_64 calls fail? Right now it's silent breakage that
happens.

or, in my threading tree, i introduced a /proc/sys/kernel/pid_max tunable,
which has the safe conservative value of 32K PIDs, but which can be
changed by the admin to have higher PIDs.

[anything more complex than this i think should be ignored - we do not
want to complicate PID allocations just for the sake of a single old
16-bit interface.]

	Ingo

