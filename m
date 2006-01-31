Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWAaRoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWAaRoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWAaRoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:44:10 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:6077 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751300AbWAaRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:44:08 -0500
Date: Tue, 31 Jan 2006 18:44:32 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
 2.6.16-rc1-mm1
Message-ID: <20060131184432.27d02d60@localhost>
In-Reply-To: <43DC01D1.9040902@bigpond.net.au>
References: <43D00887.6010409@bigpond.net.au>
	<20060121114616.4a906b4f@localhost>
	<43D2BE83.1020200@bigpond.net.au>
	<43D40B96.3060705@bigpond.net.au>
	<43D4281D.10009@bigpond.net.au>
	<20060123212158.3fba71d5@localhost>
	<43D82161.6000809@bigpond.net.au>
	<20060126091129.53de58fa@localhost>
	<43D94E62.6080603@bigpond.net.au>
	<43DC01D1.9040902@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006 10:44:17 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> Peter Williams wrote:
> > 
> > It's because the "fairness" bonus is still being done as a one shot 
> > bonus when a task's delay time become unfairly large.  I mentioned this 
> > before as possibly needing to be changed to a more persistent model but 
> > after I discovered the accounting bug I deferred doing anything about it 
> > in the hope that fixing the bug would have been sufficient.
> > 
> > I'll now try a model whereby a task's fairness bonus is increased 
> > whenever it has unfair delays and decreased when it doesn't.  Hopefully, 
> > with the right rates of increase/decrease, this can result in a system 
> > where a task has a fairly persistent bonus which is sufficient to give 
> > it its fair share.  One reason that I've been avoiding this method is 
> > that it introduces double smoothing: once in the calculation of the 
> > average delay time and then again in the determination of the bonus; and 
> > I'm concerned this may make it slow to react to change.  Any way I'll 
> > give it a try and see what happens.
> 
> Attached is a patch which makes the fairness bonuses more persistent.  I 
> should be applied on top of the last patch that I sent.  Could you test 
> it please?
> 

Sched Fooler
DD time: 16.1s --> 19.7s

Transcode:
DD time depends on the caching of the file DD is reading from (18.8s,
17.4s, ...)

DATA:

top - 18:12:04 up 9 min,  4 users,  load average: 2.94, 1.72, 0.73
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 46.2% us,  1.6% sy,  0.0% ni, 47.3% id,  4.8% wa,  0.0% hi,  0.1% si
Mem:    511168k total,   222908k used,   288260k free,     1608k buffers
Swap:  1004020k total,        0k used,  1004020k free,    61308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 S 39.0  0.1   1:25.62 a.out
 5513 paolo     34   0  2392  288  228 R 32.2  0.1   1:25.12 a.out
 5514 paolo     34   0  2396  292  228 R 22.0  0.1   1:22.65 a.out
 5595 paolo     31   0  4952 1468  372 D  5.1  0.3   0:00.03 dd


top - 18:12:05 up 9 min,  4 users,  load average: 2.95, 1.74, 0.74
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 98.1% us,  1.9% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   251108k used,   260060k free,     1636k buffers
Swap:  1004020k total,        0k used,  1004020k free,    89472k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5514 paolo     34   0  2396  292  228 R 37.9  0.1   1:23.06 a.out
 5512 paolo     34   0  2392  288  228 S 31.5  0.1   1:25.96 a.out
 5513 paolo     34   0  2392  288  228 R 27.8  0.1   1:25.42 a.out
 5595 paolo     32   0  4952 1468  372 D  1.9  0.3   0:00.05 dd


top - 18:12:06 up 9 min,  4 users,  load average: 2.95, 1.74, 0.74
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 95.4% us,  3.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.9% si
Mem:    511168k total,   280028k used,   231140k free,     1664k buffers
Swap:  1004020k total,        0k used,  1004020k free,   118400k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 R 35.5  0.1   1:26.34 a.out
 5513 paolo     34   0  2392  288  228 S 34.6  0.1   1:25.79 a.out
 5514 paolo     34   0  2396  292  228 R 26.2  0.1   1:23.34 a.out
 5595 paolo     31   0  4952 1468  372 D  3.7  0.3   0:00.09 dd


