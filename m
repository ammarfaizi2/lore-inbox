Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131540AbQLLA5O>; Mon, 11 Dec 2000 19:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbQLLA5E>; Mon, 11 Dec 2000 19:57:04 -0500
Received: from cip.physik.uni-wuerzburg.de ([132.187.42.13]:10768 "EHLO
	wpax13.physik.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id <S131540AbQLLA4v>; Mon, 11 Dec 2000 19:56:51 -0500
Date: Tue, 12 Dec 2000 01:09:27 +0100 (MET)
From: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in scsi.c
In-Reply-To: <E144ACA-00038L-00@the-village.bc.nu>
Message-ID: <Pine.GHP.4.21.0012120044390.20976-100000@wpax13.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alan Cox wrote:

> Andreas is looking at a slightly older kernel, and was right for that. Every
> caller to daemonize either then did the file stuff or needed to and forgot
> so I fixed daemonize

I think, there ist still a small bug.
(This time I even checked 2.4.0-test12-pre8)

In linux/arch/i386/kernel/process.c, function kernel_thread, line 453 the
flag CLONE_VM is always used.

In sched.c, function daemonize, line 1216 you call exit_mm.

Since the memory is cloned, you  will take away the mem from your
user-space-application as well. So if insmod is already running at that
time, it has to segvault. If I am not wrong at this point CLONE_VM simply
has to be removed from kernel_thread. The kernel-thread will free his mem
in daemonize (calling exit_mm) and the user-space-application will free
the mem when exiting.

Bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
