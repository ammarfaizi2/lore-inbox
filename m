Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIZNRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTIZNRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:17:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:19402 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262177AbTIZNRB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:17:01 -0400
X-Authenticated: #18658533
Date: Fri, 26 Sep 2003 15:16:46 +0200
From: Nikola Knezevic <nikkne@gmx.ch>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Nikola Knezevic <nikkne@gmx.ch>
Organization: necto
X-Priority: 3 (Normal)
Message-ID: <1073768233.20030926151646@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: <oops when unplugging USB Flash disk, somewhere in SCSI subsystem>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is report.
OT: ksymoops is searching for *.o files, isn't .ko suffix for modules in
2.6.0? Also, it complains about kallsyms...


[1.] One line summary of the problem:
oops when unplugging USB Flash disk, somewhere in SCSI subsystem

[2.] Full description of the problem/report:
I'm using hotplug to mount my USB Flash disk as soon it is plugged in.
It works fine, until I unplug it, which prodeuces oops. After plugging
it again, it can't be mounted.

[3.] Keywords (i.e., modules, networking, kernel):
modules, hotplugging, USB, SCSI, sd_mod, usb-storage, kernel

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test5 (root@hunin) (gcc version 3.2.2) #6 Thu Sep 25 23:02:57 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
ksymoops 2.4.9 on i686 2.6.0-test5.  Options used
     -v /usr/src/linux-2.6.0-test5/vmlinux (specified)
     -k /proc/kallsyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /usr/src/linux-2.6.0-test5/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
WARNING: USB Mass Storage data integrity not assured
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c021ae09
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c021ae09>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: cf4768f0
esi: 00000015   edi: 00000000   ebp: cd675e34   esp: cd675e28
ds: 007b   es: 007b   ss: 0068
Stack: 00000082 cd690c19 cf745640 cd675e7c c021afad c04253e0 cf6511a4 00000082 
       cf651180 cd675e60 d0945c47 cd690c00 cf7455c0 00000000 c03e9ca0 c03ae9c4 
       00000000 cf6511a8 cf6511a4 c0425428 cf4766a0 cd675e94 c021b4d7 c03a9f42 
Call Trace:
 [<c021afad>] kset_hotplug+0x13d/0x280
 [<d0945c47>] sd_remove+0x57/0x70 [sd_mod]
 [<c021b4d7>] kobject_del+0x67/0x70
 [<c0289391>] device_del+0x81/0xb0
 [<c02c00c1>] scsi_device_put+0xd1/0xf0
 [<d0944537>] sd_release+0x37/0x60 [sd_mod]
 [<c0160468>] blkdev_put+0x1d8/0x200
 [<c0160426>] blkdev_put+0x196/0x200
 [<c015eccc>] kill_block_super+0x3c/0x50
 [<c015dd4a>] deactivate_super+0x7a/0xd0
 [<c01749cc>] sys_umount+0x3c/0xa0
 [<c014bb17>] sys_munmap+0x57/0x80
 [<c011a420>] do_page_fault+0x0/0x4ba
 [<c010a3fb>] syscall_call+0x7/0xb
Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 


>>EIP; c021ae09 <get_kobj_path_length+19/30>   <=====

>>ecx; ffffffff <TSS_ESP0_OFFSET+1fb/????>
>>edx; cf4768f0 <__crc_inode_change_ok+b7580/1ccc66>
>>ebp; cd675e34 <__crc_init_module+e9604/5163b9>
>>esp; cd675e28 <__crc_init_module+e95f8/5163b9>

