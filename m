Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbRG2U4R>; Sun, 29 Jul 2001 16:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268152AbRG2U4G>; Sun, 29 Jul 2001 16:56:06 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:47120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268151AbRG2Uzs>; Sun, 29 Jul 2001 16:55:48 -0400
Date: Sun, 29 Jul 2001 13:52:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hold cow while breaking
In-Reply-To: <Pine.LNX.4.21.0107292107160.1014-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107291350540.937-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sun, 29 Jul 2001, Hugh Dickins wrote:
>
> Sorry for being dense, but I still don't get it.  I thought the
> down_read on mmap_sem is permitting concurrent faults by other users
> of the address space (but excluding structural changes to the address
> space)?  and we haven't locked the page itself, and we've temporarily
> dropped the page_table_lock.  I just don't see what lock prevents the
> page from being refaulted in.

Ehh, you're right. But you're still wrong, I think.

Because we hold the mm semaphore, nobody can change the mapping on us.

Which means that even if we first page somthing out and page something
else in to the same page, that "something else" has to be the same thing.
See?

		Linus

