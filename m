Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVAFSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVAFSDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVAFR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:57:53 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:13954 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S262931AbVAFRxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:53:02 -0500
Date: Thu, 6 Jan 2005 09:53:00 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: opps 2.6.10-mm2
Message-ID: <20050106175300.GA3845@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10-mm2n on an i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I get this oops just as X loads. it happens repeatedly, and reliably.

As allways I more then happy to supply additional information, or test
patches.


ksymoops 2.4.9 on i686 2.6.10-mm2n.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-mm2n/ (default)
     -m /boot/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000004
f999b8a8
*pde = 36c35067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f999b8a8>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246   (2.6.10-mm2n) 
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: f70b4fc0   edi: 00000000   ebp: f70b40c0   esp: f6c17f1c
ds: 007b   es: 007b   ss: 0068
Stack: bffffb10 c0215a74 00000000 f7c73000 f7457940 f99d8e2c f99d8caf 00800000 
       00000001 00000000 00000001 00000000 f7c73000 00000036 f99d8da0 f99d4c15 
       bffffb10 00000003 f6c17f7c f79e4280 f7261060 f7383640 c03ab740 40086436 
Call Trace:
 [<c0215a74>] copy_from_user+0x34/0x80
 [<f99d8e2c>] drm_agp_bind+0x8c/0xe0 [drm]
 [<f99d8caf>] drm_agp_alloc+0x10f/0x160 [drm]
 [<f99d8da0>] drm_agp_bind+0x0/0xe0 [drm]
 [<f99d4c15>] drm_ioctl+0xe5/0x1ab [drm]
 [<f99d4b30>] drm_ioctl+0x0/0x1ab [drm]
 [<c0157050>] do_ioctl+0x50/0x60
 [<c015720e>] sys_ioctl+0x6e/0x1e0
 [<c010236f>] syscall_call+0x7/0xb
Code: 20 89 fa 8b 58 04 89 f0 ff 53 40 85 c0 75 09 c6 46 28 01 89 7e 1c 31 c0 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8b 46 08 <8b> 40 04 ff 50 34 c6 46 29 01 eb c4 89 74 24 0
Error (Oops_code_values): invalid value 0x0 in Code line, must be 2, 4, 8 or 16 digits, value ignored


>>EIP; f999b8a8 <acqseq_lock.5+39517500/3fb78c58>   <=====

>>esi; f70b4fc0 <acqseq_lock.5+36c30c18/3fb78c58>
>>ebp; f70b40c0 <acqseq_lock.5+36c2fd18/3fb78c58>
>>esp; f6c17f1c <acqseq_lock.5+36793b74/3fb78c58>

Trace; c0215a74 <_pagebuf_initialize+64/e0>
Trace; f99d8e2c <acqseq_lock.5+39554a84/3fb78c58>
Trace; f99d8caf <acqseq_lock.5+39554907/3fb78c58>
Trace; f99d8da0 <acqseq_lock.5+395549f8/3fb78c58>
Trace; f99d4c15 <acqseq_lock.5+3955086d/3fb78c58>
Trace; f99d4b30 <acqseq_lock.5+39550788/3fb78c58>
Trace; c0157050 <do_open+150/340>
Trace; c015720e <do_open+30e/340>
Trace; c010236f <pg0+36f/1000>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  f999b87d <acqseq_lock.5+395174d5/3fb78c58>
00000000 <_EIP>:
Code;  f999b87d <acqseq_lock.5+395174d5/3fb78c58>
   0:   20 89 fa 8b 58 04         and    %cl,0x4588bfa(%ecx)
Code;  f999b883 <acqseq_lock.5+395174db/3fb78c58>
   6:   89 f0                     mov    %esi,%eax
Code;  f999b885 <acqseq_lock.5+395174dd/3fb78c58>
   8:   ff 53 40                  call   *0x40(%ebx)
Code;  f999b888 <acqseq_lock.5+395174e0/3fb78c58>
   b:   85 c0                     test   %eax,%eax
Code;  f999b88a <acqseq_lock.5+395174e2/3fb78c58>
   d:   75 09                     jne    18 <_EIP+0x18>
Code;  f999b88c <acqseq_lock.5+395174e4/3fb78c58>
   f:   c6 46 28 01               movb   $0x1,0x28(%esi)
Code;  f999b890 <acqseq_lock.5+395174e8/3fb78c58>
  13:   89 7e 1c                  mov    %edi,0x1c(%esi)
Code;  f999b893 <acqseq_lock.5+395174eb/3fb78c58>
  16:   31 c0                     xor    %eax,%eax
Code;  f999b895 <acqseq_lock.5+395174ed/3fb78c58>
  18:   8b 5c 24 08               mov    0x8(%esp),%ebx
Code;  f999b899 <acqseq_lock.5+395174f1/3fb78c58>
  1c:   8b 74 24 0c               mov    0xc(%esp),%esi
Code;  f999b89d <acqseq_lock.5+395174f5/3fb78c58>
  20:   8b 7c 24 10               mov    0x10(%esp),%edi
Code;  f999b8a1 <acqseq_lock.5+395174f9/3fb78c58>
  24:   83 c4 14                  add    $0x14,%esp
Code;  f999b8a4 <acqseq_lock.5+395174fc/3fb78c58>
  27:   c3                        ret    
Code;  f999b8a5 <acqseq_lock.5+395174fd/3fb78c58>
  28:   8b 46 08                  mov    0x8(%esi),%eax

This decode from eip onwards should be reliable

Code;  f999b8a8 <acqseq_lock.5+39517500/3fb78c58>
00000000 <_EIP>:
Code;  f999b8a8 <acqseq_lock.5+39517500/3fb78c58>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  f999b8ab <acqseq_lock.5+39517503/3fb78c58>
   3:   ff 50 34                  call   *0x34(%eax)
Code;  f999b8ae <acqseq_lock.5+39517506/3fb78c58>
   6:   c6 46 29 01               movb   $0x1,0x29(%esi)
Code;  f999b8b2 <acqseq_lock.5+3951750a/3fb78c58>
   a:   eb c4                     jmp    ffffffd0 <_EIP+0xffffffd0>
Code;  f999b8b4 <acqseq_lock.5+3951750c/3fb78c58>
   c:   89 74 24 00               mov    %esi,0x0(%esp)
Code;  f999b8b8 <acqseq_lock.5+39517510/3fb78c58>
  10:   00 00                     add    %al,(%eax)
Code;  f999b8ba <acqseq_lock.5+39517512/3fb78c58>
  12:   00 00                     add    %al,(%eax)


2 errors issued.  Results may not be reliable.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.6.10-mm2n #8 Thu Jan 6 09:23:52 PST 2005 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         binfmt_misc ipv6 snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi ehci_hcd uhci_hcd ohci1394 ieee1394 tun nls_iso8859_15 nls_utf8 nls_iso8859_1 nls_cp437 nls_cp950 radeon drm amd64_agp agpgart sg sr_mod ide_scsi ide_cd cdrom via82cxxx ide_core sk98lin mii
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 12
model name	: AMD Athlon(tm) 64 Processor 3200+
stepping	: 0
cpu MHz		: 2255.038
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 4423.68


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


