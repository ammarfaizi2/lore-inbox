Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSICTj3>; Tue, 3 Sep 2002 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSICTj3>; Tue, 3 Sep 2002 15:39:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36513 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S318891AbSICTj2>; Tue, 3 Sep 2002 15:39:28 -0400
Date: Tue, 3 Sep 2002 20:43:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mremap corrupts freed vma
In-Reply-To: <Pine.LNX.4.44.0208192311300.6887-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209032031090.2200-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Hugh Dickins wrote:
> My tricksy accounting code in mremap's move_vma assumed 2.4 behaviour
> in do_munmap, which preserved vma: but 2.5 splitvma may substitute it.
> Showed up as Committed_AS growing each time kernel built with kallsyms;
> but more seriously, it was writing to an area already kmem_cache_freed.

Thanks, Christoph: your split_vma mods in 2.5.33-mm1 fix that issue.

(Linus didn't apply my patch: maybe he just missed it, or maybe he 
saw, as I later did, that it would be a lot better to use splitvma
inside move_vma, instead of second-guessing what do_munmap might do.
But when I went to do so, I recoiled in fright from trying to work out
the right handling of splitvma error which move_vma currently forgets.)

Hugh

