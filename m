Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSEFIVD>; Mon, 6 May 2002 04:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314282AbSEFIVC>; Mon, 6 May 2002 04:21:02 -0400
Received: from [202.135.142.194] ([202.135.142.194]:33550 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314280AbSEFIVC>; Mon, 6 May 2002 04:21:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] New 2.5.14 Hotplug CPU Work
Date: Mon, 06 May 2002 18:24:32 +1000
Message-Id: <E174dnM-0007ns-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	After some delay, a new scratch implementation of hotplug CPU
for x86 is available:

	www.[country].kernel.org/pub/linux/kernel/people/rusty

1) Cleans up the init thread creation code so it's workable after
   boot.
2) Removes the number/logical mapping of CPUs, and smp_num_cpus().
3) Changes the boot sequence so it all happens on UP, then the other
   CPUs are "plugged in".

I'm pretty happy with the simpler boot code, but there are several
problems with this version:

1) It needs synchronize_kernel to be 100% correct, which was broken by
   preempt.
2) It sometimes crashes on x86, because I don't think I untwisted the
   boot process correctly.
3) It only supports x86.

Comments welcome!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
