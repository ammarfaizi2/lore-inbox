Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJJEF6>; Wed, 10 Oct 2001 00:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274667AbRJJEFv>; Wed, 10 Oct 2001 00:05:51 -0400
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:397 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S274653AbRJJEFg>; Wed, 10 Oct 2001 00:05:36 -0400
Message-ID: <07d601c15140$f07c2870$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Bryan Mayland" <bmayland@leoninedev.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.efssf0v.146031s@ifi.uio.no>
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
Date: Wed, 10 Oct 2001 00:06:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've run several LMbench tests against both 686-optimized
> and Athlon-optimized kernels.  The results waver across multiple
> tests, one kernel winning some tests one time and losing the next,
> but the values are all close.

The benefits of the kernel Athlon optimizations are higher memory bandwidth
for bulk copies/clears and less cache pollution. But LMbench isn't going to
show any difference, because its tests use generic x86 mem*() functions, not
Athlon-optimized SSE memory routines like in the Athlon kernel.

*Local* Communication bandwidths in MB/s - bigger is better
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read
write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- ----
-
Athlon-1  Linux 2.4.10- 847. 685. 311.  332.4  501.3  176.2  206.2 471.
342.5
Athlon-2  Linux 2.4.10- 882. 586. 187.  331.6  510.2  177.6  207.1 484.
343.5
i686-1    Linux 2.4.10- 863. 586. 299.  320.0  510.2  176.3  206.6 472.
342.6
i686-2    Linux 2.4.10- 874. 318. 199.  319.6  520.2  177.7  206.8 486.
343.5

It should be obvious that LMbench uses sub-optimal memory routines, since
the numbers for "Bcopy" and "Mem read/write" bandwidth are so much lower
than pipe and AF UNIX bandwidths! (the pipe/UNIX tests are basically
equivalent to Bcopy, plus extra user<->kernel transitions and context
switches).

The only cases where I'd expect the Athlon kernel to do better on LMbench
are essentially kernel memcpy() benchmarks - pipe and AF UNIX bandwidths.
I'm not sure if the kernel pipe and UNIX socket code actually uses
Athlon-optimized routines; in any case the small buffer sizes (eg 4KB for
pipes) could be hiding any performance gain.

Regards,
Dan



