Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWJEQ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWJEQ5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWJEQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:57:40 -0400
Received: from fw03-net.analyticinnovations.com ([65.206.171.66]:22008 "EHLO
	fw03-net.analyticinnovations.com") by vger.kernel.org with ESMTP
	id S1751369AbWJEQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:57:37 -0400
Message-ID: <45253993.9070400@analyticinnovations.com>
Date: Thu, 05 Oct 2006 11:57:55 -0500
From: Eric Kamm <eric@analyticinnovations.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: machine oops under heavy I/O or network access ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I apologize for the long post.   I tried to include as much
relevant information as possible.

Thank you,
Eric


[1.] One line summary of the problem:
machine oops under heavy I/O or network access ???

[2.] Full description of the problem/report:

I have a Supermicro X6DHE-XG2 (Intel E7520 chipset) with dual Xeon with 4GB RAM.
I am using one 3ware 8005 controller, three 3ware 9550sx controllers, and
reiserfs.  This machine is acting primarily to serve NFS.

The oops below are from my original machine configuration, but I have tried other
some variations and have other oops:

     - I have tried Suse 10.1 kernels 2.6.16.13-4-smp and 2.6.16.13-4-default.
     - I have rebuilt the system onto an identical spare hardware configuration.
     - I have used 64-bit and 32-bit kernel versions.
     - I have replaced all the shared reiserfs filesytems with ext3.

In all cases under load, disk IO alone (NFS server off) or disk IO+NFS operations,
the system has oops and "general protection fault" errors.

The process is usually nfds or rpc.mountd, but (with the NFS server turned off) I
also have errors from, for example, cp and rsync.  The system has been up for as
much as 16 hours with no problems, and sometimes as little as five minutes.


[3.] Keywords (i.e., modules, networking, kernel):
scsi, 3ware, networking, nfs


[4.] Kernel version (from /proc/version):
Linux version 2.6.16.13-4-smp (geeko@buildhost) (gcc version 4.1.0 (SUSE Linux)) #1 SMP Wed May 3 04:53:23 UTC 2006


[5.] Output of Oops.. message (if applicable) with symbolic information

I've included four oops because I thought it was interesting that the
stack didn't always include an nfsd_ or reiserfs_ function.  These oops
were always followed up by numerous others until the machine locks up
or I reboot it.  Not shown, most of my oops start with process nfsd or rpc.mountd.

=========

Unable to handle kernel paging request at 00000000ffffffff RIP:
<ffffffff8018fcbf>{__d_lookup+219}
PGD 0
Oops: 0000 [1] SMP
last sysfs file: /class/scsi_host/host0/stats
CPU 3
Modules linked in: iptable_filter ip_tables x_tables joydev st sr_mod nfs nfsd exportfs lockd nfs_acl sunrpc edd ipv6 button battery ac ext3 jbd loop dm_mod shpchp floppy pci_hotplug i2c_i801 i8xx_tco 
ehci_hcd ide_cd uhci_hcd e1000 i2c_core cdrom usbcore parport_pc lp parport reiserfs fan thermal processor sg 3w_9xxx 3w_xxxx piix sd_mod scsi_mod ide_disk ide_core
Pid: 2662, comm: irqbalance Not tainted 2.6.16.13-4-smp #1
RIP: 0010:[<ffffffff8018fcbf>] <ffffffff8018fcbf>{__d_lookup+219}
RSP: 0018:ffff810121321bf8  EFLAGS: 00010206
RAX: 00000000ffffffff RBX: ffff810039bb17d0 RCX: 0000000000000013
RDX: 00000000000595c6 RSI: 00c38323723595c6 RDI: ffff810015e3a3c0
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 000001b600008242 R11: ffffffff801d385d R12: ffff810015e3a3c0
R13: ffff810121321c98 R14: 000000000001967c R15: 0000000000000002
FS:  00002ae76c7356d0(0000) GS:ffff81012b6569c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000ffffffff CR3: 0000000120db2000 CR4: 00000000000006e0
Process irqbalance (pid: 2662, threadinfo ffff810121320000, task ffff81012b1467d0)
Stack: ffff81004aafe00a 0000000000000101 ffff810121321ea8 ffff81011ea61cd8
        0000000000000000 ffff810121321ea8 ffff810121321c98 ffffffff8018737b
        ffffffff803413e0 ffff810121321ca8
Call Trace: <ffffffff8018737b>{do_lookup+42} <ffffffff80188e9c>{__link_path_walk+922}
        <ffffffff801899e0>{link_path_walk+92} <ffffffff801677f1>{remove_vma+110}
        <ffffffff80189e30>{do_path_lookup+605} <ffffffff8018a838>{__path_lookup_intent_open+86}
        <ffffffff8018aa22>{open_namei+144} <ffffffff801796c9>{do_filp_open+28}
        <ffffffff801677f1>{remove_vma+110} <ffffffff80179729>{do_sys_open+68}
        <ffffffff8010a7be>{system_call+126}

Code: 48 8b 45 00 0f 18 08 48 8d 5d e8 44 39 73 30 75 e6 e9 70 ff
RIP <ffffffff8018fcbf>{__d_lookup+219} RSP <ffff810121321bf8>
CR2: 00000000ffffffff

=========

Unable to handle kernel paging request at 00000000ffffffff RIP:
<ffffffff8018fcbf>{__d_lookup+219}
PGD 101a89067 PUD 0
Oops: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:02.1/power/state
CPU 2
Modules linked in: nfs autofs4 nfsd exportfs lockd nfs_acl sunrpc edd ipv6 button battery ac ext3 jbd loop dm_mod floppy uhci_hcd shpchp ide_cd pci_hotplug ehci_hcd e1000 cdrom usbcore i2c_i801 
i2c_core i8xx_tco parport_pc lp parport reiserfs fan thermal processor sg 3w_9xxx 3w_xxxx piix sd_mod scsi_mod ide_disk ide_core
Pid: 4567, comm: rsync Not tainted 2.6.16.13-4-smp #1
RIP: 0010:[<ffffffff8018fcbf>] <ffffffff8018fcbf>{__d_lookup+219}
RSP: 0018:ffff81010eeb5c08  EFLAGS: 00010206
RAX: 00000000ffffffff RBX: ffff81011fb17220 RCX: 0000000000000013
RDX: 0000000000033c5c RSI: 00c383208d2b3c5c RDI: ffff810081886490
RBP: 00000000ffffffff R08: 000000000000000a R09: 000000000000000a
R10: ffff81012b3a30c0 R11: ffffffff801d373e R12: ffff810081886490
R13: ffff81010eeb5ca8 R14: 0000000001ce1af1 R15: 0000000000000004
FS:  00002b18e6c342d0(0000) GS:ffff81012bd6b2c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000ffffffff CR3: 000000010815b000 CR4: 00000000000006e0
Process rsync (pid: 4567, threadinfo ffff81010eeb4000, task ffff81012b3a30c0)
Stack: ffff81010143001d 00000000000041ed ffff81010eeb5e48 ffff810081fe1be0
        0000000000000000 ffff81010eeb5e48 ffff81010eeb5ca8 ffffffff8018737b
        00000000000041ed ffff81010eeb5cb8
Call Trace: <ffffffff8018737b>{do_lookup+42} <ffffffff8018949b>{__link_path_walk+2457}
        <ffffffff801899e0>{link_path_walk+92} <ffffffff880cada2>{:reiserfs:reiserfs_dirty_inode+111}
        <ffffffff80189e30>{do_path_lookup+605} <ffffffff80155bd6>{audit_getname+145}
        <ffffffff8018a69a>{__user_walk_fd+55} <ffffffff80183445>{vfs_lstat_fd+24}
        <ffffffff880cada2>{:reiserfs:reiserfs_dirty_inode+111}
        <ffffffff80155865>{audit_syscall_entry+301} <ffffffff80183639>{sys_newlstat+25}
        <ffffffff8010d94e>{syscall_trace_enter+190} <ffffffff8010a8d1>{tracesys+113}
        <ffffffff8010a931>{tracesys+209}

Code: 48 8b 45 00 0f 18 08 48 8d 5d e8 44 39 73 30 75 e6 e9 70 ff
RIP <ffffffff8018fcbf>{__d_lookup+219} RSP <ffff81010eeb5c08>
CR2: 00000000ffffffff

=========

Unable to handle kernel NULL pointer dereference at 00000000000000ff RIP:
<ffffffff8018fcbf>{__d_lookup+219}
PGD 905f7067 PUD 8d68c067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /block/sda/sda1/size
CPU 2
Modules linked in: nfs nfsd exportfs lockd nfs_acl sunrpc ipv6 edd ext3 jbd loop dm_mod floppy shpchp pci_hotplug uhci_hcd ehci_hcd i2c_i801 ide_cd cdrom e1000 usbcore i2c_core i8xx_tco parport_pc lp 
parport reiserfs fan thermal processor 3w_9xxx sg 3w_xxxx piix sd_mod scsi_mod ide_disk ide_core
Pid: 4969, comm: nfsd Not tainted 2.6.16.13-4-smp #1
RIP: 0010:[<ffffffff8018fcbf>] <ffffffff8018fcbf>{__d_lookup+219}
RSP: 0018:ffff810128c81d28  EFLAGS: 00010206
RAX: 00000000000000ff RBX: ffff8101118ded7f RCX: 0000000000000013
RDX: 000000000000cc77 RSI: 00c383205ca8cc77 RDI: ffff8100244593c0
RBP: 00000000000000ff R08: 698eef27d191767a R09: ffff81010f3c32f0
R10: ffff81007434b438 R11: ffffffff801d373e R12: ffff8100244593c0
R13: ffff810128c81d98 R14: 00000000d191767a R15: 0000000000000031
FS:  00002b0a012176d0(0000) GS:ffff81012bd6b2c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000000ff CR3: 00000000c7386000 CR4: 00000000000006e0
Process nfsd (pid: 4969, threadinfo ffff810128c80000, task ffff81011e723100)
Stack: ffff810111ee6070 0000000000000000 ffff8100244593c0 ffff810128c81d98
        0000000000000000 ffff81007434b408 ffff810111ee6070 ffffffff8018840f
        0000000000000000 ffff8100244593c0
Call Trace: <ffffffff8018840f>{__lookup_hash+90} <ffffffff801889ec>{lookup_one_len+84}
        <ffffffff882f831a>{:nfsd:nfsd_lookup+864} <ffffffff882fd587>{:nfsd:nfsd3_proc_lookup+197}
        <ffffffff882f20e9>{:nfsd:nfsd_dispatch+215} <ffffffff882a920a>{:sunrpc:svc_process+956}
        <ffffffff802d04cc>{__down_read+18} <ffffffff882f2641>{:nfsd:nfsd+451}
        <ffffffff8010b672>{child_rip+8} <ffffffff882f247e>{:nfsd:nfsd+0}
        <ffffffff8010b66a>{child_rip+0}

Code: 48 8b 45 00 0f 18 08 48 8d 5d e8 44 39 73 30 75 e6 e9 70 ff
RIP <ffffffff8018fcbf>{__d_lookup+219} RSP <ffff810128c81d28>
CR2: 00000000000000ff

========

Unable to handle kernel paging request at 00000000ffffffff RIP:
<ffffffff8018fcbf>{__d_lookup+219}
PGD b17a4067 PUD 0
Oops: 0000 [1] SMP
last sysfs file: /block/sda/sda1/size
CPU 3
Modules linked in: autofs4 nfsd exportfs lockd nfs_acl sunrpc ipv6 edd ext3 jbd loop dm_mod floppy uhci_hcd shpchp ehci_hcd usbcore ide_cd pci_hotplug i2c_i801 e1000 i8xx_tco cdrom i2c_core parport_pc 
lp parport reiserfs fan thermal processor sg 3w_9xxx 3w_xxxx piix sd_mod scsi_mod ide_disk ide_core
Pid: 8644, comm: beagle-build-in Not tainted 2.6.16.13-4-smp #1
RIP: 0010:[<ffffffff8018fcbf>] <ffffffff8018fcbf>{__d_lookup+219}
RSP: 0018:ffff8100b0c27c08  EFLAGS: 00010206
RAX: 00000000ffffffff RBX: ffff81010ac01be0 RCX: 0000000000000013
RDX: 00000000000235e9 RSI: 00c3832001fa35e9 RDI: ffff81010fb723c0
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: ffff8100b1cb20c0 R11: ffffffff801d373e R12: ffff81010fb723c0
R13: ffff8100b0c27ca8 R14: 000000008e39854e R15: 000000000000001a
FS:  0000000040485940(0063) GS:ffff81012b6569c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000ffffffff CR3: 00000000b178a000 CR4: 00000000000006e0
Process beagle-build-in (pid: 8644, threadinfo ffff8100b0c26000, task ffff8100b1cb20c0)
Stack: ffff8100b1c8201d 00000000000041ed ffff8100b0c27e48 ffff81010fbea650
        0000000000000000 ffff8100b0c27e48 ffff8100b0c27ca8 ffffffff8018737b
        00000000000041ed ffff8100b0c27cb8
Call Trace: <ffffffff8018737b>{do_lookup+42} <ffffffff8018949b>{__link_path_walk+2457}
        <ffffffff801899e0>{link_path_walk+92} <ffffffff80189e30>{do_path_lookup+605}
        <ffffffff80155bd6>{audit_getname+145} <ffffffff8018a69a>{__user_walk_fd+55}
        <ffffffff8018349f>{vfs_stat_fd+27} <ffffffff80155865>{audit_syscall_entry+301}
        <ffffffff8018366a>{sys_newstat+25} <ffffffff8010d94e>{syscall_trace_enter+190}
        <ffffffff8010a8d1>{tracesys+113} <ffffffff8010a931>{tracesys+209}

Code: 48 8b 45 00 0f 18 08 48 8d 5d e8 44 39 73 30 75 e6 e9 70 ff
RIP <ffffffff8018fcbf>{__d_lookup+219} RSP <ffff8100b0c27c08>
CR2: 00000000ffffffff


[6.] A small shell script or example program which triggers the
Sadly, I cannot trigger this problem easily.  It seems to happen most
often when I bring the server online with lots of NFS client requests
(~60 clients), but it may still take up to sixteen hours or as little
as five minutes.


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lxnfs01 2.6.16.13-4-smp #1 SMP Wed May 3 04:53:23 UTC 2006 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.1.0
Gnu make               3.80
binutils               2.16.91.0.5
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.10
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.7.11
PPP                    2.4.3
isdn4k-utils           3.9
nfs-utils              1.0.7
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Linux C++ Library      6.0.8
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.93
udev                   085
Modules Loaded         joydev st sr_mod nfs autofs4 nfsd exportfs lockd nfs_acl sunrpc ipv6 af_packet edd ext3 jbd loop dm_mod floppy shpchp ide_cd e1000 i2c_i801 cdrom pci_hotplug i2c_core i8xx_tco 
ehci_hcd uhci_hcd usbcore parport_pc lp parport reiserfs fan thermal processor sg 3w_9xxx 3w_xxxx piix sd_mod scsi_mod ide_disk ide_core

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 3
cpu MHz         : 3000.144
cache size      : 2048 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6009.08
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 3
cpu MHz         : 3000.144
cache size      : 2048 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6000.74
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):
joydev 27520 0 - Live 0xffffffff883a6000
st 55332 0 - Live 0xffffffff88397000
sr_mod 33060 0 - Live 0xffffffff8838d000
nfs 231864 1 - Live 0xffffffff88353000
autofs4 37768 1 - Live 0xffffffff88348000
nfsd 267368 9 - Live 0xffffffff88305000
exportfs 22272 1 nfsd, Live 0xffffffff882fe000
lockd 87792 3 nfs,nfsd, Live 0xffffffff882e7000
nfs_acl 20352 2 nfs,nfsd, Live 0xffffffff882e1000
sunrpc 172616 11 nfs,nfsd,lockd,nfs_acl, Live 0xffffffff882b5000
ipv6 328736 41 - Live 0xffffffff88263000
af_packet 55820 2 - Live 0xffffffff88254000
edd 26760 0 - Live 0xffffffff8824c000
ext3 150288 19 - Live 0xffffffff88226000
jbd 84416 1 ext3, Live 0xffffffff88210000
loop 32528 0 - Live 0xffffffff881b7000
dm_mod 77616 73 - Live 0xffffffff881fc000
floppy 82984 0 - Live 0xffffffff881e6000
shpchp 62368 0 - Live 0xffffffff881d3000
ide_cd 57248 0 - Live 0xffffffff881c2000
e1000 130744 0 - Live 0xffffffff88196000
i2c_i801 25876 0 - Live 0xffffffff8818e000
cdrom 52392 2 sr_mod,ide_cd, Live 0xffffffff88180000
pci_hotplug 45056 1 shpchp, Live 0xffffffff88172000
i2c_core 40192 1 i2c_i801, Live 0xffffffff88167000
i8xx_tco 24616 0 - Live 0xffffffff8815f000
ehci_hcd 47624 0 - Live 0xffffffff88150000
uhci_hcd 48544 0 - Live 0xffffffff88143000
usbcore 150312 3 ehci_hcd,uhci_hcd, Live 0xffffffff8811d000
parport_pc 56680 0 - Live 0xffffffff8810e000
lp 29768 0 - Live 0xffffffff88105000
parport 56716 2 parport_pc,lp, Live 0xffffffff880f6000
reiserfs 241280 7 - Live 0xffffffff880ba000
fan 21896 0 - Live 0xffffffff880b3000
thermal 32272 0 - Live 0xffffffff880aa000
processor 50280 1 thermal, Live 0xffffffff8809c000
sg 52264 0 - Live 0xffffffff8808e000
3w_9xxx 50180 49 - Live 0xffffffff8807e000
3w_xxxx 43424 4 - Live 0xffffffff88072000
piix 27652 0 [permanent], Live 0xffffffff8806a000
sd_mod 34176 8 - Live 0xffffffff88060000
scsi_mod 163888 6 st,sr_mod,sg,3w_9xxx,3w_xxxx,sd_mod, Live 0xffffffff88036000
ide_disk 32896 0 - Live 0xffffffff8802c000
ide_core 165764 3 ide_cd,piix,ide_disk, Live 0xffffffff88002000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
   1000-107f : motherboard
     1000-1003 : PM1a_EVT_BLK
     1004-1005 : PM1a_CNT_BLK
     1008-100b : PM_TMR
     1020-1020 : PM2_CNT_BLK
     1028-102f : GPE0_BLK
     1060-106f : i8xx TCO
