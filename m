Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRDFVVX>; Fri, 6 Apr 2001 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDFVVO>; Fri, 6 Apr 2001 17:21:14 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:57565 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132407AbRDFVVB>; Fri, 6 Apr 2001 17:21:01 -0400
Date: Fri, 6 Apr 2001 22:21:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, majer@endeca.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: memory allocation problems
In-Reply-To: <Pine.LNX.4.30.0104061227240.25381-100000@mf1.private>
Message-ID: <Pine.LNX.4.21.0104062211470.1572-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Wayne Whitney wrote:
> 
> As was pointed out to me in January, another solution for i386 would be to
> fix a maximum stack size and have the mmap() allocations grow downward
> from the "top" of the stack (3GB - max stack size).  I'm not sure why that
> is not currently done.

I'd be interested in the answer to that too.  Typically, the memory
layout has ELF text at the lowest address, starting at 0x08048000 -
which is a curious place to put it, until you realize that if you
place the stack below it, you can use (in a typical small program)
just one page table for stack + text + data (then another for mmaps
and shared libs from 3GB down): two page tables instead of present three.

Hugh

