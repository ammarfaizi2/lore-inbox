Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263484AbSJGV5a>; Mon, 7 Oct 2002 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263485AbSJGV53>; Mon, 7 Oct 2002 17:57:29 -0400
Received: from mailman.xyplex.com ([140.179.176.116]:55516 "EHLO
	mailman.xyplex.com") by vger.kernel.org with ESMTP
	id <S263484AbSJGV51>; Mon, 7 Oct 2002 17:57:27 -0400
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A046A38@ltnmail.xyplex.com>
From: "Dow, Benjamin" <bdow@itouchcom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kernel memory leak?
Date: Mon, 7 Oct 2002 17:58:56 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I (read: my company) am working on a semi-embedded system (no swap, booting
onto a ramdisk), and I recently changed linux kernels from 2.4.9 to 2.4.19.
Nearly everything works fine, except that whenever I read a file, it
allocates 4k of memory (cat /proc/meminfo reports 4k less memory, and
/proc/slabinfo reports that buffer_head increases by 4k, but those are the
only changes).  I found a thread from back in July or so on LKML where
somebody had a similar problem on 2.4.19-rc3, and Rik said that this was
normal, and the vm would release this memory under pressure, except when I
start a bunch of processes to use up memory and repeatedly cat
/proc/meminfo, the OOM killer is eventually triggered.

I'm running 2.4.19 with both the low-latency and kernel preemption patches
applied (though I recompiled the kernel with those disabled and the problem
still occurred), as well as a few changes of our own (though none of those
seem to touch the filesystem/vm layers).  It's a powerpc chip with 64 megs
of ram (roughly 28 of which are free after we load the kernel/ramdisk and
all our apps).  I tried to reproduce the problem on my PC (booted up without
X, specified mem=8M on command line, and turned off swap), which is also
2.4.19 and also has the kernel preemption and low-latency patches applied,
but is not booting from a ramdisk and is, obviously, a different
architecture, and it did allocate 4k blocks for a while, but then stopped
(or, more accurately, it would allocate 4k and then the next time I did a
cat /proc/meminfo it would be back to its original value).

So I guess my question is:
1) What is eating up memory and not allowing it to be freed, and
2) Why does it allocate 4k of memory every single time I access a file,
anyway?

Any help would be greatly appreciated.
