Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbRGQCZh>; Mon, 16 Jul 2001 22:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbRGQCZ1>; Mon, 16 Jul 2001 22:25:27 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:44016 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S267419AbRGQCZY>; Mon, 16 Jul 2001 22:25:24 -0400
Date: Mon, 16 Jul 2001 21:35:34 -0500
From: Andrew Friedley <saai@swbell.net>
Subject: kernel panic problem. (smp, iptables?)
To: linux-kernel@vger.kernel.org
Message-id: <005f01c10e69$28273e60$0200a8c0@loki>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry if this posts in HTML.
Some background information on my system.

Tyan S1863D (Tomcat IIID) motherboard, dual socket 7.
  128mb 60ns EDO ram (8x16mb)
  Dual Pentium 200mhz processors, non-mmx.
  PIIX3 IDE Controller, onboard
    Single 1.2gb drive on each of the two channels.
  Advansys ISA SCSI Controller
    Seagate SCSI HD, 9.1gb (Ultra Wide? not sure)
  NE2000 Compatible ISA 10mbit ethernet nic IRQ 11 IO 0x300
  Kingston KNE100TX PCI 100mbit fast ethernet nic, (uses tulip.o) IRQ 12 IO
0x6400

I am running a custom built linux system using linuxfromscratch, everything
except the kernel was compiled -O3 -march=i586.  I am running kernel 2.4.6,
glibc 2.2.1, gcc 2.95.3, iptables 1.2.2.  The NE2000 nic connects to my DSL
modem (swbell is my ISP) and the KNE100TX connects to my 100mbit switched
lan.  The first IDE drive contains a small ext2 /boot partition, a swap
partition, and a linux raid autodetect partition.  The second IDE drive has
a swap partition and a linux raid autodetect partition exactly the same size
as the partition on the first drive.  These two partitions are configured
for software RAID0, with a reiserfs filesystem and mounted on /.  The scsi
drive has a reiserfs and a swap partition. The reiserfs partition is mounted
on /home and exported to other linux systems on the lan via knfsd, using
nfsv3 support.  There are no other directories or filesystems exported.  The
kernel has SMP, software raid0, iptables, pppoe, nfs, reiserfs, ext2, and
all drivers except floppy.o compiled in.  My .config file I use for 2.4.6
can be found here:  http://saai.dyn.dhs.org/kernel-2.4.6.config.  As far as
software running on the system, I have named, pppd (the patched version for
pppoe support), rpc.portmap, rpc.nfsd, rpc.mountd, apache, and mysql along
with telnet, rsh and proftpd running through inetd.  As far as usage of the
system goes, I have its /home export mounted as /home on my other two linux
systems (all linuxfromscratch, same version software), I play mp3's residing
on the /home mount over nfs in linux, and via Apache using Winamp in
windows.  This system acts as router for my lan, connected to an ADSL modem.

My problem is, that I seem to be having "random" kernel panics.  When I say
random I mean that the system will run 30 minutes before it panics, or as
long as a week before it panics.  System load and type of load does not seem
to matter, the system will panic in the middle of the night when there is
little/no cpu/network activity, or during very heavy multiuser cpu and
network usage -- it does not seem to matter.  Always, the panic is pretty
much the same, occuring in the Process swapper.  I believe that the problem
is related to iptables.  I have a windows 98SE machine on my lan, that
accesses the internet though this linux system acting as a router.  If I try
to connect to a server using Napster/Napigator on the windows box through
the linux router box I am having problems with, the system always panics.
When I used a 2.4.4 kernel with the reiserfs-nfs patch the system would
panic when I tried to check my email using Outlook Express 5.0 on the
windows box on my lan. Outlook no longer causes a panic, but rather
Napster/Napigator.

Below is the panic output, captured by setting the system console to a
serial port and using hyperterm on my windows box via a 115200kbps serial
link:

 Unable to handle kernel paging request at virtual address 0000d7c5
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01d6fc3>]
EFLAGS: 00010206
eax: c166ae00   ebx: 0000d7c5   ecx: 00000000   edx: 0000d7c5
esi: c7b28b40   edi: c166aba0   ebp: 00000060   esp: c1253d8c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c1253000)
Stack: fffffe00 c01d706b c7b28b40 fffffe00 c7b28b40 c01d7653 c7b28b40
c12ad800
       c7b28b40 0000000e c7b28b40 ffffffe6 c01da0f7 c7b28b40 00000020
00000004
       c7058f40 0000000e c01ddfed c7b28b40 00000001 00000000 c7b28b40
c01e7ea0
Call Trace: [<c01d706b>] [<c01d7653>] [<c01da0f7>] [<c01ddfed>] [<c01e7ea0>]
[<c01e7f60>] [<c01df228>]
       [<c01e5450>] [<c01e7e83>] [<c01e7ea0>] [<c01e54aa>] [<c01df228>]
