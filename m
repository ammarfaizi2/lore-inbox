Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUHHQFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUHHQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUHHQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:05:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11394 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265697AbUHHQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:05:08 -0400
Date: Sun, 8 Aug 2004 17:04:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow to disable shmem.o
In-Reply-To: <20040808140705.GH16310@waste.org>
Message-ID: <Pine.LNX.4.44.0408081649420.1983-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Matt Mackall wrote:
> On Sun, Aug 08, 2004 at 02:03:09PM +0100, Hugh Dickins wrote:
> > 
> > But I prefer Matt's tiny tiny-shmem.c which does support all those,
> > using ramfs instead, and says in Kconfig what it's doing.
> > But perhaps you're wanting to avoid ramfs too?
> 
> Ramfs is hard to avoid as it's used internally for / at boot and so on.

Ah, right.

> My patch for comparison. Comments appreciated.

Looks pretty good, but would need rediffing against mainline or -mm
if heading that way: the init/Kconfig patch is peculiar to your -tiny.

The comment at the head of tiny-shmem.c:

> + * This is intended for small system where the benefits of the full
> + * shmem code (swap-backed and resource-limited) are outweighed by their
> + * complexity. On systems without swap and not using userspace /dev/shm,
> + * this code should be effectively equivalent, but much lighter weight.

Very fair statement.  But isn't it actually supporting /dev/shm fine?

And your shmem_file_setup hasn't quite kept up with the times:
shmat oopses in vma_link because shmem_file_setup is lacking a

	file->f_mapping = inode->i_mapping;

Plus Andi rightly advises externs in a header file.

Hugh

