Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWAULzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWAULzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWAULze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:55:34 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:17343 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932156AbWAULze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:55:34 -0500
Message-ID: <43D22139.2000208@t-online.de>
Date: Sat, 21 Jan 2006 12:55:37 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [BUG] Timer subsystem broken for Pentium M / early XEON / P6 family
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: XpgytTZdQeq+0SMmysU6PkaCiV1nHEDMoBKIFYGXb2aRr26gavZewY@t-dialin.net
X-TOI-MSGID: 4ecc01bb-4edc-4ea1-b65e-9a0ccfd27ea4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Have a look at the system log of a kernel compile on a Pentium M 750 system.
Speedstep is enabled, the kernel was booted with cpufreq.debug=2, the kernel
is configured to give timing informations on printks. Timer frequency is 
1000 Hz.

Kernel is 2.6.15-git7 + some changes unrelated to the timer subsystem.

Jan 21 10:14:42 linux kernel: [ 1260.867085] speedstep-centrino: no 
change needed - msr was and needs to be 612
Jan 21 10:14:43 linux kernel: [ 1261.081077] speedstep-centrino: no 
change needed - msr was and needs to be 612
Jan 21 10:14:45 linux kernel: [ 1262.150884] speedstep-centrino: 
target=1080050kHz old=800000 new=1067000 msr=0817
Jan 21 10:14:46 linux kernel: [ 947.401994] speedstep-centrino: no 
change needed - msr was and needs to be 817
Jan 21 10:14:46 linux kernel: [ 947.616092] speedstep-centrino: no 
change needed - msr was and needs to be 817
Jan 21 10:14:47 linux kernel: [ 947.830189] speedstep-centrino: 
target=1360100kHz old=1067000 new=1333000 msr=0a1c
Jan 21 10:14:47 linux kernel: [ 757.097509] speedstep-centrino: no 
change needed - msr was and needs to be a1c
Jan 21 10:14:48 linux kernel: [ 757.311216] speedstep-centrino: no 
change needed - msr was and needs to be a1c
Jan 21 10:14:48 linux kernel: [ 757.524922] speedstep-centrino: 
target=1640150kHz old=1333000 new=1600000 msr=0c21
Jan 21 10:14:52 linux kernel: [ 632.382043] speedstep-centrino: no 
change needed - msr was and needs to be c21
Jan 21 10:14:52 linux kernel: [ 632.595621] speedstep-centrino: no 
change needed - msr was and needs to be c21
Jan 21 10:14:53 linux kernel: [ 632.809197] speedstep-centrino: 
target=1867000kHz old=1600000 new=1867000 msr=0e26
Jan 21 10:32:46 linux kernel: [ 1001.352174] speedstep-centrino: 
target=1773650kHz old=1867000 new=1600000 msr=0c21
Jan 21 10:32:47 linux kernel: [ 1167.961176] speedstep-centrino: 
target=1867000kHz old=1600000 new=1867000 msr=0e26
Jan 21 10:32:53 linux kernel: [ 1004.496699] speedstep-centrino: 
target=1773650kHz old=1867000 new=1600000 msr=0c21
Jan 21 10:32:55 linux kernel: [ 1172.054711] speedstep-centrino: no 
change needed - msr was and needs to be c21
Jan 21 10:32:57 linux kernel: [ 1172.909018] speedstep-centrino: 
target=1586950kHz old=1600000 new=1333000 msr=0a1c
Jan 21 10:33:01 linux kernel: [ 1410.056608] speedstep-centrino: no 
change needed - msr was and needs to be a1c
Jan 21 10:33:03 linux kernel: [ 1410.911434] speedstep-centrino: no 
change needed - msr was and needs to be a1c
Jan 21 10:33:05 linux kernel: [ 1411.766261] speedstep-centrino: 
target=1306900kHz old=1333000 new=1067000 msr=0817
Jan 21 10:33:06 linux kernel: [ 1768.140232] speedstep-centrino: 
target=1400250kHz old=1067000 new=1333000 msr=0a1c
Jan 21 10:33:08 linux kernel: [ 1412.792040] speedstep-centrino: 
target=1306900kHz old=1333000 new=1067000 msr=0817
Jan 21 10:33:10 linux kernel: [ 1770.067082] speedstep-centrino: no 
change needed - msr was and needs to be 817
Jan 21 10:33:12 linux kernel: [ 1770.923466] speedstep-centrino: no 
change needed - msr was and needs to be 817
Jan 21 10:33:14 linux kernel: [ 1771.779852] speedstep-centrino: 
target=1026850kHz old=1067000 new=800000 msr=0612
Jan 21 10:33:16 linux kernel: [ 2361.795520] speedstep-centrino: no 
change needed - msr was and needs to be 612
Jan 21 10:33:18 linux kernel: [ 2362.651387] speedstep-centrino: no 
change needed - msr was and needs to be 612

Pentium 4 and Xeon model 3 and above increment the time stamp counter at 
a constant rate independent of the
current cpu frequency. Pentium M, Xeon up to model 2 and the P6 family 
increment with every internal processor
cycle. This behaviour is documented in chapter 18.8 of IA-32 Intel® 
Architecture Software Developer’s Manual,
Volume 3B: System Programming Guide, Part 2, Order Number: 253669-018, 
January 2006.

The timing information on printks should be monotone, it should be 
accurate, and it should be somewhat related to
the system time.

Obviously printk time jumps. But it is also inaccurate compared against 
system time: 10:33:18 is
1116 seconds after 10:14:42, and so the printk time at 10:33:18 should 
be 1260+1116==2376 and not 2362.
That means printk time lost 14 seconds against system time in less that 
20 Minutes.

Someone should have a close look at the code.

cu,
Knut
