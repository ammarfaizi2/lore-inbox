Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291862AbSBARIZ>; Fri, 1 Feb 2002 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291858AbSBARIG>; Fri, 1 Feb 2002 12:08:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2825 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291857AbSBARH5>; Fri, 1 Feb 2002 12:07:57 -0500
Date: Fri, 1 Feb 2002 09:06:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Momchil Velikov <velco@fadata.bg>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202010903060.2634-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Ingo Molnar wrote:
>
> it's not just databases. It's webservers too, serving content via
> sendfile() from a single, bigger file. Think streaming media servers,
> where the 'movie of the night' sits in a single big binary glob.

Hey guys, be _realistic_.

Don't bother with "oh, this could be bad", when there are absolutely _no_
numbers showing any such badness.

Even databases often use multiple files, and quite frankly, a database
that doesn't use mmap and doesn't try very hard to not cause extra system
calls is going to be bad performance-wise _regardless_ of any page cache
locking.

Radix-trees are cleaner than the alternatives, and all the numbers anybody
has ever shown shows them to be at least equal in performance.

Stop making up things that just are NOT problems.

In web-servers, 99% of the content is small files, and if the file is
cached the expensive parts are all elsewhere. Don't make up "worst case
schenarios" that simply do no exist.

		Linus

