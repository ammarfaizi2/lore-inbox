Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291198AbSAaRsP>; Thu, 31 Jan 2002 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291199AbSAaRsG>; Thu, 31 Jan 2002 12:48:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:275 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291198AbSAaRr7>; Thu, 31 Jan 2002 12:47:59 -0500
Date: Thu, 31 Jan 2002 09:46:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131153607.C1309@athlon.random>
Message-ID: <Pine.LNX.4.33.0201310942210.1537-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
>
> but with the radix tree (please correct me if I'm wrong) the height will
> increase eventually, no matter what (so it won't be an effective O(1)
> like the hashtable provides in real life, not the worst case, the common
> case). With the hashtable the height won't increase instead.

No.

The radix tree is basically O(1), because the maximum depth of a 7-bit
radix tree is just 5. The index is only a 32-bit number.

We could, in fact, make all page caches use a fixed-depth tree, which is
clearly O(1). But the radix tree is slightly faster and tends to use less
memory under common loads, so..

Remember: you must NOT ignore the constant part of a "O(x)" equation.
Hashes tend to be effectively O(1) under most loads, but they have cache
costs, and they have scalability costs that a radix tree doesn't have.

		Linus