Trace; c021afad <kset_hotplug+13d/280>
Trace; d0945c47 <__crc_ip_dev_find+9a77e6/9daf01>
Trace; c021b4d7 <kobject_del+67/70>
Trace; c0289391 <device_del+81/b0>
Trace; c02c00c1 <scsi_device_put+d1/f0>
Trace; d0944537 <__crc_ip_dev_find+9a60d6/9daf01>
Trace; c0160468 <blkdev_put+1d8/200>
Trace; c0160426 <blkdev_put+196/200>
Trace; c015eccc <kill_block_super+3c/50>
Trace; c015dd4a <deactivate_super+7a/d0>
Trace; c01749cc <sys_umount+3c/a0>
Trace; c014bb17 <sys_munmap+57/80>
Trace; c011a420 <do_page_fault+0/4ba>
Trace; c010a3fb <syscall_call+7/b>

Code;  c021ae09 <get_kobj_path_length+19/30>
00000000 <_EIP>:
Code;  c021ae09 <get_kobj_path_length+19/30>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c021ae0b <get_kobj_path_length+1b/30>
   2:   f7 d1                     not    %ecx
Code;  c021ae0d <get_kobj_path_length+1d/30>
   4:   49                        dec    %ecx
Code;  c021ae0e <get_kobj_path_length+1e/30>
   5:   8b 52 24                  mov    0x24(%edx),%edx
Code;  c021ae11 <get_kobj_path_length+21/30>
   8:   8d 74 31 01               lea    0x1(%ecx,%esi,1),%esi
Code;  c021ae15 <get_kobj_path_length+25/30>
   c:   85 d2                     test   %edx,%edx
Code;  c021ae17 <get_kobj_path_length+27/30>
   e:   75 e7                     jne    fffffff7 <_EIP+0xfffffff7>
Code;  c021ae19 <get_kobj_path_length+29/30>
  10:   5b                        pop    %ebx
Code;  c021ae1a <get_kobj_path_length+2a/30>
  11:   89 f0                     mov    %esi,%eax
Code;  c021ae1c <get_kobj_path_length+2c/30>
  13:   5e                        pop    %esi


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
----------------8<--------------
lsmod at very begining
Module                  Size  Used by
----------------8<--------------
lsmod after plugging Flash Disk
Module                  Size  Used by
sd_mod                 14816  2 
usb_storage            27136  1 
----------------8<--------------
script used for hotplugging Flash Disk
#!/usr/bin/perl
# USB Flash Disk mount script for hotplugging interface
# 2003 (c) by Nikola Kneµeviæ <indy at hemo dot net>
# Released under GPL version 2

# setup environment vars.
$remover = $ENV{"REMOVER"};
$action = $ENV{"ACTION"};

if ( $action eq "remove" ) {
    exit 0;
}

# make sure all modules are loaded...
#$res = `/sbin/modprobe sr_mod`;
#$res = `/sbin/modprobe sd_mod`;
#$res = `/sbin/modprobe usbcore`;
#$res = `/sbin/modprobe uhci`;
#$res = `/sbin/modprobe usb-storage`;
#$res = `/sbin/modprobe vfat`;

# then create the "remover script". 
# since it is basicly oneliner, this is a neat hack
open REMSCR, ">$remover" or die "Cannot open $remover, $!";
print REMSCR "#!/bin/bash\nlogger 'about to umount /mnt/usbbar'\numount -f /mnt/usbbar";
close REMSCR;
chmod 0755,  $remover;

# Search for the coresponding scsi device is done by traversing 
# /sys/bus/scsi/devices
# When we find entry whose model is eq 'Flash Disk', we mount it

opendir SYSBUSSCSI, '/sys/bus/scsi/devices';
my @dirs= grep -d && /\d\:\d\:\d\:\d/, map "/sys/bus/scsi/devices/$_", readdir SYSBUSSCSI;
closedir SYSBUSSCSI;