top - 18:12:08 up 9 min,  4 users,  load average: 2.95, 1.74, 0.74
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 96.3% us,  3.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   308052k used,   203116k free,     1692k buffers
Swap:  1004020k total,        0k used,  1004020k free,   146304k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5514 paolo     34   0  2396  292  228 S 37.0  0.1   1:23.74 a.out
 5512 paolo     34   0  2392  288  228 R 33.3  0.1   1:26.70 a.out
 5513 paolo     34   0  2392  288  228 R 26.9  0.1   1:26.08 a.out
 5595 paolo     33   0  4952 1468  372 D  3.7  0.3   0:00.13 dd


top - 18:12:09 up 9 min,  4 users,  load average: 2.95, 1.74, 0.74
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 96.1% us,  2.9% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   336972k used,   174196k free,     1720k buffers
Swap:  1004020k total,        0k used,  1004020k free,   175232k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     34   0  2392  288  228 R 36.0  0.1   1:26.45 a.out
 5512 paolo     34   0  2392  288  228 R 30.2  0.1   1:27.01 a.out
 5514 paolo     33   0  2396  292  228 S 29.2  0.1   1:24.04 a.out
 5595 paolo     33   0  4952 1468  372 R  2.9  0.3   0:00.16 dd


top - 18:12:10 up 9 min,  4 users,  load average: 2.95, 1.74, 0.74
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 95.0% us,  4.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   360460k used,   150708k free,     1760k buffers
Swap:  1004020k total,        0k used,  1004020k free,   198788k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 R 39.1  0.1   1:27.40 a.out
 5513 paolo     34   0  2392  288  228 S 32.0  0.1   1:26.77 a.out
 5514 paolo     34   0  2396  292  228 R 26.0  0.1   1:24.30 a.out
 5595 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.20 dd


top - 18:12:11 up 9 min,  4 users,  load average: 3.03, 1.78, 0.76
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 94.0% us,  6.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   388000k used,   123168k free,     1784k buffers
Swap:  1004020k total,        0k used,  1004020k free,   226308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5514 paolo     34   0  2396  292  228 R 34.0  0.1   1:24.64 a.out
 5512 paolo     34   0  2392  288  228 R 31.0  0.1   1:27.71 a.out
 5513 paolo     34   0  2392  288  228 R 29.0  0.1   1:27.06 a.out
 5595 paolo     31   0  4952 1468  372 D  6.0  0.3   0:00.26 dd


top - 18:12:12 up 9 min,  4 users,  load average: 3.03, 1.78, 0.76
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 96.1% us,  3.9% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   414640k used,    96528k free,     1812k buffers
Swap:  1004020k total,        0k used,  1004020k free,   252932k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     33   0  2392  288  228 S 34.3  0.1   1:27.41 a.out
 5514 paolo     34   0  2396  292  228 R 32.3  0.1   1:24.97 a.out
 5512 paolo     34   0  2392  288  228 R 30.4  0.1   1:28.02 a.out
 5595 paolo     34   0  4952 1468  372 R  3.9  0.3   0:00.30 dd


top - 18:12:13 up 9 min,  4 users,  load average: 3.03, 1.78, 0.76
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 98.0% us,  2.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   442244k used,    68924k free,     1836k buffers
Swap:  1004020k total,        0k used,  1004020k free,   280452k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 R 38.0  0.1   1:28.40 a.out
 5514 paolo     33   0  2396  292  228 S 31.0  0.1   1:25.28 a.out
 5513 paolo     34   0  2392  288  228 R 29.0  0.1   1:27.70 a.out
 5595 paolo     31   0  4952 1468  372 D  2.0  0.3   0:00.32 dd


top - 18:12:14 up 9 min,  4 users,  load average: 3.03, 1.78, 0.76
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 97.0% us,  2.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   468104k used,    43064k free,     1864k buffers
Swap:  1004020k total,        0k used,  1004020k free,   306308k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     34   0  2392  288  228 R 36.0  0.1   1:28.06 a.out
 5512 paolo     33   0  2392  288  228 R 33.0  0.1   1:28.73 a.out
 5514 paolo     34   0  2396  292  228 R 27.0  0.1   1:25.55 a.out
 5595 paolo     31   0  4952 1468  372 D  2.0  0.3   0:00.34 dd


top - 18:12:15 up 9 min,  4 users,  load average: 3.19, 1.83, 0.78
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 97.0% us,  3.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   494388k used,    16780k free,     1904k buffers
Swap:  1004020k total,        0k used,  1004020k free,   332424k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 S 36.0  0.1   1:29.09 a.out
 5514 paolo     34   0  2396  292  228 R 33.0  0.1   1:25.88 a.out
 5513 paolo     34   0  2392  288  228 R 29.0  0.1   1:28.35 a.out
 5595 paolo     33   0  4952 1468  372 D  4.0  0.3   0:00.38 dd