[<c01e05dc>] [<c01e53e4>] [<c01e5450>]
       [<c01e4488>] [<c01e462a>] [<c01e4488>] [<c01df228>] [<c01e42c7>]
[<c01e4488>] [<c01da8ce>] [<c0116c8a>]
       [<c0108680>] [<c0105180>] [<c0106d40>] [<c0105180>] [<c01051ac>]
[<c0105212>] [<c0108680>] [<c0220d4a>]
       [<c019d05f>]

Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0 74
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


Like I stated before, it is always the Process swapper.  This panic was
caused by using Napster/Napigator, as opposed to a seemingly random panic.
I took the above panic output and pasted it into ksymoops:

>>EIP; c01d6fc3 <skb_drop_fraglist+17/3c>   <=====
Trace; c01d706b <skb_release_data+5f/74>
Trace; c01d7653 <skb_linearize+cf/130>
Trace; c01da0f7 <dev_queue_xmit+27/2e8>
Trace; c01ddfed <neigh_resolve_output+1cd/240>
Trace; c01e7ea0 <ip_finish_output2+0/f8>
Trace; c01e7f60 <ip_finish_output2+c0/f8>
Trace; c01df228 <nf_hook_slow+110/194>
Trace; c01e5450 <ip_forward_finish+0/60>
Trace; c01e7e83 <ip_finish_output+127/130>
Trace; c01e7ea0 <ip_finish_output2+0/f8>
Trace; c01e54aa <ip_forward_finish+5a/60>
Trace; c01df228 <nf_hook_slow+110/194>
Trace; c01e05dc <rt_check_expire__thr+154/184>
Trace; c01e53e4 <ip_forward+1b4/220>
Trace; c01e5450 <ip_forward_finish+0/60>
Trace; c01e4488 <ip_rcv_finish+0/1e8>
Trace; c01e462a <ip_rcv_finish+1a2/1e8>
Trace; c01e4488 <ip_rcv_finish+0/1e8>
Trace; c01df228 <nf_hook_slow+110/194>
Trace; c01e42c7 <ip_rcv+367/3b0>
Trace; c01e4488 <ip_rcv_finish+0/1e8>
Trace; c01da8ce <net_rx_action+16a/274>
Trace; c0116c8a <do_softirq+5a/88>
Trace; c0108680 <do_IRQ+e0/f0>
Trace; c0105180 <default_idle+0/34>
Trace; c0106d40 <ret_from_intr+0/7>
Trace; c0105180 <default_idle+0/34>
Trace; c01051ac <default_idle+2c/34>
Trace; c0105212 <cpu_idle+3e/54>
Trace; c0108680 <do_IRQ+e0/f0>
Trace; c0220d4a <vsprintf+31e/34c>
Trace; c019d05f <serial_console_write+2b/194>
Code;  c01d6fc3 <skb_drop_fraglist+17/3c>
00000000 <_EIP>:
Code;  c01d6fc3 <skb_drop_fraglist+17/3c>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01d6fc5 <skb_drop_fraglist+19/3c>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01d6fc8 <skb_drop_fraglist+1c/3c>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01d6fcb <skb_drop_fraglist+1f/3c>
   8:   74 0b                     je     15 <_EIP+0x15> c01d6fd8
<skb_drop_fraglist+2c/3c>
Code;  c01d6fcd <skb_drop_fraglist+21/3c>
   a:   f0 ff 4a 70               lock decl 0x70(%edx)
Code;  c01d6fd1 <skb_drop_fraglist+25/3c>
   e:   0f 94 c0                  sete   %al
Code;  c01d6fd4 <skb_drop_fraglist+28/3c>
  11:   84 c0                     test   %al,%al
Code;  c01d6fd6 <skb_drop_fraglist+2a/3c>
  13:   74 00                     je     15 <_EIP+0x15> c01d6fd8
<skb_drop_fraglist+2c/3c>

Kernel panic: Aiee, killing interrupt handler!


Which, by my limited understanding, seems to indicate iptables/softirq or
smp.  My obvious question is, is this a bug? Is there a fix for it?  I have
had this problem since kernel 2.4.3, when I first set this machine up as a
router.  Below are some links with more information that might be useful,
and if theres anything else I can provide please ask.

dmesg output from bootup: http://saai.dyn.dhs.org/dmesg.txt
ifconfig & route output and iptables config:
http://saai.dyn.dhs.org/network.txt
kernel 2.4.6 .config file: http://saai.dyn.dhs.org/kernel-2.4.6.config
panic and ksymoops output: http://saai.dyn.dhs.org/panic.txt
packages installed on my linux systems: http://saai.dyn.dhs.org/packages/
  (In case you would like to know version numbers of any other software I
have)

