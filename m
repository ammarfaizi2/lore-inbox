Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292091AbSBAVs0>; Fri, 1 Feb 2002 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292092AbSBAVsG>; Fri, 1 Feb 2002 16:48:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47583 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292091AbSBAVr4>;
	Fri, 1 Feb 2002 16:47:56 -0500
Date: Sat, 2 Feb 2002 00:45:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <87y9idusst.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0202020043230.19061-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Feb 2002, Momchil Velikov wrote:

> Ingo> definitely, because in the case of page buckets there are many locks
> Ingo> hashed in a mapping-neutral way. Ie. different parts of the same file will
> Ingo> likely map to different spinlocks.
>
> That's why it's likely to miss on each access.

yes, you are right.

> Ingo> In the radix tree case all pages in the inode will map to the
> Ingo> same spinlock.
>
> That's why it's likely to bounce on each access.
>
> So, is there any difference ? :)

no difference. I tried to create a testcase that shows the difference
(multiple processes read()ing a single big file on an 8-way box), but
performance was equivalent. So given the clear advantages of radix trees
in other areas, they win hands down. :)

	Ingo

