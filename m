Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUKOL7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUKOL7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUKOL7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:59:01 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:10730 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261574AbUKOL50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:57:26 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Nov 2004 12:56:05 +0100
MIME-Version: 1.0
Subject: CPU hogs ignoring SIGTERM (unkillable processes)
Message-ID: <4198A766.28114.106DD7B@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-3.84+2.20+2.07.066+02 August 2004+94336@20041115.114613Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today I've discovered a programming error in one of my programs (that's fixed 
already). When trying to replace the binary, I found out that the processes seem 
unaffected by a plain "kill": They just continue to consume CPU. However, a "kill 
-9" terminates them. ist that intended behavior? I guess not. Here are some facts:

top - 12:51:33 up 145 days, 22:20,  1 user,  load average: 8.06, 8.77, 9.51
Tasks:  85 total,   9 running,  76 sleeping,   0 stopped,   0 zombie
Cpu(s):  57.4% user,   1.9% system,   0.0% nice,  40.6% idle
Mem:    191192k total,    90716k used,   100476k free,    19004k buffers
Swap:   132088k total,    29140k used,   102948k free,    37580k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command
28042 daemon    25   0    92   32   28 R 13.2  0.0 163:59.44 extractMIME
29435 daemon    25   0    92   32   28 R 13.2  0.0 156:34.27 extractMIME
31211 daemon    25   0    92   32   16 R 13.2  0.0 145:12.22 extractMIME
  156 daemon    25   0    92   32   16 R 13.2  0.0 135:24.49 extractMIME
 4079 daemon    25   0    92   32   16 R 13.2  0.0 109:48.36 extractMIME

This is about 3 minutes after executing this command:
kill 27176 27457 28042 29435  31211 156 4079

This happened for both SUSE kernels, old and new:
m1 2.4.20-4GB #1 Mon Mar 17 17:54:44 UTC 2003
m2 2.6.5-7.111-default #1 Wed Oct 13 15:45:13 UTC 2004

And no, the C program does not install any signal handler. If interested I can 
provide the binary together with sample parameters to execute the loop.

Regards,
Ulrich

