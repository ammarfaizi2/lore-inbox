Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQKQPuL>; Fri, 17 Nov 2000 10:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbQKQPuB>; Fri, 17 Nov 2000 10:50:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15378 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129573AbQKQPtq>; Fri, 17 Nov 2000 10:49:46 -0500
Date: Fri, 17 Nov 2000 16:18:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117161833.A27098@athlon.random>
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwwpujuvk1s.fsf@sap.com>; from cr@sap.com on Fri, Nov 17, 2000 at 01:51:11PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 01:51:11PM +0100, Christoph Rohland wrote:
> gettimeofday is _way_ to slow for a lot of every day uses. So
> applications will use rdtsc until we have some really fast
> (non-syscall) way to have high resolution time diffs.

During the x86-64 design I made sure that in x86-64 glibc will only know about
vgettimeofday (vsyscall).

If the machine is Asymetric MP with CPU running at different frequency (so that
you need to know on which CPU you're running on to use rdtsc) the kernel will
setup the vsyscall trampoline to fallback in the real slow syscall (but all SMP
and UP machines will not need to enter/exit kernel this way and the vsyscall
will be completly lock less... for obvious reasons :).

So as worse you'll have to wait x86-64 to get that lightweight vgettimeofday.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
