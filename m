Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDFGVO (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTDFGVO (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:21:14 -0500
Received: from 078-037.onebb.com ([202.69.78.37]:670 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id S262834AbTDFGVJ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 01:21:09 -0500
Message-ID: <3E8FC9FB.A030ACFB@vtc.edu.hk>
Date: Sun, 06 Apr 2003 14:32:27 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-8custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Debugging hard lockups (hardware?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear team,

This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
not respond.  The NMI watchdog does not kick in.  Alt-SysRq-keys do not
respond.  Logs show no hint of any problem (that I recognise) before lockup.
Occurs often during scrolling e.g., Mozilla.  I swapped the Radeon 7000 for a
7500, then an Nvidia.

I guess hardware.  But memtest run exhaustively shows no problem.

Same is true for large numbers of kernels I've tried, mostly Red Hat and -ac
kernels, old and new.

current grub kernel line:
kernel /boot/vmlinuz-2.4.20-8custom ro root=LABEL=/ vga=6 console=ttyS0,38400
nmi_watchdog=1 hdm=ide-scsi

I have six 80 G IDE disks, software RAID, LVM on top.  On Red Hat 8.0 and 9.

Any hints on how to troubleshoot this (besides replacing motherboard and other
components I cannot afford to replace?)

$ cat /proc/mdstat
Personalities : [raid1] [raid5]
read_ahead 1024 sectors
md0 : active raid1 hdc1[1] hda1[0]
      10240128 blocks [2/2] [UU]

md2 : active raid5 hdk1[3] hdi1[2] hdg1[1] hde1[0]
      20480256 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]

md1 : active raid5 hdk2[5] hdi2[4] hdg2[2] hde2[3] hdc2[1] hda2[0]
      4088064 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]

md3 : active raid5 hdk3[6] hdi3[4] hdg3[3] hde3[2] hdc3[1] hda3[0]
      267514112 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]

unused devices: <none>
$ lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev
11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400]
(rev b2)
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:04.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev 01)
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet
Controller (rev 81)
02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
02:0c.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi]
(rev 10)
02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
02:0e.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
$ lsmod
Module                  Size  Used by    Not tainted
nls_iso8859-1           3516   1 (autoclean)
cmpci                  35464   1 (autoclean)
soundcore               6436   4 (autoclean) [cmpci]
ppp_deflate             4504   2 (autoclean)
zlib_deflate           21624   0 (autoclean) [ppp_deflate]
osst                   48072   0 (autoclean) (unused)
st                     30736   0 (autoclean) (unused)
usb-storage            68276   0 (unused)
binfmt_misc             7400   1
parport_pc             19108   1 (autoclean)
lp                      8996   0 (autoclean)
parport                36960   1 (autoclean) [parport_pc lp]
nfsd                   79920   8 (autoclean)
lockd                  58128   1 (autoclean) [nfsd]
sunrpc                 81372   1 (autoclean) [nfsd lockd]
autofs                 13108   1 (autoclean)
n_hdlc                  8000   1
ppp_synctty             7840   1
ppp_async               9376   1
ppp_generic            24540   6 [ppp_deflate ppp_synctty ppp_async]
slhc                    6628   1 [ppp_generic]
ne2k-pci                7168   1 (autoclean)
8390                    8364   0 (autoclean) [ne2k-pci]
e100                   63908   1
ipt_multiport           1176   5 (autoclean)
ipt_REJECT              3832   2 (autoclean)
ipt_limit               1560   2 (autoclean)
ipt_MASQUERADE          2136   3 (autoclean)
iptable_filter          2412   1 (autoclean)
ipt_LOG                 4248  11
ipt_state               1080  23
ip_nat_ftp              4016   0 (unused)
ip_conntrack_ftp        5264   1
iptable_nat            20824   2 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           26976   3 [ipt_MASQUERADE ipt_state ip_nat_ftp
ip_conntrack_ftp iptable_nat]
ip_tables              14840  10 [ipt_multiport ipt_REJECT ipt_limit
ipt_MASQUERADE iptable_filter ipt_LOG ipt_state iptable_nat]
sg                     35820   0 (autoclean)
sr_mod                 17912   0 (autoclean)
ide-scsi               12176   0
ide-cd                 35580   0
cdrom                  33120   0 [sr_mod ide-cd]
loop                   12056   3 (autoclean)
keybdev                 2976   0 (unused)
mousedev                5460   1
hid                    21956   0 (unused)
input                   5888   0 [keybdev mousedev hid]
usb-uhci               26188   0 (unused)
usbcore                78272   2 [usb-storage hid usb-uhci]
ext3                   69760  11
jbd                    51828  11 [ext3]
tmscsim                37088   0
sd_mod                 13484   0 (unused)
scsi_mod              106872   7 [osst st usb-storage sg sr_mod ide-scsi tmscsim
sd_mod]
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.26GHz
stepping        : 4
cpu MHz         : 2289.252
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4561.30

$ free
             total       used       free     shared    buffers     cached
Mem:       1030780    1020180      10600          0     158692     633092
-/+ buffers/cache:     228396     802384
Swap:      4088056      31020    4057036
$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/md0              10079212   5805256   3761952  61% /
none                    515388         0    515388   0% /dev/shm
/dev/main/home         2873984    814604   1913564  30% /home
/dev/main/usr         10321208   5762360   4034560  59% /usr
/dev/main/var          3201076   1168292   1870176  39% /var
/dev/main/var2        24520572   5211756  18063224  23% /var2
/dev/main/nicku       55734652  27123980  26345748  51% /home/nicku
/dev/main/photos      46445552  28598296  15487960  65% /home/nicku/.photos
/dev/main/mail         8256952   5107616   2729908  66% /home/nicku/work/nsmail
/dev/main/ftp         98051740  77431664  15639340  84% /var/ftp
/dev/main/mp3         10321208   8117692   1679228  83% /mp3
/dev/main/cdimage     23738812  18602584   4171540  82% /cdimage
/$ sudo hdparm -tT /dev/md{0,1,2,3}

/dev/md0:
 Timing buffer-cache reads:   128 MB in  0.36 seconds =355.56 MB/sec
 Timing buffered disk reads:  64 MB in  1.67 seconds = 38.32 MB/sec

/dev/md1:
 Timing buffer-cache reads:   128 MB in  0.37 seconds =345.95 MB/sec
 Timing buffered disk reads:  64 MB in  0.77 seconds = 83.12 MB/sec

/dev/md2:
 Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
 Timing buffered disk reads:  64 MB in  1.31 seconds = 48.85 MB/sec

/dev/md3:
 Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
 Timing buffered disk reads:  64 MB in 21.93 seconds =  2.92 MB/sec
(last horribly. slow; get zillions of lines in syslog saying stuff like:
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 4096
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 1024
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 1024 -->
4096
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 1024
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 1024 -->
4096
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 4096
Apr  6 14:08:50 nicksbox last message repeated 2 times
Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 4096 -->
1024
does not occur like that with RH 2.4.18-x kernels)

Any pointers to web sites, information that may help, any hints, suggestions,
ideas,... all most welcome.  Actually, if replacing the motherboard would fix
it, I'd do it, but I cannot guess why it should help; Asus motherboards have
always been good to me before.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



