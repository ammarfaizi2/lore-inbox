Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293171AbSBWSdy>; Sat, 23 Feb 2002 13:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293170AbSBWSdo>; Sat, 23 Feb 2002 13:33:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27016 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293173AbSBWSdZ>;
	Sat, 23 Feb 2002 13:33:25 -0500
Date: Sat, 23 Feb 2002 21:31:31 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <20020223102805.F11156@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0202232128450.15230-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Feb 2002, Larry McVoy wrote:

> Exactly.  SMP gives you coherent memory and test-and-set or some other
> atomic operation.  Why not use it?

the userspace library side does it. The kernel patch is the slowpath, the
fast path (no contention) happens in user-space, using SMP-atomic
instructions. It's all very nice and lightweight.

also as far as i can see, this implementation enables semaphores to live
anywhere within the VM, the /dev/usem is just a hack to communicate this
VM address to the kernel-space code. So i think the patch's concepts are
really nice, except the interface cleanliness issue which shouldnt be too
hard to fix - adding new syscalls is pleasant work anyway :-)

	Ingo

