Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSHWI2C>; Fri, 23 Aug 2002 04:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSHWI2C>; Fri, 23 Aug 2002 04:28:02 -0400
Received: from smtp01.web.de ([194.45.170.210]:13069 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318714AbSHWI16>;
	Fri, 23 Aug 2002 04:27:58 -0400
Date: Fri, 23 Aug 2002 10:33:18 +0200
From: Andreas Romeyke <fa.romeyke@web.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19: possible kernel bug by accessing CD/ISO
Message-Id: <20020823103318.758340c1.fa.romeyke@web.de>
Organization: free user
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.9j_apZCJ/(9Mir"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.9j_apZCJ/(9Mir
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

On Kernel 2.4.19 I can reproduce a possible kernelbug. If I read
extensively from a mounted CDROM or DVD (IDE with generic
SCSI-Emulation), or an ISO-Image there will be a kernel-oops. User-space
programs are not the source, because the error exists if I used tar, cp
or
mc. There is no special file or dir where the oops will be generated.
The oops needs 0.000x up to 2 seconds of access, sometimes meanly all
files and dirs could be accessed, or there is an oops by reading
main-directory of CDR.

The ISO-Image was created by xcdroast 0.98alpha10 with mkisofs 1.14
and cdrecord 1.10 under linux 2.4.19 (official tree without additional
patches) and contains only a normal dir-structure, pE. Linux-sources).

The extraction of the ISO-Image via dd or xcdroast produces no error,
but the
extracted image mounted via loopback or roasted on a new cdr is not
accessable. The error exists also, if the CDR is mounted or extracted
via
DVD-drive.

The same CDR and the same ISO-Image can be mounted and accessed via cp,
tar and Co. under linux 2.2.19 without problems. There is also no
problem under other OS.
Isovfy means the ISO-image is ok. 
Memtest86 reports no errors on RAM (test 1-4).

Other ISOs or CDRs were tested, with any CDRs (other types roasted with
other CDR-drives) the problem is reproduceable. All my tested CDRs used
Rock Ridge or Joliet Extensions.

Hope that helps,

Bye Andreas

PS.: next lines: hardware, /proc/pci, ksymoops-report

----------------------------------------------------

Here my hardware:

AMD K6-II 450
192 MB SDRAM
CD-RW BCE2410IM
LITEON DVD-ROM LTD163D
FIC Mainboard (VIA MVP3+)

----------------------------------------------------

Here the lines from `cat /proc/pci`:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe400 [0xe40f].
  Bus  0, device   7, function  3:
    PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
      IRQ 9.
  Bus  0, device   8, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C
(rev 16).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xea000000 [0xea0000ff].
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 18).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xea001000 [0xea001fff].
  Bus  0, device  10, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 8).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xec00 [0xec3f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
4).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xe8000000 [0xe9ffffff].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4003fff].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe57fffff].
------------------------------------------------------

ksymoops 2.4.5 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Error (regular_file): read_system_map stat /boot/System.map-2.4.19
failed
8139too Fast Ethernet driver 0.9.25
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A
rev A)
Unable to handle kernel paging request at virtual address 80272ab8
c013955c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013955c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c013955c   ebx: 00000000   ecx: c6263e00   edx: 40000001
esi: c6263e00   edi: ca971fa4   ebp: 00000fff   esp: ca971f80
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 696, stackpage=ca971000)
Stack: c0134675 c7f3e340 bfffe8fc 00000fff c6263e00 ca970000 080fa578
08108c20 
       bfffe87c c7f3e340 c12164e0 ca970000 080fa578 00000026 00000008
00000001 
       c0108593 08108c20 bfffe8fc 00000fff 080fa578 08108c20 bfffe87c
00000055 
Call Trace:    [<c0134675>] [<c0108593>]
Code: 83 2c 00 04 57 56 53 8b 5c 24 14 8b 7c 24 18 8b 74 24 1c c7 


>>EIP; c013955c <page_readlink+0/4c>   <=====

>>eax; c013955c <page_readlink+0/4c>
>>ecx; c6263e00 <END_OF_CODE+5f045c8/????>
>>edx; 40000001 Before first symbol
>>esi; c6263e00 <END_OF_CODE+5f045c8/????>
>>edi; ca971fa4 <END_OF_CODE+a61276c/????>
>>ebp; 00000fff Before first symbol
>>esp; ca971f80 <END_OF_CODE+a612748/????>

Trace; c0134675 <cdput+5cd/868>
Trace; c0108593 <__up_wakeup+102f/2324>

Code;  c013955c <page_readlink+0/4c>
00000000 <_EIP>:
Code;  c013955c <page_readlink+0/4c>   <=====
   0:   83 2c 00 04               subl   $0x4,(%eax,%eax,1)   <=====
Code;  c0139560 <page_readlink+4/4c>
   4:   57                        push   %edi
Code;  c0139561 <page_readlink+5/4c>
   5:   56                        push   %esi
Code;  c0139562 <page_readlink+6/4c>
   6:   53                        push   %ebx
Code;  c0139563 <page_readlink+7/4c>
   7:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c0139567 <page_readlink+b/4c>
   b:   8b 7c 24 18               mov    0x18(%esp,1),%edi
Code;  c013956b <page_readlink+f/4c>
   f:   8b 74 24 1c               mov    0x1c(%esp,1),%esi
Code;  c013956f <page_readlink+13/4c>
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)


2 warnings and 1 error issued.  Results may not be reliable.

--=.9j_apZCJ/(9Mir
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE9ZfNUClxplZklbgERAs/5AJ0XJco/9btHI/07F2hOR/YC/N41mQCfZ0J2
WdJeLJ5qJyDV/ggiuZdvtxM=
=rtXu
-----END PGP SIGNATURE-----

--=.9j_apZCJ/(9Mir--

