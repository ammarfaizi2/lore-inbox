Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUDIVq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUDIVq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:46:59 -0400
Received: from smtp06.web.de ([217.72.192.224]:34494 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261479AbUDIVqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:46:51 -0400
Message-ID: <407719E5.8050203@web.de>
Date: Fri, 09 Apr 2004 23:47:17 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 latencytest +aa5 +mm3 as/cfq scheduler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've done some benchs with: 
http://www.alsa-project.org/~iwai/alsa.html#LatencyTest

Test condition:
   CPU load = 0.8
   RTC freq = 1024
   RTC wakeup count = 2
   Deadline = 2
   X-test = yes
   Proc-test = yes
   Disk-test = yes
   Filesize = 1000000000

With the last stable kernel release 2.6.5 compared with -aa5 and -mm3 to 
see which scheduler/kernel has a good or low latency.
XP Barton 2800+, 512MB PC-333, Abit NF-S-V2 nForce2, SATA Maxtor 80GB, 
ASUS 5700 FX. Fedora Core 1.91 test2, xorg-x11-0.6.6-0.2004_03_30.5, GNOME 
2.6, libata, reiserfs. Same .config as possible. All fresh booted in 
init5, latencytest-0.5.2 running in each case from an xterm.

---------- 2.6.5-mm3 CFQ scheduler ----------
x11.log:
cpu_hz = 2.08855e+09
cpu_load=0.800000  loops per run = 645209
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.06087 ms (overrun 0)
within 1ms = 39555, factor = 99.9798%
within 2ms = 39563, factor = 100%
deviation = 0.021617

proc.log:
cpu_hz = 2.08855e+09
cpu_load=0.800000  loops per run = 645240
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.02978 ms (overrun 0)
within 1ms = 15406, factor = 99.9676%
within 2ms = 15411, factor = 100%
deviation = 0.0219986

diskwrite.log:
cpu_hz = 2.08855e+09
cpu_load=0.800000  loops per run = 645217
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.03607 ms (overrun 0)
within 1ms = 15484, factor = 99.9548%
within 2ms = 15491, factor = 100%
deviation = 0.0451227

diskcopy.log:
cpu_hz = 2.08855e+09
cpu_load=0.800000  loops per run = 644828
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.0494 ms (overrun 0)
within 1ms = 53058, factor = 99.9699%
within 2ms = 53074, factor = 100%
deviation = 0.0380116

diskread.log:
cpu_hz = 2.08855e+09
cpu_load=0.800000  loops per run = 645205
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.25948 ms (overrun 0)
within 1ms = 37351, factor = 99.9304%
within 2ms = 37377, factor = 100%
deviation = 0.0339693

---------- 2.6.5-mm3 AS scheduler ----------
x11.log:
cpu_hz = 2.08832e+09
cpu_load=0.800000  loops per run = 645104
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.05296 ms (overrun 0)
within 1ms = 38316, factor = 99.9791%
within 2ms = 38324, factor = 100%
deviation = 0.0216183

proc.log:
cpu_hz = 2.08832e+09
cpu_load=0.800000  loops per run = 645163
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.03901 ms (overrun 0)
within 1ms = 15405, factor = 99.9546%
within 2ms = 15412, factor = 100%
deviation = 0.0223874

diskwrite.log:
cpu_hz = 2.08832e+09
cpu_load=0.800000  loops per run = 645114
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.06489 ms (overrun 0)
within 1ms = 16688, factor = 99.9521%
within 2ms = 16696, factor = 100%
deviation = 0.0433707

diskcopy.log:
cpu_hz = 2.08832e+09
cpu_load=0.800000  loops per run = 644503
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.10258 ms (overrun 0)
within 1ms = 38427, factor = 99.9662%
within 2ms = 38440, factor = 100%
deviation = 0.0456989

diskread.log:
cpu_hz = 2.08832e+09
cpu_load=0.800000  loops per run = 645152
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.44847 ms (overrun 0)
within 1ms = 34704, factor = 99.928%
within 2ms = 34729, factor = 100%
deviation = 0.0357967

---------- 2.6.5-aa5 AS scheduler ----------
x11.log:
cpu_hz = 2.08797e+09
cpu_load=0.800000  loops per run = 645080
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.05035 ms (overrun 0)
within 1ms = 39333, factor = 99.9797%
within 2ms = 39341, factor = 100%
deviation = 0.0215519

proc.log:
cpu_hz = 2.08797e+09
cpu_load=0.800000  loops per run = 644734
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.04263 ms (overrun 0)
within 1ms = 15399, factor = 99.9675%
within 2ms = 15404, factor = 100%
deviation = 0.0220961

diskwrite.log:
cpu_hz = 2.08797e+09
cpu_load=0.800000  loops per run = 645054
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.08033 ms (overrun 0)
within 1ms = 14817, factor = 99.9393%
within 2ms = 14826, factor = 100%
deviation = 0.0457863

diskcopy.log:
cpu_hz = 2.08797e+09
cpu_load=0.800000  loops per run = 645086
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.1242 ms (overrun 0)
within 1ms = 38657, factor = 99.9586%
within 2ms = 38673, factor = 100%
deviation = 0.0395391

diskread.log:
cpu_hz = 2.08797e+09
cpu_load=0.800000  loops per run = 645088
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.42394 ms (overrun 0)
within 1ms = 35125, factor = 99.926%
within 2ms = 35151, factor = 100%
deviation = 0.0341163

---------- 2.6.5 AS scheduler ----------
x11.log:
cpu_hz = 2.08801e+09
cpu_load=0.800000  loops per run = 645059
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.0537 ms (overrun 0)
within 1ms = 39353, factor = 99.9771%
within 2ms = 39362, factor = 100%
deviation = 0.0218243

proc.log:
cpu_hz = 2.08801e+09
cpu_load=0.800000  loops per run = 645044
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.03839 ms (overrun 0)
within 1ms = 15404, factor = 99.9416%
within 2ms = 15413, factor = 100%
deviation = 0.0226547

diskwrite.log:
cpu_hz = 2.08801e+09
cpu_load=0.800000  loops per run = 644705
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 4.51782 ms (overrun 4)
within 1ms = 13287, factor = 99.9248%
within 2ms = 13293, factor = 99.9699%
deviation = 0.0516117

diskcopy.log:
cpu_hz = 2.08801e+09
cpu_load=0.800000  loops per run = 645081
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 4.09889 ms (overrun 1)
within 1ms = 37387, factor = 99.9358%
within 2ms = 37410, factor = 99.9973%
deviation = 0.043017

diskread.log:
cpu_hz = 2.08801e+09
cpu_load=0.800000  loops per run = 645099
total latency = 1.953125 ms
cpu latency = 1.562500 ms
max diff = 3.36909 ms (overrun 0)
within 1ms = 35446, factor = 99.9295%
within 2ms = 35471, factor = 100%
deviation = 0.033815
-----------------------------------------

The vanilla 2.6.5 has overruns here, bad against the others here.


Happy Easter all,

Marcus
