Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135442AbRAIAiq>; Mon, 8 Jan 2001 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRAIAi1>; Mon, 8 Jan 2001 19:38:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7172 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135442AbRAIAiK>; Mon, 8 Jan 2001 19:38:10 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Subtle MM bug
Date: 8 Jan 2001 16:37:45 -0800
Organization: Transmeta Corporation
Message-ID: <93dmgp$6bu$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0101081352400.954-100000@mf2.private> <Pine.LNX.4.30.0101081515090.18737-100000@mf1.private> <20010109003002.L27646@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010109003002.L27646@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Mon, Jan 08, 2001 at 03:22:44PM -0800, Wayne Whitney wrote:
>> I guess I conclude that either (1) MAGMA does not use libc's malloc
>> (checking on this, I doubt it) or (2) glibc-2.1.92 knows of these
>> variables but has not yet implemented the tuning (I'll try glibc-2.2) or
>> (3) this is not the problem.
>
>You should monitor the program with strace while it fails (last few syscalls).
>You can breakpoint at exit() and run `cat /proc/pid/maps` to show us the vma
>layout of the task. Then we'll see why it's failing.  With CONFIG_1G in 2.2.x
>or 2.4.x (confinguration option doesn't matter) you should at least reach
>something like 1.5G.

It might be doing its own memory management with brk() directly - some
older UNIX programs will do that (for various reasons - it can be faster
than malloc() etc if you know your access patterns, for example).

If you do that, and you have shared libraries, you'll get a failure
around the point Wayne sees it. 

But your suggestion to check with strace is a good one.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