1100-111f : 0000:00:1f.3
   1100-110f : i801_smbus
1180-11bf : 0000:00:1f.0
   1180-11bf : motherboard
1400-141f : 0000:00:1d.0
   1400-141f : uhci_hcd
1420-143f : 0000:00:1d.1
   1420-143f : uhci_hcd
1440-145f : 0000:00:1d.2
   1440-145f : uhci_hcd
1460-147f : 0000:00:1d.3
   1460-147f : uhci_hcd
14a0-14af : 0000:00:1f.1
   14a0-14a7 : ide0
   14a8-14af : ide1
2000-3fff : PCI Bus #01
   2000-2fff : PCI Bus #02
     2000-200f : 0000:02:03.0
       2000-200f : 3w-xxxx
   3000-3fff : PCI Bus #03
     3000-303f : 0000:03:01.0
       3000-303f : 3w-9xxx
     3040-307f : 0000:03:02.0
       3040-307f : e1000
     3080-30bf : 0000:03:02.1
       3080-30bf : e1000
4000-5fff : PCI Bus #05
   4000-4fff : PCI Bus #06
     4000-403f : 0000:06:01.0
       4000-403f : 3w-9xxx
   5000-5fff : PCI Bus #07
     5000-503f : 0000:07:01.0
       5000-503f : 3w-9xxx