top - 18:12:16 up 9 min,  4 users,  load average: 3.19, 1.83, 0.78
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 98.0% us,  2.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   504828k used,     6340k free,     1096k buffers
Swap:  1004020k total,      200k used,  1003820k free,   343332k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     33   0  2392  288  228 R 35.0  0.1   1:28.70 a.out
 5512 paolo     34   0  2392  288  228 R 35.0  0.1   1:29.44 a.out
 5514 paolo     34   0  2396  292  228 R 28.0  0.1   1:26.16 a.out
 5595 paolo     31   0  4952 1468  372 D  2.0  0.3   0:00.40 dd


top - 18:12:17 up 9 min,  4 users,  load average: 3.19, 1.83, 0.78
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 96.0% us,  4.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   504692k used,     6476k free,     1108k buffers
Swap:  1004020k total,      200k used,  1003820k free,   343348k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     33   0  2392  288  228 S 34.0  0.1   1:29.04 a.out
 5512 paolo     34   0  2392  288  228 R 31.0  0.1   1:29.75 a.out
 5514 paolo     34   0  2396  292  228 R 30.0  0.1   1:26.46 a.out
 5595 paolo     32   0  4952 1468  372 D  4.0  0.3   0:00.44 dd


top - 18:12:18 up 9 min,  4 users,  load average: 3.19, 1.83, 0.78
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 98.0% us,  2.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   504692k used,     6476k free,     1116k buffers
Swap:  1004020k total,      200k used,  1003820k free,   343368k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5514 paolo     33   0  2396  292  228 R 38.0  0.1   1:26.84 a.out
 5512 paolo     34   0  2392  288  228 R 37.0  0.1   1:30.12 a.out
 5513 paolo     33   0  2392  288  228 R 24.0  0.1   1:29.28 a.out
 5595 paolo     31   0  4952 1468  372 D  1.0  0.3   0:00.45 dd


top - 18:12:19 up 9 min,  4 users,  load average: 3.19, 1.83, 0.78
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 96.0% us,  4.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505428k used,     5740k free,     1128k buffers
Swap:  1004020k total,      200k used,  1003820k free,   344152k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     34   0  2392  288  228 R 36.0  0.1   1:29.64 a.out
 5514 paolo     34   0  2396  292  228 R 32.0  0.1   1:27.16 a.out
 5512 paolo     33   0  2392  288  228 R 26.0  0.1   1:30.38 a.out
 5595 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.49 dd


top - 18:12:20 up 9 min,  4 users,  load average: 3.25, 1.86, 0.80
Tasks:   4 total,   4 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s): 97.0% us,  3.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505428k used,     5740k free,     1136k buffers
Swap:  1004020k total,      200k used,  1003820k free,   344180k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 R 40.0  0.1   1:30.78 a.out
 5513 paolo     34   0  2392  288  228 R 38.0  0.1   1:30.02 a.out
 5514 paolo     33   0  2396  292  228 R 21.0  0.1   1:27.37 a.out
 5595 paolo     33   0  4952 1468  372 R  3.0  0.3   0:00.52 dd


top - 18:12:21 up 9 min,  4 users,  load average: 3.25, 1.86, 0.80
Tasks:   4 total,   2 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 94.0% us,  5.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505484k used,     5684k free,     1152k buffers
Swap:  1004020k total,      200k used,  1003820k free,   344196k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5514 paolo     34   0  2396  292  228 R 45.0  0.1   1:27.82 a.out
 5512 paolo     34   0  2392  288  228 R 27.0  0.1   1:31.05 a.out
 5513 paolo     34   0  2392  288  228 S 22.0  0.1   1:30.24 a.out
 5595 paolo     31   0  4952 1468  372 D  5.0  0.3   0:00.57 dd


top - 18:12:22 up 9 min,  4 users,  load average: 3.25, 1.86, 0.80
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 94.0% us,  6.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505500k used,     5668k free,     1148k buffers
Swap:  1004020k total,      200k used,  1003820k free,   344228k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5512 paolo     34   0  2392  288  228 R 38.0  0.1   1:31.43 a.out
 5513 paolo     34   0  2392  288  228 R 32.0  0.1   1:30.56 a.out
 5514 paolo     33   0  2396  292  228 R 25.0  0.1   1:28.07 a.out
 5595 paolo     31   0  4952 1468  372 D  5.0  0.3   0:00.62 dd


