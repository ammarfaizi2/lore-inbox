Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271311AbRHUK6q>; Tue, 21 Aug 2001 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271388AbRHUK6h>; Tue, 21 Aug 2001 06:58:37 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:57258 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271311AbRHUK6Q>; Tue, 21 Aug 2001 06:58:16 -0400
Date: Tue, 21 Aug 2001 11:59:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Rohland <cr@sap.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Andersen <andersee@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <m3lmkd6ds0.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2001, Christoph Rohland wrote:
> 
> sysinfo does use a new mem_unit field if ram+swap > MAX_ULONG. That
> breaks 2.2 compatibility for a lot machines.
> 
> I think it is more resonable to use the mem_unit field only if one of
> ram or swap is bigger than MAX_ULONG. (And 2.2 was only broken in that
> case)

It's arguable.  When I went there a few months back, I was a little
surprised by the way it adds ram+swap (it mistakenly added in more
before) to make that decision; but concluded it was helping callers
who might well go on to add ram+swap, and felt no overriding reason
to change that.  But you can certainly argue that's inappropriate
for the kernel to do, that it should only guard the validity of
the actual numbers it returns to the caller.  No strong feelings.

> The appended patch implements that (and makes the logic a little bit
> easier)

Alan, please don't apply.  The patch made the logic a lot easier,
but sadly wrong: try what happens to totalswap 0x00120000 with
mem_unit 0x1000 - wrong decision since 0x20000000 > 0x00120000.

Hugh