6000-6fff : PCI Bus #08
   6000-60ff : 0000:08:01.0
fe00-fe00 : motherboard
00000000-0009a7ff : System RAM
   00000000-00000000 : Crash kernel
0009a800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000c9000-000c9fff : Adapter ROM
000cc800-000ccfff : Adapter ROM
000cd000-000cd7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-cff6ffff : System RAM
   00100000-002d5e17 : Kernel code
   002d5e18-003af61f : Kernel data
cff70000-cff77fff : ACPI Tables
cff78000-cff7ffff : ACPI Non-volatile Storage
cff80000-cfffffff : reserved
d1000000-d10fffff : PCI Bus #08
   d1000000-d101ffff : 0000:08:01.0
d1100000-d11003ff : 0000:00:1f.1
d6000000-d6000fff : 0000:00:01.0
d6001000-d60013ff : 0000:00:1d.7
   d6001000-d60013ff : ehci_hcd
d6100000-d70fffff : PCI Bus #01
   d6100000-d6100fff : 0000:01:00.1
   d6101000-d6101fff : 0000:01:00.3
   d6200000-d6ffffff : PCI Bus #02
     d6200000-d620000f : 0000:02:03.0
       d6200000-d620000f : 3w-xxxx
     d6210000-d621ffff : 0000:02:03.0
     d6800000-d6ffffff : 0000:02:03.0
       d6800000-d6ffffff : 3w-xxxx
   d7000000-d70fffff : PCI Bus #03
     d7000000-d7000fff : 0000:03:01.0
       d7000000-d7000fff : 3w-9xxx
     d7020000-d703ffff : 0000:03:02.0
       d7020000-d703ffff : e1000
     d7040000-d705ffff : 0000:03:02.1
       d7040000-d705ffff : e1000
     d7060000-d707ffff : 0000:03:01.0