top - 18:12:23 up 9 min,  4 users,  load average: 3.25, 1.86, 0.80
Tasks:   4 total,   3 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 93.9% us,  6.1% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   504948k used,     6220k free,     1156k buffers
Swap:  1004020k total,      200k used,  1003820k free,   343736k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5513 paolo     34   0  2392  288  228 R 34.0  0.1   1:30.90 a.out
 5512 paolo     34   0  2392  288  228 R 30.0  0.1   1:31.73 a.out
 5514 paolo     34   0  2396  292  228 R 28.0  0.1   1:28.35 a.out
 5595 paolo     31   0  4952 1468  372 D  6.0  0.3   0:00.68 dd


------------------------------------------------------------


top - 18:18:59 up 16 min,  4 users,  load average: 0.85, 1.06, 0.81
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 47.4% us,  1.5% sy,  0.0% ni, 46.8% id,  4.1% wa,  0.0% hi,  0.1% si
Mem:    511168k total,   378912k used,   132256k free,     1596k buffers
Swap:  1004020k total,      200k used,  1003820k free,   151740k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     32   0  116m  18m 2432 D 72.2  3.7   0:07.15 transcode
 5723 paolo     31   0  4952 1468  372 D  2.1  0.3   0:00.09 dd


top - 18:19:00 up 16 min,  4 users,  load average: 1.02, 1.09, 0.82
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 72.5% us,  5.9% sy,  0.0% ni,  0.0% id, 20.6% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   407952k used,   103216k free,     1632k buffers
Swap:  1004020k total,      200k used,  1003820k free,   180760k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     34   0  116m  18m 2432 D 64.4  3.7   0:07.81 transcode
 5723 paolo     31   0  4952 1468  372 D  4.9  0.3   0:00.14 dd


top - 18:19:01 up 16 min,  4 users,  load average: 1.02, 1.09, 0.82
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 59.4% us,  5.0% sy,  0.0% ni,  0.0% id, 33.7% wa,  0.0% hi,  2.0% si
Mem:    511168k total,   435152k used,    76016k free,     1664k buffers
Swap:  1004020k total,      200k used,  1003820k free,   208128k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     32   0  116m  18m 2432 D 55.3  3.7   0:08.37 transcode
 5723 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.18 dd


top - 18:19:02 up 16 min,  4 users,  load average: 1.02, 1.09, 0.82
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 58.0% us,  6.0% sy,  0.0% ni,  0.0% id, 35.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   461796k used,    49372k free,     1700k buffers
Swap:  1004020k total,      200k used,  1003820k free,   234656k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 D 45.0  3.7   0:08.82 transcode
 5723 paolo     31   0  4952 1468  372 D  3.0  0.3   0:00.21 dd


top - 18:19:03 up 16 min,  4 users,  load average: 1.02, 1.09, 0.82
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 56.4% us,  3.0% sy,  0.0% ni,  0.0% id, 40.6% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   482260k used,    28908k free,     1720k buffers
Swap:  1004020k total,      200k used,  1003820k free,   255160k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     31   0  116m  18m 2432 D 52.0  3.7   0:09.34 transcode
 5723 paolo     31   0  4952 1468  372 D  1.0  0.3   0:00.22 dd


top - 18:19:04 up 16 min,  4 users,  load average: 1.02, 1.09, 0.82
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 58.0% us,  7.0% sy,  0.0% ni,  0.0% id, 34.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   504828k used,     6340k free,     1680k buffers
Swap:  1004020k total,      200k used,  1003820k free,   277732k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     32   0  116m  18m 2432 D 54.0  3.7   0:09.88 transcode
 5723 paolo     31   0  4952 1468  372 D  7.0  0.3   0:00.29 dd


top - 18:19:05 up 16 min,  4 users,  load average: 1.10, 1.10, 0.83
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 69.7% us,  5.1% sy,  0.0% ni,  0.0% id, 25.3% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505216k used,     5952k free,     1108k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278812k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 D 66.0  3.7   0:10.54 transcode
 5723 paolo     31   0  4952 1468  372 D  3.0  0.3   0:00.32 dd


top - 18:19:06 up 16 min,  4 users,  load average: 1.10, 1.10, 0.83
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 62.0% us,  9.0% sy,  0.0% ni,  0.0% id, 28.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505276k used,     5892k free,     1068k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278936k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     34   0  116m  18m 2432 R 58.0  3.7   0:11.12 transcode
 5723 paolo     31   0  4952 1468  372 D  9.0  0.3   0:00.41 dd


