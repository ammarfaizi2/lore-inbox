Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131592AbRAHWQc>; Mon, 8 Jan 2001 17:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbRAHWQW>; Mon, 8 Jan 2001 17:16:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32290 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130195AbRAHWQM>; Mon, 8 Jan 2001 17:16:12 -0500
Date: Mon, 8 Jan 2001 23:15:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: Szabolcs Szakacsits <szaka@f-secure.com>,
        LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Subtle MM bug
Message-ID: <20010108231558.A27646@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101082207290.3435-100000@fs129-124.f-secure.com> <Pine.LNX.4.30.0101081357130.966-100000@mf2.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101081357130.966-100000@mf2.private>; from whitney@math.berkeley.edu on Mon, Jan 08, 2001 at 02:00:19PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 02:00:19PM -0800, Wayne Whitney wrote:
> I'd ask if this jives with your theory:  if I configure the linux kernel
> to be able to use 2GB of RAM, then the 870MB limit becomes much lower, to
> 230MB.

It's because the virtual address space for userspace tasks gets reduced
from 3G to 2G to give an additional giga of direct mapping to the kernel.

Also the other limit you hit (at around 800mbyte) is partly because
of the too low userspace virtual address space.

You can use this hack by me to allow the tasks to grow up to 3.5G per task on
IA32 on 2.4.0 (equivalent hack exists for 2.2.19pre6aa1 with bigmem, btw it
makes sense also without bigmem if you have lots of swap, that's all about
virtual memory not physical RAM).  However it doesn't work with PAE enabled
yet.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/per-process-3.5G-IA32-no-PAE-1

If you run your program on any 64bit architecture (in 64bit userspace mode)
supported by linux, you won't run into those per-process address space limits.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