d7100000-d73fffff : PCI Bus #05
   d7100000-d7100fff : 0000:05:00.1
   d7101000-d7101fff : 0000:05:00.3
   d7200000-d72fffff : PCI Bus #06
     d7200000-d7200fff : 0000:06:01.0
       d7200000-d7200fff : 3w-9xxx
     d7220000-d723ffff : 0000:06:01.0
   d7300000-d73fffff : PCI Bus #07
     d7300000-d7300fff : 0000:07:01.0
       d7300000-d7300fff : 3w-9xxx
     d7320000-d733ffff : 0000:07:01.0
d7400000-d8ffffff : PCI Bus #08
   d7400000-d7400fff : 0000:08:01.0
   d8000000-d8ffffff : 0000:08:01.0
     d8000000-d87effff : vesafb
da000000-dbffffff : PCI Bus #01
   da000000-dbffffff : PCI Bus #03
     da000000-dbffffff : 0000:03:01.0
       da000000-dbffffff : 3w-9xxx
dc000000-dfffffff : PCI Bus #05
   dc000000-ddffffff : PCI Bus #06
     dc000000-ddffffff : 0000:06:01.0
       dc000000-ddffffff : 3w-9xxx
   de000000-dfffffff : PCI Bus #07
     de000000-dfffffff : 0000:07:01.0
       de000000-dfffffff : 3w-9xxx
