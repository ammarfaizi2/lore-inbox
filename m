Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319090AbSHSWuT>; Mon, 19 Aug 2002 18:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319091AbSHSWuT>; Mon, 19 Aug 2002 18:50:19 -0400
Received: from host.greatconnect.com ([209.239.40.135]:39697 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319090AbSHSWuQ>; Mon, 19 Aug 2002 18:50:16 -0400
Subject: 2.4.20-pre2-ac4 oops at boot
From: Samuel Flory <sflory@rackable.com>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 15:53:40 -0700
Message-Id: <1029797620.5308.73.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've been having problem with the ac kernels, and tyan 2720. (Dual
xeon E7500 chipset.) Under 2.4.20-pre2-ac4 it spews a bunch of "Trying
to free nonexistent resource" when initializing the ide interface, and
dies.  Under 2.4.19-ac4 the system netboots, but oops when I attempt to
create a filesystem on a 3ware controller.  Under 2.4.19 the system
boot, and seems to function fine. (No dma support on the ide interface,
however.)


I believe the ide chipset is a ICH3.

>From 2.4.19:
ICH3: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: (ide_setup_pci_device:) Could not enable device.


2.4.20-pre2-ac4:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <0000ffa0-0000ffaf>
Trying to free nonexistent resource <40000000-400003ff>
hda: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Unable to handle kernel NULL pointer dereference at virtual address
00000000


ksymoops 2.4.4 on i686 2.4.20-pre2-ac3.  Options used
     -v /stuff/src/linux-2.4.20-pre2-ac4/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.20-pre2-ac4 (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000000
c01fc963
*pde = 00104001
Oops: 0000
CPU:    0
EIP:    0010:[<c01fc963>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: f7ed2ca0   ebx: 00000000   ecx: 00000077   edx: f7ed2ca0
esi: c034d380   edi: c0445cac   ebp: 0004e000   esp: c1e13f88
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1e13000)
Stack: 00000001 00000001 00000001 00000001 00000001 00000001 00000009
c0445820
       00000009 c0445820 c03a4b5f c03a4bc4 c03bc14c c0391fc0 c0441c3c
c03a2ff1
       c0391fc0 c0105000 c03a3005 c03927a2 c1e12000 c0105078 00010f00
c0391fc0
Call Trace:    [<c0105000>] [<c0105078>] [<c0105000>] [<c0107256>]
[<c0105050>]
Code: 8b 13 85 d2 74 55 80 7b 04 00 74 4f 8b 43 08 85 c0 74 48 8d

>>EIP; c01fc963 <proc_ide_create+53/c0>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c0105078 <init+28/190>
Trace; c0105000 <_stext+0/0>
Trace; c0107256 <kernel_thread+26/30>
Trace; c0105050 <init+0/190>
Code;  c01fc963 <proc_ide_create+53/c0>
00000000 <_EIP>:
Code;  c01fc963 <proc_ide_create+53/c0>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c01fc965 <proc_ide_create+55/c0>
   2:   85 d2                     test   %edx,%edx
Code;  c01fc967 <proc_ide_create+57/c0>
   4:   74 55                     je     5b <_EIP+0x5b> c01fc9be
<proc_ide_create+ae/c0>
Code;  c01fc969 <proc_ide_create+59/c0>
   6:   80 7b 04 00               cmpb   $0x0,0x4(%ebx)
Code;  c01fc96d <proc_ide_create+5d/c0>
   a:   74 4f                     je     5b <_EIP+0x5b> c01fc9be
<proc_ide_create+ae/c0>
Code;  c01fc96f <proc_ide_create+5f/c0>
   c:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c01fc972 <proc_ide_create+62/c0>
   f:   85 c0                     test   %eax,%eax
Code;  c01fc974 <proc_ide_create+64/c0>
  11:   74 48                     je     5b <_EIP+0x5b> c01fc9be
<proc_ide_create+ae/c0>
Code;  c01fc976 <proc_ide_create+66/c0>
  13:   8d 00                     lea    (%eax),%eax

 <0>Kernel panic: Attempted to kill init!


2.4.19-ac4:
ksymoops 2.4.4 on i686 2.4.20-pre2-ac3.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.19-ac4 (specified)

CPU:    0
EIP:    0010:[<c011954a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00001340   ebx: 000000ff   ecx: 00000002   edx: 00000000
esi: 00000000   edi: 00000002   ebp: c1e25f94   esp: c1e25f5c
ds: 0018   es: 0018   ss: 0018
Process ksoftirqd_CPU0 (pid: 5, stackpage=c1e25000)
Stack: 00000008 c03be614 c03be6bc 00000078 c03be244 00000000 00000000
00000002
       c03b6800 f7ece360 f79bfee0 c03bd8a4 c03bd880 00000000 c1e25fd4
c0119d82
       c03bd880 00000001 00000000 00000008 f79bfee0 c1e24000 c1e24000
00000000
Call Trace:    [<c0119d82>] [<c01221eb>] [<c012276f>] [<c0107256>]
[<c01226c0>]
Code: 8b 42 14 c7 42 14 01 00 00 00 85 c0 75 16 8b 52 20 b8 00 e0

>>EIP; c011954a <load_balance+da/490>   <=====
Trace; c0119d82 <schedule+122/3c0>
Trace; c01221eb <do_softirq+6b/d0>
Trace; c012276f <ksoftirqd+af/100>
Trace; c0107256 <kernel_thread+26/30>
Trace; c01226c0 <ksoftirqd+0/100>
Code;  c011954a <load_balance+da/490>
00000000 <_EIP>:
Code;  c011954a <load_balance+da/490>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c011954d <load_balance+dd/490>
   3:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
Code;  c0119554 <load_balance+e4/490>
   a:   85 c0                     test   %eax,%eax
Code;  c0119556 <load_balance+e6/490>
   c:   75 16                     jne    24 <_EIP+0x24> c011956e
<load_balance+fe/490>
Code;  c0119558 <load_balance+e8/490>
   e:   8b 52 20                  mov    0x20(%edx),%edx
Code;  c011955b <load_balance+eb/490>
  11:   b8 00 e0 00 00            mov    $0xe000,%eax


