Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267772AbRGQGKZ>; Tue, 17 Jul 2001 02:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbRGQGKQ>; Tue, 17 Jul 2001 02:10:16 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26560 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S267772AbRGQGKH>; Tue, 17 Jul 2001 02:10:07 -0400
Date: Tue, 17 Jul 2001 15:10:04 +0900
Message-ID: <wv5813yb.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.4.6] PPID of a process is set to itself
Newsgroups: linux.dev.kernel
In-Reply-To: <200107170441.f6H4fux15702@penguin.transmeta.com>
In-Reply-To: <k818gp7s.wl@nisaaru.open.nm.fujitsu.co.jp>
	<200107170441.f6H4fux15702@penguin.transmeta.com>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At Mon, 16 Jul 2001 21:41:56 -0700,
Linus Torvalds wrote:
> 
> HOWEVER, the bug you hit is because CLONE_THREAD also implies
> CLONE_PARENT, and the fork() code didn't actually enforce this. So
> instead of your patch, we just should not allow the parent and the child
> to be in the same thread group. Suggested real patch appended. Does this
> fix it for you too?

Thank you for the patch. 
I tried it and found the the process cloned by my test program became
the zombie child of my shell and is not reaped because the shell is
not expecting the process.

# ps lw
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
000     0  1180  1176  14   0  3392 1640 wait4  S    pts/1      0:00 bash
144     0  1249  1180   9   0     0    0 do_exi Z    pts/1      0:00 [a.out <defunct>]
100     0  1279  1180  15   0  3272 1440 -      R    pts/1      0:00 ps lw


This is okay because when the shell is terminated, the child is also reaped,
but it seems a little strange.