top - 18:19:07 up 16 min,  4 users,  load average: 1.10, 1.10, 0.83
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 58.4% us,  5.9% sy,  0.0% ni,  0.0% id, 34.7% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505680k used,     5488k free,     1068k buffers
Swap:  1004020k total,      200k used,  1003820k free,   279300k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 D 53.0  3.7   0:11.65 transcode
 5723 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.45 dd


top - 18:19:08 up 16 min,  4 users,  load average: 1.10, 1.10, 0.83
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 48.0% us,  6.0% sy,  0.0% ni,  0.0% id, 45.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505276k used,     5892k free,     1092k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278920k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     31   0  116m  18m 2432 D 44.8  3.7   0:12.10 transcode
 5723 paolo     31   0  4952 1468  372 D  3.0  0.3   0:00.48 dd


top - 18:19:09 up 16 min,  4 users,  load average: 1.10, 1.10, 0.83
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 55.2% us,  3.8% sy,  0.0% ni,  0.0% id, 40.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505156k used,     6012k free,     1092k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278888k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     31   0  116m  18m 2432 D 50.3  3.7   0:12.63 transcode
 5723 paolo     31   0  4952 1468  372 D  3.8  0.3   0:00.52 dd


top - 18:19:10 up 16 min,  4 users,  load average: 1.25, 1.14, 0.84
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
Cpu(s): 66.0% us,  8.0% sy,  0.0% ni,  0.0% id, 25.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   504992k used,     6176k free,     1100k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278644k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 D 60.1  3.7   0:13.23 transcode
 5723 paolo     32   0  4952 1468  372 D  4.0  0.3   0:00.56 dd


top - 18:19:11 up 16 min,  4 users,  load average: 1.25, 1.14, 0.84
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 50.0% us,  6.0% sy,  0.0% ni,  0.0% id, 43.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505404k used,     5764k free,     1112k buffers
Swap:  1004020k total,      200k used,  1003820k free,   279148k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     32   0  116m  18m 2432 R 49.0  3.7   0:13.72 transcode
 5723 paolo     31   0  4952 1468  372 D  5.0  0.3   0:00.61 dd


top - 18:19:12 up 16 min,  4 users,  load average: 1.25, 1.14, 0.84
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 81.0% us,  7.0% sy,  0.0% ni,  0.0% id, 11.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   505056k used,     6112k free,     1116k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 R 74.0  3.7   0:14.46 transcode
 5723 paolo     31   0  4952 1468  372 D  3.0  0.3   0:00.64 dd


top - 18:19:13 up 16 min,  4 users,  load average: 1.25, 1.14, 0.84
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 95.0% us,  5.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505580k used,     5588k free,     1072k buffers
Swap:  1004020k total,      200k used,  1003820k free,   279348k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     34   0  116m  18m 2432 R 89.0  3.7   0:15.35 transcode
 5723 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.68 dd


top - 18:19:14 up 16 min,  4 users,  load average: 1.25, 1.14, 0.84
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 93.0% us,  6.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  1.0% si
Mem:    511168k total,   504852k used,     6316k free,     1088k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     34   0  116m  18m 2432 R 88.0  3.7   0:16.23 transcode
 5723 paolo     32   0  4952 1468  372 D  4.0  0.3   0:00.72 dd


top - 18:19:15 up 16 min,  4 users,  load average: 1.39, 1.17, 0.85
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s): 91.0% us,  8.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  1.0% hi,  0.0% si
Mem:    511168k total,   504860k used,     6308k free,     1116k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278604k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     33   0  116m  18m 2432 R 83.0  3.7   0:17.06 transcode
 5723 paolo     33   0  4952 1468  372 R  5.0  0.3   0:00.77 dd


top - 18:19:16 up 16 min,  4 users,  load average: 1.39, 1.17, 0.85
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
Cpu(s): 94.0% us,  6.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    511168k total,   505100k used,     6068k free,     1144k buffers
Swap:  1004020k total,      200k used,  1003820k free,   278932k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5700 paolo     34   0  116m  18m 2432 R 86.0  3.7   0:17.92 transcode
 5723 paolo     31   0  4952 1468  372 D  4.0  0.3   0:00.81 dd


-- 
	Paolo Ornati
	Linux 2.6.16-rc1-plugsched on x86_64
