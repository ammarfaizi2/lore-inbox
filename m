Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSAXRWg>; Thu, 24 Jan 2002 12:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSAXRW0>; Thu, 24 Jan 2002 12:22:26 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:60939 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S287831AbSAXRWQ>; Thu, 24 Jan 2002 12:22:16 -0500
Date: Thu, 24 Jan 2002 18:22:15 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <20020124155853Z287177-13996+11274@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dieter

> Hello Rasmus,
> 
> I hope that I've extracted your name right?

Yup, just a danish letter in my middle-name :-)

> > However, after disabling APM and enabling ACPI, my system won't power 
> > off anymore :-(
> 
> This should be easily solved.
> 
> I point on your distro's startup scripts. They only look if apm is enabled 
> but _NOT ACPI...

Well, RedHat 7.2 does not look if apm or acpi is configured, it just 
uses -p unless the command run was 'halt' or 'reboot'.

When running '/sbin/poweroff' from single-user, 'halt -i -d p' is the 
last command run by the halt script. The I get the message 'Power down.' 
from the kernel and my system just hangs here.

When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is 
again the last command run, follwing this from the kernel:

Power down.
 hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5

And again my system hangs. Pressing the power button for 4 seconds turns 
off the computer (the BIOS is set to 'immediate power off'). 
Ctrl-Alt-Delete or any other keyboard combinations do not work.

Reboot works fine. APM poweroff also works flawlessly (but then I do not 
get the powersaving functions).

In runlevel 3, the following modules are loaded (some are patched in 
from the iptables package. They should not cause this, as I can 
reproduce this without iptables configured/patched at all):

Module                  Size  Used by    Tainted: P
binfmt_misc             5636   1
parport_pc             21416   1  (autoclean)
lp                      6016   0  (autoclean)
parport                23680   1  (autoclean) [parport_pc lp]
autofs4                 8228   2  (autoclean)
smbfs                  31104   1  (autoclean)
eepro100               17136   1
af_packet              11912   0  (autoclean)
ipt_REJECT              2784   1  (autoclean)
ipt_record_rpc          1504   4  (autoclean)
ip_conntrack_rpc_tcp    2880   1  (autoclean) [ipt_record_rpc]
ip_conntrack_rpc_udp    2720   1  (autoclean) [ipt_record_rpc]
ipt_unclean             6816   4  (autoclean)
ipt_state                576  21  (autoclean)
ipt_LOG                 3360  13  (autoclean)
ipt_limit                928  12  (autoclean)
iptable_mangle          1696   0  (autoclean) (unused)
iptable_nat            13844   1  (autoclean)
iptable_filter          1664   1  (autoclean)
ip_tables              10688  11  [ipt_REJECT ipt_record_rpc ipt_unclean 
ipt_state ipt_LOG ipt_limit iptable_mangle iptable_nat iptable_filter]
ip_conntrack_h323       2208   0  (unused)
ip_conntrack_irc        2624   0  (unused)
ip_conntrack_ftp        3424   0  (unused)
ip_conntrack           14444   8  [ipt_record_rpc ip_conntrack_rpc_tcp 
ip_conntrack_rpc_udp ipt_state iptable_nat ip_conntrack_h323 
ip_conntrack_irc ip_conntrack_ftp]
ntfs                   47936   1  (autoclean)
nls_iso8859-15          3328   2  (autoclean)
nls_cp865               4320   2  (autoclean)
vfat                    9564   1  (autoclean)
fat                    29944   0  (autoclean) [vfat]
rtc                     5656   0  (autoclean)

>From my 'make menuconfig:

[*] Power Management support
[*]   ACPI support
[*]     ACPI Debug Statements
<*>     ACPI Bus Manager
<*>       System
<*>       Processor
< >       Button
< >       AC Adapter
< >       Embedded Controller
< >   Advanced Power Management BIOS support

At bootup I get the following regarding ACPI:

 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully 
loaded
Parsing 
Methods:...................................................................................................................
115 Control Methods found and parsed (364 nodes total)
ACPI Namespace successfully loaded at root c0286ee0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode 
successful
Executing device _INI methods:.......................................
39 Devices found: 39 _STA, 0 _INI
Completing Region and Field initialization:...................
17/24 Regions, 2/2 Fields initialized (364 nodes total)
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states

My motherboard is an Asus A7V133-C. Output from lspci -v:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d7cfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	Capabilities: <available only to root>

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: <available only to root>

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=32]
	Capabilities: <available only to root>

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Flags: medium devsel, IRQ 9
	Capabilities: <available only to root>

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
	Subsystem: Unknown device 4942:4c4c
	Flags: bus master, slow devsel, latency 32, IRQ 5
	I/O ports at a400 [size=64]

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at a000 [size=64]
	Memory at d5000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: <available only to root>

00:0c.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
	Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 9800 [size=256]
	Memory at d4800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX DDR) (rev b2) (prog-if 00 [VGA])
	Subsystem: Micro-star International Co Ltd: Unknown device 8261
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: <available only to root>

I have tried different ACPI configurations, but I haven't been able to 
make any of them work.

I have very little knowledge of ACPI, but I'll be happy to help (if this 
is not my fault of course - then I will apologize for taking your time 
:-)).

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
God, root, what is difference?
God is more forgiving.
----------------------------------[ moffe at amagerkollegiet dot dk ] --




