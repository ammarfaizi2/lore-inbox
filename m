Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbULAW0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbULAW0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbULAW0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:26:51 -0500
Received: from ns.onesite.org ([69.50.195.197]:50878 "EHLO floc.net")
	by vger.kernel.org with ESMTP id S261472AbULAWZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:25:25 -0500
Date: Wed, 1 Dec 2004 23:25:22 +0100
From: Alain Tesio <alain@onesite.org>
To: linux-kernel@vger.kernel.org
Subject: HIGHMEM=4G slows down ps2pdf with 2.4.28
Message-ID: <20041201232522.6e39c954@alain>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With a 2.4.28 kernel, 1.5 Go RAM and nothing exotic, everything works fine
with CONFIG_HIGHMEM4G and CONFIG_HIGHMEM=y except that
ps2pdf is about 30 times slower 

ps2pdf is a script using ghostscript with device=pdfwriter, I don't know if he's
doing something special with memory allocations.

If you want to test it, use this file:
http://www.floc.net/observer/USDP/hoyteclassical/hoyteclassical.ps
(gs-gpl 8.01 on debian sid)

Other usual server daemons seems unaffected.

If this is a known behaviour for HIGHMEM to slow down random apps, it will
be nice to put a warning in the make config help !


Alain




#lspci | grep bridge
cat /proc0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)

#cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1579692032 1522913280 56778752        0 194080768 798294016
Swap: 2147467264 19042304 2128424960
MemTotal:      1542668 kB
MemFree:         55448 kB
MemShared:           0 kB
Buffers:        189532 kB
Cached:         766428 kB
SwapCached:      13156 kB
Active:         461848 kB
Inactive:       800564 kB
HighTotal:      646336 kB
HighFree:         2044 kB
LowTotal:       896332 kB
LowFree:         53404 kB
SwapTotal:     2097136 kB
SwapFree:      2078540 kB

#cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.40GHz
stepping        : 9
cpu MHz         : 3400.211
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6789.52

# sh /usr/src/linux-2.4.25/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux onesite 2.4.28 #2 Tue Nov 30 16:28:30 MST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.27
quota-tools            3.04.
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         af_packet

$time ps2pdf test.ps test.pdf

real    1m5.554s
user    0m17.470s
sys     0m0.040s

# now without highmem=4GO (lower load however)
$time ps2pdf test.ps test.pdf

real    0m0.667s
user    0m0.670s
sys     0m0.000s