e0000000-efffffff : reserved
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved
100000000-12fffffff : System RAM

[7.5.] PCI information (lspci -vvv as root)
00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [40] Vendor Specific Information

00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [b0] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                 Address: fee00000  Data: 0000

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
         I/O behind bridge: 00002000-00003fff
         Memory behind bridge: d6100000-d70fffff
         Prefetchable memory behind bridge: 00000000da000000-00000000dbf00000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                 Address: fee00000  Data: 0000
         Capabilities: [64] Express Root Port (Slot-) IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 2
                 Link: Latency L0s <4us, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
                 Root: Correctable- Non-Fatal- Fatal- PME-

00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                 Address: fee00000  Data: 0000
         Capabilities: [64] Express Root Port (Slot-) IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x0, ASPM L0s, Port 4
                 Link: Latency L0s <4us, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x0
                 Root: Correctable- Non-Fatal- Fatal- PME-

00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=05, subordinate=07, sec-latency=0
         I/O behind bridge: 00004000-00005fff
         Memory behind bridge: d7100000-d73fffff
         Prefetchable memory behind bridge: 00000000dc000000-00000000dff00000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                 Address: fee00000  Data: 0000
         Capabilities: [64] Express Root Port (Slot-) IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 6
                 Link: Latency L0s <4us, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
                 Root: Correctable- Non-Fatal- Fatal- PME-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 4: I/O ports at 1400 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 217
         Region 4: I/O ports at 1420 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 177
         Region 4: I/O ports at 1440 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 4: I/O ports at 1460 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 225
         Region 0: Memory at d6001000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=08, subordinate=08, sec-latency=32
         I/O behind bridge: 00006000-00006fff
         Memory behind bridge: d7400000-d8ffffff
         Prefetchable memory behind bridge: d1000000-d10fffff
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 177
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at 14a0 [size=16]
         Region 5: Memory at d1100000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 4: I/O ports at 1100 [size=32]

