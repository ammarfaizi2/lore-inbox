Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291776AbSBAPGC>; Fri, 1 Feb 2002 10:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291786AbSBAPFw>; Fri, 1 Feb 2002 10:05:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1971 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291776AbSBAPFd>;
	Fri, 1 Feb 2002 10:05:33 -0500
Date: Fri, 1 Feb 2002 18:03:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <87vgdhw8lt.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0202011801260.11284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Feb 2002, Momchil Velikov wrote:

> Ingo> files are used. With one big file (or a few big files), the i_shared_lock
> Ingo> will always bounce between CPUs wildly in read() workloads, degrading
>
> Will there be difference between bounces of a rwlock in the radix tree
> variant and the cache misses in hashed locks variant for the case of
> concurrently accessed large file ?

definitely, because in the case of page buckets there are many locks
hashed in a mapping-neutral way. Ie. different parts of the same file will
likely map to different spinlocks. In the radix tree case all pages in the
inode will map to the same spinlock.

	Ingo

