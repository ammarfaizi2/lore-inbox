Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129682AbQKWAef>; Wed, 22 Nov 2000 19:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131762AbQKWAeZ>; Wed, 22 Nov 2000 19:34:25 -0500
Received: from nrg.org ([216.101.165.106]:20018 "EHLO nrg.org")
        by vger.kernel.org with ESMTP id <S129682AbQKWAeJ>;
        Wed, 22 Nov 2000 19:34:09 -0500
Date: Wed, 22 Nov 2000 16:04:05 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Latest preemptible kernel (low latency) patch available 
Message-ID: <Pine.LNX.4.05.10011221551330.19078-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MontaVista Software's latest preemptible kernel patch,
preempt-2.4.0-test11-1.patch.bz2, is now available in
ftp://ftp.mvista.com/pub/Area51/preemptible_kernel/
Here is an extract from the README file:

The patches in this directory, when applied to the corresponding
kernel source, will define a new configure option, 'Preemptable Kernel',
under the 'Processor type and features' section.  When enabled, and the
kernel is rebuilt it will be fully preemptable, subject to SMP lock
areas (i.e. it uses SMP locking on a UP to control preemptability).

The patch can only be enabled for ix86 uniprocessor platforms.
(Stay tuned for other platforms and SMP support.)

Notes for preempt-2.4.0-test11-1.patch
--------------------------------------

 - Updated to kernel 2.4.0-test11

Notes for preempt-2.4.0-test10-1.patch
--------------------------------------

The main changes between this and previous patches are:

 - Updated to kernel 2.4.0-test10
 - Long held spinlocks changed into mutex locks, currently implemented
   using semaphores.  (We are working on a fast, priority inheriting,
   binary semaphore implementation of these locks.)

The patch gives good results on Benno's Audio-Latency test
http://www.gardena.net/benno/linux/audio/, with maximum
latencies less than a couple of milliseconds recorded
using a 750MHz PIII machine.  However, there are still
some >10ms non-preemptible paths that are not exercised
by this test.

The worst non-preemtible paths are now dominated by the big
kernel lock, which we hope can be completely eliminated in 2.5
by finer grained locks.

(I will be at the Linux Real-Time Workshop in Orlando next week, and
may not be able to access my work email address (nigel@mvista.com),
which is why I'm posting this from my personal address.)

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
