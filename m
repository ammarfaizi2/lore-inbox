Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAHXaD>; Mon, 8 Jan 2001 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHX3x>; Mon, 8 Jan 2001 18:29:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:48939 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129226AbRAHX3t>; Mon, 8 Jan 2001 18:29:49 -0500
Date: Tue, 9 Jan 2001 00:30:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: Szabolcs Szakacsits <szaka@f-secure.com>,
        LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Subtle MM bug
Message-ID: <20010109003002.L27646@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101081352400.954-100000@mf2.private> <Pine.LNX.4.30.0101081515090.18737-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101081515090.18737-100000@mf1.private>; from whitney@math.berkeley.edu on Mon, Jan 08, 2001 at 03:22:44PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:22:44PM -0800, Wayne Whitney wrote:
> I guess I conclude that either (1) MAGMA does not use libc's malloc
> (checking on this, I doubt it) or (2) glibc-2.1.92 knows of these
> variables but has not yet implemented the tuning (I'll try glibc-2.2) or
> (3) this is not the problem.

You should monitor the program with strace while it fails (last few syscalls).
You can breakpoint at exit() and run `cat /proc/pid/maps` to show us the vma
layout of the task. Then we'll see why it's failing.  With CONFIG_1G in 2.2.x
or 2.4.x (confinguration option doesn't matter) you should at least reach
something like 1.5G.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
