Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRCZTcn>; Mon, 26 Mar 2001 14:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRCZTce>; Mon, 26 Mar 2001 14:32:34 -0500
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:52999 "HELO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with SMTP
	id <S132563AbRCZTc1>; Mon, 26 Mar 2001 14:32:27 -0500
From: gabor@swszl.szkp.uni-miskolc.hu
Date: Mon, 26 Mar 2001 21:31:34 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.2,mount --bind, system hangs
Message-ID: <20010326213134.A8875@swszl.szkp.uni-miskolc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
linux 2.4.2 can be killed with multiple 'mount --bind ' -s.
The problem is reproduceable (at least on my system),
and works with User Mode Linux, too. Example script follows:
----
#!/bin/sh
OUTER=100
INNER=30
for j in `seq $OUTER`
do
    for i in `seq $INNER`
    do
       echo "$j:$i"
       touch $i $i.m
       mount --bind $i $i.m
    done
done
----
The system usually hangs in the third iteration of the 
outer loop. No error messages, vt switching still works, network 
connections hang.
(Yes, the script looks cruel, however I ran into this problem
with a (broken) real-life setup that closely resembles this script with 
parameters OUTER=2 or 3 and INNER=19 )
The system is otherwise stable, no overclocking, etc...

System information: debian 2.2, with upgraded modutils, mount,
ppp, iptables; HW: AMD Athlon 550, MB: Asus K7V-RM, 128M RAM

Detailed stuff:

Kernel version:
Linux version 2.4.2 (root@tonhal) (gcc version 2.95.2 20000220 \
(Debian GNU/Linux)) #5 Mon Feb 26 22:13:40 CET 2001
----
output of scripts/ver_linux:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux tonhal 2.4.2 #5 Mon Feb 26 22:13:40 CET 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.11a
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ipt_state ipt_MASQUERADE iptable_filter \
ip_conntrack_ftp iptable_nat ip_conntrack ip_tables ppp_deflate \
bsd_comp ppp_async ppp_generic slhc via-rhine serial via82cxxx_audio \
ac97_codec soundcore w83781d sensors i2c-viapro i2c-core
----
Third party modules: lm_sensors-2.5.4, i2c-2.5.4 
----
Basic cpu and pci information:
----
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 1
model name	: AMD-K7(tm) Processor
stepping	: 2
cpu MHz		: 550.029
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips	: 1097.72
-----
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
00:09.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3065 (rev 42)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
-----
I can give more information on request.


	Regards:
		Gabor
P.S.: gotta get better English :-)
