Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUAJCnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUAJCnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 21:43:04 -0500
Received: from [218.93.20.101] ([218.93.20.101]:64692 "EHLO mail.shinco.com")
	by vger.kernel.org with ESMTP id S264329AbUAJCm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 21:42:57 -0500
Date: Sat, 10 Jan 2004 10:42:53 +0800
From: Peng Yong <ppyy@bentium.com>
To: linux-kernel@vger.kernel.org
Subject: Re: system resource limit in kernel 2.6
In-Reply-To: <20040109182450.462bc537.akpm@osdl.org>
References: <20040110095333.0765.PPYY@bentium.com> <20040109182450.462bc537.akpm@osdl.org>
Message-Id: <20040110104249.076E.PPYY@bentium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peng Yong <ppyy@bentium.com> wrote:
> >
> > 
> > We upgrade one of our production http server, runing apache 1.3.29, to
> > kernel 2.6. some time the main process of apache exit and here is the
> > error log:
> > 
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> > 
> > 
> > how can i tuning the kernel and remove the system resource limit?
> > 
> 
> Well the question is: why did behaviour change relative to 2.4?  The kernel
> is saying that uid 65534 has exceeded its RLIMIT_NPROC threshold.
> 
> How may processes is user 65534 actually running, and how much memory does
> the machine have?

httpd.conf:

MinSpareServers 16
MaxSpareServers 32
StartServers 16
MaxClients 512

the server is a Dell 1750 with 2GB RAM and 2 CPU.


uname:
Linux www.xxxx.org 2.6.1 #1 SMP Sat Jan 10 00:46:18 CST 2004 i686
unknown

# cat /proc/sys/kernel/threads-max 
32767

# cat /proc/meminfo 
MemTotal:      2072760 kB
MemFree:       1134272 kB
Buffers:         41928 kB
Cached:         573540 kB
SwapCached:          0 kB
Active:         498772 kB
Inactive:       268924 kB
HighTotal:     1179584 kB
HighFree:       450432 kB
LowTotal:       893176 kB
LowFree:        683840 kB
SwapTotal:     4000136 kB
SwapFree:      4000136 kB
Dirty:              44 kB
Writeback:           0 kB
Mapped:         246344 kB
Slab:           156568 kB
Committed_AS:  1390140 kB
PageTables:       2848 kB
VmallocTotal:   114680 kB
VmallocUsed:      2604 kB
VmallocChunk:   112040 kB

www:/home/apache/logs# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2787.225
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5488.64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2787.225
cache size      : 512 KB
physical id     : 6
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5554.17


