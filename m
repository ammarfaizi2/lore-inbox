Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRBMNgj>; Tue, 13 Feb 2001 08:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBMNgT>; Tue, 13 Feb 2001 08:36:19 -0500
Received: from lindy.SoftHome.net ([204.144.232.9]:14095 "HELO
	lindy.softhome.net") by vger.kernel.org with SMTP
	id <S129226AbRBMNgL>; Tue, 13 Feb 2001 08:36:11 -0500
Message-ID: <20010213140300.10427.qmail@lindy.softhome.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2pre3 panic with nfsd
Date: Tue, 13 Feb 2001 07:03:00 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a crash from nfsd on 2.4.2pre3.  Cpuinfo below ksymoops output.
Top state at crash below ksymoops.

Exported disks are 3 partitions of one scsi disk device.
All three filesystems are ext2.
Scsi adapter is buslogic.
Two tulip network cards.
Two heavy use write-mostly nfs clients.

gcc version 2.95.2 20000220 (Debian GNU/Linux)

Brian


No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Reading Oops report from the terminal
c011484a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011484a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010883
eax: 72747334   ebx: 7274733c   ecx: 00000001   edx: 00000001
esi: cfdae750   edi: c6db3ce0   ebp: df355c78   esp: df355c58
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 366, stackpage=df355000)
Stack: cfdae680 cfdae750 d7b18b60 72747334 c6db3ce4 00000001 00000282 00000001
       00000000 c020abbb 00000000 d7b18b60 cc670e60 00000018 00000020 00000000
       100210ac 00000003 d7b1ce27 cc670e74 c01f5a97 d7b18b60 00000020 d7b18b60
Call Trace: [<c020abbb>] [<c01f5a97>] [<c01f5e11>] [<c01eb70e>] [<c011ac2c>] [<c010a9b5>] [<c01090ec>]
       [<c0116f82>] [<c01bd0eb>] [<c01bc2ad>] [<c017fd31>] [<c011afac>] [<c01341bd>] [<c0135539>] [<c01536aa>]
       [<c0147d95>] [<c0147ff9>] [<c015447b>] [<c013ec6d>] [<c013ecff>] [<c016b15b>] [<c0168e6c>] [<c01687e3>]
       [<c0224f55>] [<c016860d>] [<c01075a4>]
Code: 8b 48 04 8b 1b 8b 01 85 45 fc 74 6a 31 c0 9c 5e fa f0 fe 0d

>>EIP; c011484a <__wake_up+3e/cc>   <=====
Trace; c020abbb <tcp_v4_rcv+297/574>
Trace; c01f5a97 <ip_local_deliver+ab/13c>
Trace; c01f5e11 <ip_rcv+2e9/388>
Trace; c01eb70e <net_rx_action+172/274>
Trace; c011ac2c <do_softirq+5c/8c>
Trace; c010a9b5 <do_IRQ+e5/f4>
Trace; c01090ec <ret_from_intr+0/20>
Trace; c0116f82 <printk+15a/17c>
Trace; c01bd0eb <scsi_init_io_vc+10b/134>
Trace; c01bc2ad <scsi_request_fn+241/334>
Trace; c017fd31 <generic_unplug_device+2d/3c>
Trace; c011afac <__run_task_queue+60/74>
Trace; c01341bd <__wait_on_buffer+5d/94>
Trace; c0135539 <bread+45/64>
Trace; c01536aa <ext2_read_inode+10a/3c4>
Trace; c0147d95 <get_new_inode+e1/174>
Trace; c0147ff9 <iget4+d5/e0>
Trace; c015447b <ext2_lookup+5f/8c>
Trace; c013ec6d <lookup_hash+9d/f0>
Trace; c013ecff <lookup_one+3f/50>
Trace; c016b15b <nfsd_lookup+3cb/528>
Trace; c0168e6c <nfsd_proc_lookup+8c/a0>
Trace; c01687e3 <nfsd_dispatch+cb/168>
Trace; c0224f55 <svc_process+28d/4c8>
Trace; c016860d <nfsd+215/320>
Trace; c01075a4 <kernel_thread+28/38>
Code;  c011484a <__wake_up+3e/cc>
00000000 <_EIP>:
Code;  c011484a <__wake_up+3e/cc>   <=====
   0:   8b 48 04                  mov    0x4(%eax),%ecx   <=====
