Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133030AbQL3Sr6>; Sat, 30 Dec 2000 13:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132788AbQL3Srj>; Sat, 30 Dec 2000 13:47:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9026 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135403AbQL3SrT>; Sat, 30 Dec 2000 13:47:19 -0500
Date: Sat, 30 Dec 2000 19:16:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rafal Boni <rafal.boni@eDial.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gregory Maxwell <greg@linuxpower.cx>
Subject: Re: 2.2.19pre3 and poor reponse to RT-scheduled processes?
Message-ID: <20001230191639.E9332@athlon.random>
In-Reply-To: <20001229161927.A560@xi.linuxpower.cx> <200012292154.QAA17527@ninigret.metatel.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012292154.QAA17527@ninigret.metatel.office>; from rafal.boni@eDial.com on Fri, Dec 29, 2000 at 04:54:23PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 04:54:23PM -0500, Rafal Boni wrote:
> Now my box behaves much more reasonably... I'll just have to beat harder
> on it and see what happens.

Another thing: while writing to disk if you want low latency readers you can
do:

	elvtune -r 1 /dev/hd[abcd]

The 1/2 seconds stalls you see could be just because of applications that waits
I/O synchronously while the elevator is reodering I/O requests (and even if the
elevator wouldn't reorder anything the new requests would go to the end of the
I/O queue so they would have some higher latency anyways). That's normal and if
it's the case to avoid those stalls you can only decrease the I/O load or
increase disk throughput ;). The important thing is that the kernel is
not sitting in a tight kernel loop without reschedule in it during such 2
seconds.

However 2.2.19pre3aa4 includes also the lowlatency bugfixes in case you have
tons of ram and you're sending huge buffers to syscalls.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
