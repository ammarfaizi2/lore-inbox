Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284386AbRLMRIe>; Thu, 13 Dec 2001 12:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284436AbRLMRIY>; Thu, 13 Dec 2001 12:08:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46202 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S284386AbRLMRIS>; Thu, 13 Dec 2001 12:08:18 -0500
Date: Thu, 13 Dec 2001 17:10:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <Pine.LNX.4.33.0112130803260.19406-100000@mf1.private>
Message-ID: <Pine.LNX.4.21.0112131657290.1540-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Wayne Whitney wrote:
> So it seems like for MAGMA I should be able to work around the fact that
> mmap()'s start at 0x40000000.  But as difficulties with other programs
> come up here fairly regularly, I still think it makes sense to fully
> understand the downside of modifying the kernel to allocate mmap() VMAs
> going downward.  If the downside is small, I think it is a good tradeoff.

My fear is that you may encounter an indefinite number of buggy apps,
which expect an mmap() to follow the mmap() before: easy bug to commit,
and to go unnoticed, until you reverse the layout.

As to where to place your stack: I don't know what assumptions are made
elsewhere, but a seemingly good place is just below the program's text
at 0x08048000.  People sometimes ask why i386 ELF text is usually placed
there: I think it's a convention of some other UNIX implementations,
which used to put stack below text and data above it, all sharing
the one page table (if it's a smallish process).

Hugh

