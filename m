Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTB0NNi>; Thu, 27 Feb 2003 08:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTB0NNi>; Thu, 27 Feb 2003 08:13:38 -0500
Received: from demokritos.cytanet.com.cy ([195.14.133.252]:41123 "EHLO
	demokritos.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S264956AbTB0NNc>; Thu, 27 Feb 2003 08:13:32 -0500
Date: Thu, 27 Feb 2003 08:23:12 -0500
From: wyleus <coyote1@cytanet.com.cy>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-Id: <20030227082312.1a56684b.coyote1@cytanet.com.cy>
In-Reply-To: <200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua>
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy>
	<200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cpuburn will help you rule out defective CPU theory.
> Also you can start removing/swapping hardware parts.
> 
Thanks for taking the time to reply time, Dennis.  I ran cpuburn as you suggested.  Specifically, I ran the burnK6 binary for about an hour (from an xterm, and I also had other stuff like galeon running simultaneously) and didn't get any hiccups.  Monitoring with top, I saw that I had 0% free cpu during the test.

However I also later ran the burnMMX binary, and that one would quit after running a few minutes without printing any error messages to the screen - nor did it leave any messages in /var/log/*.  Dunno if that's normal?  Shouldn't it keep running until I kill it?

Can I draw any conclusions thus far?  Could I conclude now that the CPU and RAM are OK (because of the memtest86 and cpuburn tests)?  Also, assuming that all of my hardware is OK (yes a big assumption), could the problems I have be due to a misconfiguration or otherwise software problem?

As for swapping parts, I don't have any extra computer parts.  Given the nature of these kernel bug messages in the syslog, can I use that fact to logically limit the range of hardware that can cause these problems?  I.E. can I say for example that malfunctioning PSU, RAM, CPU or Mobo can cause these symptoms, but that the ISA sound card, or the video card would not?  Or do I have no choice but to suspect each and every piece of hardware in my box?

I would like to narrow things down if possible, but don't have the experience/knowledge to make these judgements myself.  Which is why I seeking advice, of course.

> Test with some vanilla 2.4 kernels, not a distro one. If 2.4.20 crashes,
> try some of the earlier kernels too. Compile them for 386 uniprocessor
> with debugging and magic SysRq enabled. Provide your .config
> 
As I mentioned to John, I'm still a newbie and don't feel comfortable yet in my competency to replace the kernel.  I have a lot of (newbie) time invested in this installation and don't want to break it by messing with stuff that's way beyond my understanding.

> Run your klogd with -x to make it stop decoding oopses.
> Run oopses thru ksymoops and provide result.
> 
I'm not clear whether you intended these suggestions to apply after I've changed the kernel, or also to my current setup.  

Assuming you mean applying it currently - grepping for klogd in /etc shows that mandrake uses an environment variable KLOGD_OPTIONS to run klogd.  This was set to "-2".  However the variable is set to this value in no less than 32 different files.  24 of them see to be related to runlevels (4x6), and 8 unrelated.  This means that (if my logic is correct) that the same variable is set 9 times for a particular runlevel (rl-3 in my case).  Which one should I change that won't get overridden?  Or should I change them all, or use another approach?

(Thanks again for your help - wyleus signing off)

> Provide lsmod, lspci output, some of /proc/* files (interrupts etc)

Assuming more is better than less;

# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03)

# lsmod
Module                  Size  Used by    Not tainted
tdfx                   31524   1 
agpgart                31840   0  (autoclean) (unused)
sr_mod                 15096   0  (autoclean) (unused)
parport_pc             21672   1  (autoclean)
lp                      6720   0  (autoclean)
parport                23936   1  (autoclean) [parport_pc lp]
ipt_TOS                  984  12  (autoclean)
ipt_LOG                 3384   5  (autoclean)
ipt_REJECT              2744   4  (autoclean)
ipt_state                568   9  (autoclean)
iptable_mangle          2072   1  (autoclean)
ip_nat_irc              2384   0  (unused)
ip_nat_ftp              2992   0  (unused)
iptable_nat            15224   2  [ip_nat_irc ip_nat_ftp]
ip_conntrack_irc        3056   1 
ip_conntrack_ftp        3952   1 
ip_conntrack           18400   4  [ipt_state ip_nat_irc ip_nat_ftp iptable_nat i
p_conntrack_irc ip_conntrack_ftp]
iptable_filter          1644   1  (autoclean)
ip_tables              11672   9  [ipt_TOS ipt_LOG ipt_REJECT ipt_state iptable_
mangle iptable_nat iptable_filter]
nfsd                   66576   0  (autoclean)
lockd                  46480   0  (autoclean) [nfsd]
sunrpc                 60188   0  (autoclean) [nfsd lockd]
ppp_synctty             5952   1  (autoclean)
ppp_generic            20064   3  (autoclean) [ppp_synctty]
slhc                    5072   0  (autoclean) [ppp_generic]
n_hdlc                  6368   1  (autoclean)
nls_iso8859-1           2844   1  (autoclean)
nls_cp850               3580   1  (autoclean)
vfat                    9588   1  (autoclean)
fat                    31864   0  (autoclean) [vfat]
supermount             14340   1  (autoclean)
ide-cd                 28712   0 
cdrom                  26848   0  [sr_mod ide-cd]
ide-scsi                8212   0 
scsi_mod               90372   2  [sr_mod ide-scsi]
sb                      7668   0 
sb_lib                 34958   0  [sb]
uart401                 6628   0  [sb_lib]
sound                  55732   0  [sb_lib uart401]
soundcore               3780   0  [sb_lib sound]
usb-ohci               18216   0  (unused)
usbcore                58304   1  [usb-ohci]
rtc                     6560   0  (autoclean)
ext3                   74004   2 
jbd                    38452   2  [ext3]

# cat /proc/interrupts 
           CPU0       
  0:     382609          XT-PIC  timer
  1:       8129          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:       1559          XT-PIC  usb-ohci
 12:      48716          XT-PIC  PS/2 Mouse
 14:      12691          XT-PIC  ide0
 15:          7          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

# cat /proc/cpuinfo    
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 350.810
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 699.59

# cat /proc/devices 
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  6 lp
  7 vcs
 10 misc
 14 sound
 29 fb
108 ppp
128 ptm
136 pts/%d
162 raw
180 usb
226 drm

Block devices:
  1 ramdisk
  3 ide0
  9 md
 11 sr
 22 ide1

# cat /proc/dma     
 1: SoundBlaster8
 4: cascade

# cat /proc/filesystems 
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
        ext2
nodev   ramfs
nodev   devfs
nodev   devpts
        ext3
nodev   usbdevfs
nodev   usbfs
nodev   supermount
        vfat

# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0022614c : Kernel code
  0022614d-0029547f : Kernel data
c7c00000-cbcfffff : PCI Bus #01
  c8000000-c9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
cbe00000-cfefffff : PCI Bus #01
  cc000000-cdffffff : 3Dfx Interactive, Inc. Voodoo Banshee
dffff000-dfffffff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
  dffff000-dfffffff : usb-ohci
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffe0000-ffffffff : reserved

# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  cc00-ccff : 3Dfx Interactive, Inc. Voodoo Banshee
ffa0-ffaf : Acer Laboratories Inc. [ALi] M5229 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

# cat /proc/pci        
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 4).
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 4).
      Master Capable.  Latency=64.  Min Gnt=11.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 3).
      IRQ 9.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xdffff000 [0xdfffffff].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 195).
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 193).
      IRQ 14.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xffa0 [0xffaf].
  Bus  1, device   0, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 3).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xcc000000 [0xcdffffff].
      Prefetchable 32 bit memory at 0xc8000000 [0xc9ffffff].
      I/O at 0xcc00 [0xccff].