01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 10
         Bus: primary=01, secondary=02, subordinate=02, sec-latency=48
         I/O behind bridge: 00002000-00002fff
         Memory behind bridge: d6200000-d6ffffff
         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal+ Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d8] PCI-X bridge device
                 Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
                 Status: Dev=01:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
                 Upstream: Capacity=65535 CommitmentLimit=65535
                 Downstream: Capacity=65535 CommitmentLimit=65535

01:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt Controller A (rev 09) (prog-if 20 [IO(X)-APIC])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d6100000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 10
         Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
         I/O behind bridge: 00003000-00003fff
         Memory behind bridge: d7000000-d70fffff
         Prefetchable memory behind bridge: 00000000da000000-00000000dbf00000
         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal+ Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d8] PCI-X bridge device
                 Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
                 Status: Dev=01:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
                 Upstream: Capacity=65535 CommitmentLimit=65535
                 Downstream: Capacity=65535 CommitmentLimit=65535

01:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B (rev 09) (prog-if 20 [IO(X)-APIC])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d6101000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 RAID bus controller: 3ware Inc 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
         Subsystem: 3ware Inc 7xxx/8xxx-series PATA/SATA-RAID
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (2250ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 185
         Region 0: I/O ports at 2000 [size=16]
         Region 1: Memory at d6200000 (32-bit, non-prefetchable) [size=16]
         Region 2: Memory at d6800000 (32-bit, non-prefetchable) [size=8M]
         [virtual] Expansion ROM at d6210000 [disabled] [size=64K]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:01.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
         Subsystem: 3ware Inc 9550SX SATA-RAID
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (16000ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 193
         Region 0: Memory at da000000 (64-bit, prefetchable) [size=32M]
         Region 2: Memory at d7000000 (64-bit, non-prefetchable) [size=4K]
         Region 4: I/O ports at 3000 [size=64]
         [virtual] Expansion ROM at d7060000 [disabled] [size=128K]
         Capabilities: [e0] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=3
                 Status: Dev=03:01.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=512 DMOST=3 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [e8] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                 Address: 0000000000000000  Data: 0000

03:02.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
         Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 233
         Region 0: Memory at d7020000 (64-bit, non-prefetchable) [size=128K]
         Region 4: I/O ports at 3040 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=1
                 Status: Dev=03:02.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

03:02.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
         Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), Cache Line Size 08
         Interrupt: pin B routed to IRQ 50
         Region 0: Memory at d7040000 (64-bit, non-prefetchable) [size=128K]
         Region 4: I/O ports at 3080 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=1
                 Status: Dev=03:02.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

05:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 10
         Bus: primary=05, secondary=06, subordinate=06, sec-latency=64
         I/O behind bridge: 00004000-00004fff
         Memory behind bridge: d7200000-d72fffff
         Prefetchable memory behind bridge: 00000000dc000000-00000000ddf00000
         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal+ Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d8] PCI-X bridge device
                 Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
                 Status: Dev=05:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
                 Upstream: Capacity=65535 CommitmentLimit=65535
                 Downstream: Capacity=65535 CommitmentLimit=65535

05:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt Controller A (rev 09) (prog-if 20 [IO(X)-APIC])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d7100000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 10
         Bus: primary=05, secondary=07, subordinate=07, sec-latency=64
         I/O behind bridge: 00005000-00005fff
         Memory behind bridge: d7300000-d73fffff
         Prefetchable memory behind bridge: 00000000de000000-00000000dff00000
         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal+ Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d8] PCI-X bridge device
                 Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
                 Status: Dev=05:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
                 Upstream: Capacity=65535 CommitmentLimit=65535
                 Downstream: Capacity=65535 CommitmentLimit=65535

05:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B (rev 09) (prog-if 20 [IO(X)-APIC])
         Subsystem: Super Micro Computer Inc Unknown device 6180
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d7101000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 256 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x8
         Capabilities: [6c] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:01.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
         Subsystem: 3ware Inc 9550SX SATA-RAID
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (16000ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 201
         Region 0: Memory at dc000000 (64-bit, prefetchable) [size=32M]
         Region 2: Memory at d7200000 (64-bit, non-prefetchable) [size=4K]
         Region 4: I/O ports at 4000 [size=64]
         [virtual] Expansion ROM at d7220000 [disabled] [size=128K]
         Capabilities: [e0] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=3
                 Status: Dev=06:01.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=512 DMOST=3 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [e8] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                 Address: 0000000000000000  Data: 0000

07:01.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
         Subsystem: 3ware Inc 9550SX SATA-RAID
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (16000ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 209
         Region 0: Memory at de000000 (64-bit, prefetchable) [size=32M]
         Region 2: Memory at d7300000 (64-bit, non-prefetchable) [size=4K]
         Region 4: I/O ports at 5000 [size=64]
         [virtual] Expansion ROM at d7320000 [disabled] [size=128K]
         Capabilities: [e0] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=3
                 Status: Dev=07:01.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=512 DMOST=3 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [e8] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                 Address: 0000000000000000  Data: 0000

08:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Rage XL
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66 (2000ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: I/O ports at 6000 [size=256]
         Region 2: Memory at d7400000 (32-bit, non-prefetchable) [size=4K]
         [virtual] Expansion ROM at d1000000 [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[8.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: 3ware    Model: Logical Disk 0   Rev: 1.2
   Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: AMCC     Model: 9550SX-8LP DISK  Rev: 3.04
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: AMCC     Model: 9550SX-8LP DISK  Rev: 3.04
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: AMCC     Model: 9550SX-8LP DISK  Rev: 3.04
   Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

The machines this NFS servers serves to includes 2.4 and 2.6 Linux clients
as well Solaris 7,8,9,10 clients, and one SunOS 2.6 client.


[X.] Other notes, patches, fixes, workarounds:
