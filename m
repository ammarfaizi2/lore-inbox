Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLaP23>; Tue, 31 Dec 2002 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLaP22>; Tue, 31 Dec 2002 10:28:28 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:13801 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263143AbSLaP20>; Tue, 31 Dec 2002 10:28:26 -0500
Message-ID: <3E11B976.3010306@iku-ag.de>
Date: Tue, 31 Dec 2002 16:36:22 +0100
From: Kurt Huwig <k.huwig@iku-ag.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ronsse@elis.rug.ac.be
Subject: Oops with 2.4.20 when accessing SVCDs
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080607080107010503080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607080107010503080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got the attached oops when copying a file from a SVCD using cdfs-0.5c

I mounted a SVCD using

	mount -t cdfs /dev/cdbrenner /cdbrenner

using the cdfs driver from

	http://www.elis.rug.ac.be/~ronsse/cdfs/cdfs.html

and then copied one of the files on the CD with

	cp /cdbrenner/videocd-1.mpeg ~/film.mpg

after some time (copied file size is 168996864 bytes while original file 
size is 820799616), the oops happened.

Kernels is a self compiled vanilla:

Linux version 2.4.20 (root@Knoppix) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #1 Tue Dec 31 15:23:18 CET 2002

Target filesystem is ReiserFS, but it happened with Ext3 as well (just 
switched to ReiserFS to make sure it isn't the Ext3 code).

The CD-ROM is an ATAPI-CD-writer

lobo:~# cat /proc/ide/hdc/model
HL-DT-ST GCE-8320B

using 'ide-scsi':

lobo:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: HL-DT-ST Model: CD-RW GCE-8320B  Rev: 1.04
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: MT1316B  Model: BDV212B          Rev: 0p40
   Type:   CD-ROM                           ANSI SCSI revision: 02

lobo:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 2100+
stepping        : 2
cpu MHz         : 1735.486
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3460.30

This is my current list of modules but I did only do a reboot. The 
'tainted' comes from the nVidia driver, but it wasn't loaded when the 
oops appeared, i.e. the kernel was not tainted at this time. Also there 
was no ppp module etc.

lobo:~# lsmod
Module                  Size  Used by    Tainted: P
sr_mod                 12248   2  (autoclean)
cdrom                  29312   0  (autoclean) [sr_mod]
cdfs                   13860   2  (autoclean)
ppp_deflate             3008   0  (autoclean)
zlib_deflate           17984   0  (autoclean) [ppp_deflate]
bsd_comp                4032   0  (autoclean)
ppp_async               6592   1  (autoclean)
af_packet              12040   2  (autoclean)
agpgart                16128   3  (autoclean)
NVdriver              945888  10  (autoclean)
parport_pc             21384   1  (autoclean)
lp                      6592   0  (autoclean)
parport                24992   1  (autoclean) [parport_pc lp]
ppp_generic            20236   3  (autoclean) [ppp_deflate bsd_comp 
ppp_async]
slhc                    4704   0  (autoclean) [ppp_generic]
8139too                15520   1  (autoclean)
mii                     2320   0  (autoclean) [8139too]
ehci-hcd               14656   0  (unused)
cmpci                  30388   1
soundcore               3684   4  [cmpci]
ide-scsi                7744   1
scsi_mod               88808   2  [sr_mod ide-scsi]
usbmouse                1856   0  (unused)
mousedev                3904   1
keybdev                 1696   0  (unused)
usbkbd                  2944   0  (unused)
input                   3424   0  [usbmouse mousedev keybdev usbkbd]
usb-uhci               21796   0  (unused)
usbcore                56032   1  [ehci-hcd usbmouse usbkbd usb-uhci]
rtc                     6012   0  (autoclean)
unix                   13892 106  (autoclean)

Any help would be appreciated.

And a happy new year!

Kurt

--------------080607080107010503080300
Content-Type: text/plain;
 name="oops.ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.ksymoops"

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k ksymoops/20021231154911.ksyms (specified)
     -l ksymoops/20021231154911.modules (specified)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Dec 31 15:51:57 lobo kernel: c012d8d4
Dec 31 15:51:57 lobo kernel: Oops: 0002
Dec 31 15:51:57 lobo kernel: CPU:    0
Dec 31 15:51:57 lobo kernel: EIP:    0010:[kmem_cache_alloc+148/224]    Not tainted
Dec 31 15:51:57 lobo kernel: EFLAGS: 00010046
Dec 31 15:51:57 lobo kernel: eax: 3939525f   ebx: c6df8240   ecx: c6df8000   edx: 3e2a5ed0
Dec 31 15:51:57 lobo kernel: esi: cfec0e50   edi: 00000246   ebp: 000000f0   esp: cd98fe78
Dec 31 15:51:57 lobo kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:51:57 lobo kernel: Process cp (pid: 284, stackpage=cd98f000)
Dec 31 15:51:57 lobo kernel: Stack: 00000000 00000000 00001000 00000001 c0136e33 cfec0e50 000000f0 c0136efd 
Dec 31 15:51:57 lobo kernel:        00000001 c112e244 00000302 c112e244 cfe13d30 c0137127 c112e244 00001000 
Dec 31 15:51:57 lobo kernel:        00000001 00000000 c112e244 c01373c8 c112e244 00000302 00001000 00000000 
Dec 31 15:51:57 lobo kernel: Call Trace:    [get_unused_buffer_head+51/128] [create_buffers+29/224] [create_empty_buffers+23/96] [__block_prepare_write+120/720] [journal_end+22/32]
Dec 31 15:51:57 lobo kernel: Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 06 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 3939525f Before first symbol
>>ebx; c6df8240 <_end+6af40e4/105c3ea4>
>>ecx; c6df8000 <_end+6af3ea4/105c3ea4>
>>edx; 3e2a5ed0 Before first symbol
>>esi; cfec0e50 <_end+fbbccf4/105c3ea4>
>>esp; cd98fe78 <_end+d68bd1c/105c3ea4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 42 04                  mov    %eax,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 10                     mov    %edx,(%eax)
Code;  00000005 Before first symbol
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  0000000b Before first symbol
   b:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  00000012 Before first symbol
  12:   8b 06                     mov    (%esi),%eax


--------------080607080107010503080300--