Code;  c011484d <__wake_up+41/cc>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c011484f <__wake_up+43/cc>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0114851 <__wake_up+45/cc>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0114854 <__wake_up+48/cc>
   a:   74 6a                     je     76 <_EIP+0x76> c01148c0 <__wake_up+b4/cc>
Code;  c0114856 <__wake_up+4a/cc>
   c:   31 c0                     xor    %eax,%eax
Code;  c0114858 <__wake_up+4c/cc>
   e:   9c                        pushf  
Code;  c0114859 <__wake_up+4d/cc>
   f:   5e                        pop    %esi
Code;  c011485a <__wake_up+4e/cc>
  10:   fa                        cli    
Code;  c011485b <__wake_up+4f/cc>
  11:   f0 fe 0d 00 00 00 00      lock decb 0x0

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.





CPUINFO
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.031
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 897.84

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.031
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 901.12



TOP
  4:12am  up 1 day, 11:39,  3 users,  load average: 10.69, 11.49, 11.66
460 processes: 458 sleeping, 1 running, 0 zombie, 1 stopped
CPU states:  7.6% user, 17.4% system,  0.0% nice, 174.6% idle
CPU0 states:  4.1% user,  8.4% system,  0.0% nice, 86.4% idle
CPU1 states:  3.2% user,  8.2% system,  0.0% nice, 88.0% idle
Mem:   513104K av,  508720K used,    4384K free,       0K shrd,   54020K buff
Swap:  130748K av,       0K used,  130748K free                   62104K cached

  PID USER     PRI  NI  SIZE  RSS SHARE LC STAT %CPU %MEM   TIME COMMAND
 1340 root      15   0  1256 1256   732  0 R     7.3  0.2 126:06 top
  420 root      18   0   580  580   456  1 S     3.4  0.1  95:56 ipstat
24500 qmailusr  11   0   400  400   328  1 S     1.5  0.0   0:00 qmail-pop3d
  364 root      11   0     0    0     0  0 SW    0.7  0.0   9:26 nfsd
  370 root      11   0     0    0     0  0 SW    0.7  0.0   9:27 nfsd
  609 root       0   0   604  604   516  1 S     0.7  0.1  12:29 tcpserver
23430 www       10   0  3008 3008  2792  1 S     0.7  0.5   0:00 httpd
23761 www        9   0  3028 3028  2784  1 S     0.7  0.5   0:00 httpd
24495 qmailusr  11   0   400  400   328  1 S     0.7  0.0   0:00 qmail-pop3d
24507 qmailusr  11   0   400  400   328  0 S     0.7  0.0   0:00 qmail-pop3d
24514 qmailusr  11   0   404  404   328  1 S     0.7  0.0   0:00 qmail-pop3d
  365 root      10   0     0    0     0  1 DW    0.3  0.0   9:28 nfsd
  368 root      10   0     0    0     0  1 SW    0.3  0.0   9:30 nfsd
  369 root      10   0     0    0     0  0 DW    0.3  0.0   9:27 nfsd
  371 root      10   0     0    0     0  1 DW    0.3  0.0   9:28 nfsd
  610 root      10   0   328  328   264  0 S     0.3  0.0   4:22 accustamp
16072 qmailusr   9   0  1884 1884   776  0 S     0.3  0.3   0:03 sqwebmail
18319 qmailusr   9   0   400  400   328  1 S     0.3  0.0   0:00 qmail-pop3d
22276 qmailusr   9   0  1620 1620   776  1 D     0.3  0.3   0:00 sqwebmail
22388 www        9   0  3008 3008  2792  1 S     0.3  0.5   0:00 httpd
22646 qmailusr   9   0  1564 1564   752  1 S     0.3  0.3   0:00 sqwebmail
22994 qmailusr   9   0   400  400   328  1 S     0.3  0.0   0:00 qmail-pop3d
23073 qmailusr   9   0  1412 1412   740  1 S     0.3  0.2   0:00 sqwebmail
23095 qmailusr   9   0   400  400   328  0 S     0.3  0.0   0:00 qmail-pop3d
