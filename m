Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266894AbRGIKcp>; Mon, 9 Jul 2001 06:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbRGIKcY>; Mon, 9 Jul 2001 06:32:24 -0400
Received: from [151.99.250.40] ([151.99.250.40]:5607 "EHLO
	mail2.cs.interbusiness.it") by vger.kernel.org with ESMTP
	id <S266894AbRGIKcS>; Mon, 9 Jul 2001 06:32:18 -0400
Date: Mon, 9 Jul 2001 12:23:52 +0200 (CEST)
From: Giuseppe Guerrini <guerrini@cnisrl.it>
To: linux-kernel@vger.kernel.org
cc: giusguerrini@racine.ra.it
Subject: Low latency patch for IDE (kernel 2.2.14)
Message-ID: <Pine.LNX.4.21.0107091115280.14334-100000@trantor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi all,

 I'm using (ok, still...) a RH 6.2 system with kernel 2.2.14, with RAID1
enabled. Under heavy disk load, the systen has a latency of up to 700
milliseconds. This harms my "almost-real-time" applications.
 After I unsuccessfully tried all usual system tunings (hdparm...), and
some low-latency patches kernel too, I decided to modify the IDE
driver. The problem was due to an "interrupt burst" that keeps the CPU
busy for a while. My patch defers the IDE interrupt handling by activating
a kernel thread that actually does the job. It works...

 You can find the patch (for kernel 2.2.14) here:

	http://www.geocities.com/giusguerrini/linux/llide-patch.txt

 Note that the kernel thread has a "SCHED_FIFO" scheduling policy, and a
real-time priority of 10. So, only processes of "real-time" class and
priority greater than 10 take advantage of it. Anyway, you can simply
change the policy to "SCHED_OTHER" in function "ide_thread".
 Note also that this is a quite drastic solution, that makes the disk
slower, and the CPU load greater (slightly).

 Comments are appreciated.

	Regards,

	Giuseppe Guerrini

		giusguerrini@racine.ra.it (HOME)
		guerrini@cnisrl.it (WORK)


 P.S. Please CC to "giusguerrini@racine.ra.it", because I'm not subscribed
to the list. Thank you.



