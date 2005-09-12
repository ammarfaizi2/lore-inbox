Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVILJFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVILJFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVILJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:05:30 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:37516 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1751250AbVILJFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:05:30 -0400
Date: Mon, 12 Sep 2005 02:10:21 -0700
From: Jim McCloskey <mcclosk@ucsc.edu>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] mtrr's not set, 2.6.13
Message-ID: <20050912091021.GA2859@branci40>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Debian GNU/Linux/2.6.13 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure who to report this to ....

Somewhere between 2.6.11.3 and 2.6.12 (also under 2.6.13), the
following change occurred on this box.

Under 2.6.11.3, mtrr ranges are automatically set when X is started:

----------------------------------------------------------------------
running 2.6.11.3:

cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe8000000 (3712MB), size= 128MB: write-combining, count=2
reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1
----------------------------------------------------------------------

After installation of 2.6.12/13, mtrr ranges are not set:

----------------------------------------------------------------------
running 2.6.13:

Xorg.0.log:

(WW) RADEON(0): Failed to set up write-combining range (0xe8000000,0x8000000)

/var/log/messages:

Aug 30 17:37:13 localhost kernel: mtrr: type mismatch for e8000000,8000000 old: write-back new: write-combining
Aug 30 17:37:14 localhost kernel: mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
Aug 30 17:37:14 localhost kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
Aug 30 17:37:14 localhost kernel: mtrr: type mismatch for e8000000,8000000 old: write-back new: write-combining

cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1
----------------------------------------------------------------------

Under 2.6.13 it's fairly easy to force a crash of the X server (e.g. by
playing Tuxracer badly).

The only change here is in the kernel-version. I haven't tried all the
point releases between 2.6.11.3 and 2.6.12, but the relevant Changelogs
don't suggest that anything relevant changed.

I'll add what details I can below. Please let me know what other
information I can supply that might help resolve this.

Thanks,

Jim

----------------------------------------------------------------------
X server:

Source: xorg-x11
Version: 6.8.2.dfsg.1-2

from Debian's (testing) xserver-xorg package.

----------------------------------------
The graphics card:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200] (rev 01) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 2002
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 16
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at a000 [size=256]
        Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2
----------------------------------------
/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 3
cpu MHz		: 2800.074
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid
bogomips	: 5583.66
----------------------------------------
Output of ver_linux
 
Gnu C                  4.0.1
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   068
Modules Loaded         radeon drm md5 ipv6 snd_cs46xx snd_rawmidi snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 i2c_core hw_random ehci_hcd uhci_hcd usbcore b44 mii parport_pc lp parport intel_agp agpgart pktcdvd ide_cd cdrom loop rtc evdev

----------------------------------------
lspci -v under 2.6.11.3

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 101e
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [0106]

0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: ABIT Computer Corp.: Unknown device 101e
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Memory at fa000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 9000 [size=8]
	Capabilities: [d0] Power Management version 1

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f8000000-f9ffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0
----------------------------------------------------------------------
lspci -v under 2.6.12

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 101e
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [0106]
	Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: e8000000-f7ffffff

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: fa000000-fbffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 2002
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 16
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a000 [size=256]
	Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 3.0
	Capabilities: [50] Power Management version 2

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 2003
	Flags: 66MHz, medium devsel
	Memory at f0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at f9010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

----------------------------------------------------------------------
lspci -v under 2.6.13:

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 101e
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [0106]
	Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: e8000000-f7ffffff

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 20000000-200fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 2002
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a000 [size=256]
	Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
	Capabilities: [50] Power Management version 2

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 2003
	Flags: 66MHz, medium devsel
	Memory at f0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at f9010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

----------------------------------------------------------------------
