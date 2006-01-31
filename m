Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWAaCuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWAaCuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAaCuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:50:25 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:21961 "EHLO
	omta16.mta.everyone.net") by vger.kernel.org with ESMTP
	id S932392AbWAaCuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:50:24 -0500
X-Eon-Dm: dm16
X-Eon-Sig: AQHOS7ND3tBrbw3UPgIAAAAC,32d4fc803388fd62b63dc8cb63d72465
Date: Mon, 30 Jan 2006 21:49:28 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: Size-128 slab leak
Message-ID: <20060131024928.GA11395@double.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have an annoying slab leak on my kernel.  Every day, I lose about
50Megs of memory to the leak.  It seems to be related to disk
accesses, because the count only goes up noticeable around 4:00am when
the system locate utility runs.

I can tell there is a leak because /proc/slabinfo shows "size-128"
growing continuously.  For example, it currently reads:

size-128          4086041 4106550    128   30    1 : tunables  120   60    8 : slabdata 136885 136885      0

The machine is a vanilla lkml kernel:

Linux double 2.6.15 #1 SMP Wed Jan 4 23:13:51 EST 2006 x86_64 x86_64 x86_64 GNU/Linux

I've noticed this bug on a 2.6.14 kernel also.  This machine is using
libata (sata_uli) along with reiserfs, ext3, and lvm.  I'm interested
in finding ways of diagnosing this problem.  I can provide more
information on demand.  Please CC me on any replies.

Thanks,
-Kevin

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-20060130

00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and HyperTransport]
00:01.0 PCI bridge: ALi Corporation: Unknown device 524b
00:02.0 PCI bridge: ALi Corporation: Unknown device 524c
00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
00:05.0 PCI bridge: ALi Corporation AGP8X Controller
00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:08.0 Multimedia audio controller: ALi Corporation M5455 PCI AC-Link Controller Audio Device (rev 20)
00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00:12.1 IDE interface: ALi Corporation ULi 5289 SATA (rev 10)
00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
03:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01)
03:00.1 Display controller: ATI Technologies Inc: Unknown device 5940 (rev 01)

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo-20060130

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 43
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping	: 1
cpu MHz		: 1000.051
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 2002.42
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 43
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping	: 1
cpu MHz		: 1000.051
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 2002.42
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lsmod-20060130

Module                  Size  Used by
cramfs                 46144  1 
loop                   19472  2 
ppp_deflate             8192  0 
zlib_deflate           26016  1 ppp_deflate
ppp_async              15488  0 
crc_ccitt               3200  1 ppp_async
ppp_generic            36384  2 ppp_deflate,ppp_async
slhc                    8960  1 ppp_generic
vfat                   17152  0 
fat                    60976  1 vfat
usb_storage            86592  0 
snd_rtctimer            4888  0 
udf                    92064  1 
nls_utf8                3328  0 
ipaq                   40880  0 
usbserial              38612  1 ipaq
radeon                119584  1 
drm                   100776  2 radeon
ipv6                  311680  14 
parport_pc             33900  0 
lp                     16960  0 
parport                46604  2 parport_pc,lp
autofs4                25608  1 
w83627hf               35344  0 
hwmon_vid               3712  1 w83627hf
hwmon                   4616  1 w83627hf
eeprom                  9744  0 
i2c_isa                 7552  1 w83627hf
i2c_dev                14208  0 
i2c_core               27904  4 w83627hf,eeprom,i2c_isa,i2c_dev
sunrpc                184504  1 
pcmcia                 48816  0 
yenta_socket           31628  0 
rsrc_nonstatic         15872  1 yenta_socket
pcmcia_core            50228  3 pcmcia,yenta_socket,rsrc_nonstatic
reiserfs              285688  2 
video                  20488  0 
button                  8992  0 
battery                12168  0 
ac                      6792  0 
ohci_hcd               24708  0 
ehci_hcd               38920  0 
shpchp                 53888  0 
snd_intel8x0           39592  0 
snd_ac97_codec        117180  1 snd_intel8x0
snd_ac97_bus            3840  1 snd_ac97_codec
snd_seq_dummy           5380  0 
snd_seq_oss            41700  0 
snd_seq_midi_event     10368  1 snd_seq_oss
snd_seq                70616  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         12048  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            63264  0 
snd_mixer_oss          21632  1 snd_pcm_oss
snd_pcm               111624  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              30600  3 snd_rtctimer,snd_seq,snd_pcm
snd                    73696  9 snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              13088  1 snd
snd_page_alloc         13840  2 snd_intel8x0,snd_pcm
uli526x                21268  0 
dm_snapshot            18768  0 
dm_zero                 2816  0 
dm_mirror              25320  0 
ext3                  152848  2 
jbd                    68904  1 ext3
dm_mod                 69064  8 dm_snapshot,dm_zero,dm_mirror
sata_uli                8964  1 
libata                 67224  1 sata_uli
sd_mod                 21632  1 
scsi_mod              166712  3 usb_storage,libata,sd_mod

--huq684BweRXVnRxX
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="slabinfo-20060130.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
