Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbRAHU0P>; Mon, 8 Jan 2001 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbRAHU0F>; Mon, 8 Jan 2001 15:26:05 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:15110 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129904AbRAHUZt>; Mon, 8 Jan 2001 15:25:49 -0500
Date: Mon, 8 Jan 2001 22:39:43 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@suse.de>, Wayne Whitney <whitney@math.berkeley.edu>
Subject: Re: Subtle MM bug
Message-ID: <Pine.LNX.4.30.0101082207290.3435-100000@fs129-124.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen <ak@suse.de> wrote:
> On Sun, Jan 07, 2001 at 09:29:29PM -0800, Wayne Whitney wrote:
> > package called MAGMA; at times this requires very large matrices. The
> > RSS can get up to 870MB; for some reason a MAGMA process under linux
> > thinks it has run out of memory at 870MB, regardless of the actual
> > memory/swap in the machine. MAGMA is single-threaded.
> I think it's caused by the way malloc maps its memory.
> Newer glibc should work a bit better by falling back to mmap even
> for smaller allocations (older does it only for very big ones)

AFAIK newer glibc = CVS glibc but the malloc() tune parameters
work via environment variables for the current stable ones as well,
e.g. to overcome the above "out of memory" one could do,
% export MALLOC_MMAP_MAX_=1000000
% export MALLOC_MMAP_THRESHOLD_=0
% magma

At default, on a 32bit Linux current stable glibc malloc uses brk
between 0x08??????-0x40000000 and max (MALLOC_MMAP_MAX_) 128 mmap if
the requested chunk is greater than 128 kB (MALLOC_MMAP_THRESHOLD_).
If MAGMA mallocs memory in less than 128 kB chunks then the above out
of memory behaviour is expected.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