$currentDevice = "";
$currentVendor = "";
foreach my $dir (@dirs) {
        if ($dir =~ /(\d)\:(\d)\:(\d)\:(\d)$/) {
                my ($host, $bus, $target, $lun) = ($1, $2, $3, $4);
                $currentDevice = "/dev/scsi/host$host/bus$bus/target$target/lun$lun/part1";
        }
        if (-e "$dir/model" && -e "$dir/rev" ) {
                my $model=`cat $dir/model`;
                my $rev  =`cat $dir/rev`;
                if ($model =~ /Flash Disk/i && $rev =~ /7\.77/) {
                        my $mtab=`cat /etc/mtab`;
#                       print "mount -t vfat -o rw,users,noexec $currentDevice /mnt/usbbar";
                        system("mount -t vfat -o defaults,rw,users,noexec,sync $currentDevice /mnt/usbbar") 
                                unless $mtab =~ /usbbar/;
                }               
        }
#       print $currentDevice;
}

----------------8<--------------
dmesg after plugging in Flash Disk
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: Flash Disk        Rev: 7.77
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: Write Protect is off
sda: Mode Sense: 00 06 00 00
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
----------------8<--------------
lsmod after unplugging Flash disk
Module                  Size  Used by
sd_mod                 14816  1 
usb_storage            27136  0 
----------------8<--------------

[7.] Environment
BASH=/bin/bash
BASH_VERSINFO=([0]="2" [1]="05b" [2]="0" [3]="1" [4]="release" [5]="i386-slackware-linux-gnu")
BASH_VERSION='2.05b.0(1)-release'
DIRSTACK=()
EUID=0
GDK_USE_XFT=1
GROUPS=()
HISTCONTROL=ignorespace
HOME=/root
HOSTNAME=hunin.knezevic.net
HOSTTYPE=i386
HUSHLOGIN=FALSE
HZ=100
IFS=$' \t\n'
INPUTRC=/etc/inputrc
LANG=C
LESS=-M
LESSOPEN='|lesspipe.sh %s'
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.bz2=01;31:*.rpm=01;31:*.deb=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.mov=01;37:'
LS_OPTIONS=' --color=auto -F -b -T 0'
MACHTYPE=i386-slackware-linux-gnu
MAIL=/var/spool/mail/root
MANPATH=/usr/local/man:/usr/man:/usr/X11R6/man:/usr/share/texmf/man
MINICOM='-c on'
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/games:/opt/www/htdig/bin:/usr/share/texmf/bin
PKG_CONFIG_PATH=:/usr/X11R6/lib/pkgconfig
PPID=745
PS4='+ '
PWD=/root
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:interactive-comments
SHLVL=3
T1LIB_CONFIG=/usr/share/t1lib/t1lib.config
TERM=linux
UID=0
USER=root
VIM=/usr/share/vim
VIMRUNTIME=/usr/share/vim/vim61
_=/bin/bash

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux hunin 2.6.0-test5 #6 Thu Sep 25 23:02:57 CEST 2003 i686 unknown
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
quota-tools            3.08.
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         sd_mod usb_storage

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1600+
stepping        : 2
cpu MHz         : 1395.679
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2752.51

[7.3.] Module information (from /proc/modules):
sd_mod 14816 1 - Live 0xd0944000
usb_storage 27136 0 - Live 0xd093c000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d007 : 0000:00:08.0
d400-d4ff : 0000:00:08.0
d800-d81f : 0000:00:0d.0
dc00-dc07 : 0000:00:0d.1
e000-e00f : 0000:00:11.1
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : 0000:00:11.2
  e400-e41f : uhci-hcd
e800-e81f : 0000:00:11.3
  e800-e81f : uhci-hcd

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00380294 : Kernel code
  00380295-0046517f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ec000000-edffffff : PCI Bus #01
  ed000000-ed00ffff : 0000:01:00.0
ee000000-ee0000ff : 0000:00:08.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
        Subsystem: Lucent Microelectronics LT WinModem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at d000 [size=8]
        Region 2: I/O ports at d400 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology RV200 QW [RADEON 7500 PRO MAYA AR]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
NONE, I've turned off /proc legacy support for SCSI
/sys/bus/scsi/devices is empty
/sys/bus/scsi/drivers/sd is empty

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

