Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUHHTBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUHHTBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUHHTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:01:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32996 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266187AbUHHTBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:01:38 -0400
Date: Sun, 8 Aug 2004 20:01:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: ak@muc.de, <mpm@selenic.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow to disable shmem.o
In-Reply-To: <20040808113732.3416a4ee.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408081944430.2377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > But somehow I still prefer Matt's patch, which offers a lot more.
> 
> Me too - it's sneaky.
> 
> I suspect it's more SMp scalable than shmem.c too?

I bet it is (unless it falls into generic filepage overheads
which shmem is skating past e.g. attempts to readahead).

Though I hope not notably more so by the time I've finished
reworking shmem_getpage (was on the right track yesterday,
but other issues have intervened today).

They should both come down to find_get_page (find_lock_page in
shmem.c's case, only an issue when contention on same page),
alloc_page, add_to_page_cache: contention on tree_lock.

Its main deficiency (aside from the lack of swap use, which in
some contexts is a plus) is its lack of resource limiting.

Hugh

