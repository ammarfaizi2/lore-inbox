Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317764AbSGVToI>; Mon, 22 Jul 2002 15:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317761AbSGVToI>; Mon, 22 Jul 2002 15:44:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1447 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317764AbSGVTn5>;
	Mon, 22 Jul 2002 15:43:57 -0400
Subject: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="=-XB+YNemAQPiyzzpKCfWX"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jul 2002 14:34:27 -0500
Message-Id: <1027366468.5170.26.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XB+YNemAQPiyzzpKCfWX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Encountered this first with Linux-2.5.25+rmap and it looks like the
problem also slipped into 2.5.27.  The same machine boots fine with a
vanilla 2.5.25 or 2.5.26, but gets this on boot with rmap.  The machine
is an 8-way PIII-700.

# free
             total       used       free     shared    buffers    
cached
Mem:       3871360     464796    3406564          0     110280    
110356
-/+ buffers/cache:     244160    3627200
Swap:     15719284          0   15719284

-Paul Larson


--=-XB+YNemAQPiyzzpKCfWX
Content-Disposition: attachment; filename=oops.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=oops.out; charset=ISO-8859-1

ksymoops 2.4.4 on i686 2.4.18-3smp.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.5.27/System.map (specified)

15488MB HIGHMEM available.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.=
org if you experience SMP problems!
cpu: 0, clocks: 99984, slice: 3029
cpu: 7, clocks: 99984, slice: 3029
cpu: 5, clocks: 99984, slice: 3029
cpu: 6, clocks: 99984, slice: 3029
cpu: 3, clocks: 99984, slice: 3029
cpu: 4, clocks: 99984, slice: 3029
cpu: 1, clocks: 99984, slice: 3029
cpu: 2, clocks: 99984, slice: 3029
ds: no socket drivers loaded!
kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132a0a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: cbffcc08   ebx: c03cc2b0   ecx: cbffcc08   edx: fffe5638
esi: 00000058   edi: 00000000   ebp: cbffcc08   esp: f7545f10
ds: 0018   es: 0018   ss: 0018
Stack: cbffcc08 c0127930 c03cc140 f7951f50 bfffc000 00004000 f7564f80 00000=
000=20
       cbffcc08 c03cc2b0 00000058 00000106 cbffcc08 c012aa9c cbffcc08 00000=
001=20
       c011b068 00000000 f7545f70 f7952bc0 00000002 f79146e0 00000100 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c011b068>] [<c0116ea8>] [<c011bc34>=
]=20
   [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c011b068 <release_task+a8/b0>
Trace; c0116ea8 <mmput+48/70>
Trace; c011bc34 <do_exit+c4/2a0>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010282
eax: cbffbd98   ebx: c03cc2c0   ecx: cbffbd98   edx: fffe5638
esi: 0000005c   edi: 00000000   ebp: cbffbd98   esp: f7511c20
ds: 0018   es: 0018   ss: 0018
Stack: cbffbd98 c0127930 c03cc140 f7951ef0 bfffc000 00004000 f753b5a0 00000=
000=20
       cbffbd98 c03cc2c0 0000005c 00000125 cbffbd98 c012aa9c cbffbd98 f7966=
280=20
       f7511ca0 f7511c6c c012bfd0 f79529e0 f7510000 00000000 f79529e0 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c012bfd0>] [<c0116ea8>] [<c014479e>=
]=20
   [<c014495d>] [<c015ac26>] [<c0232293>] [<c0114f3b>] [<c0139de2>] [<c0144=
242>]=20
   [<c015a7c0>] [<c0144f5c>] [<c0145227>] [<c01463ee>] [<c0105bb0>] [<c0107=
00b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c012bfd0 <file_read_actor+0/f0>
Trace; c0116ea8 <mmput+48/70>
Trace; c014479e <exec_mmap+14e/170>
Trace; c014495d <flush_old_exec+9d/2d0>
Trace; c015ac26 <load_elf_binary+466/ad0>
Trace; c0232293 <scsi_dispatch_cmd+e3/180>
Trace; c0114f3b <schedule+33b/3a0>
Trace; c0139de2 <do_page_cache_readahead+f2/120>
Trace; c0144242 <copy_strings+1c2/240>
Trace; c015a7c0 <load_elf_binary+0/ad0>
Trace; c0144f5c <search_binary_handler+ac/1e0>
Trace; c0145227 <do_execve+197/240>
Trace; c01463ee <getname+5e/a0>
Trace; c0105bb0 <sys_execve+30/60>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

Setting clockernel BUG at page_alloc.c:98!
EFLAGS: 00010282
Stack: cbff9da0 c0127930 c03cc140 f7951f30 bfffc000 00004000 f75527e0 00000=
000=20
       cbff9da0 c03cc2c0 0000005c 00000128 cbff9da0 c012aa9c cbff9da0 f7966=
280=20
       f753fca0 f753fc6c c012bfd0 f7952b20 f753e000 00000000 f7952b20 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c012bfd0>] [<c0116ea8>] [<c014479e>=
]=20
   [<c014495d>] [<c015ac26>] [<c0139d6a>] [<c0144242>] [<c015a7c0>] [<c0144=
f5c>]=20
   [<c0145227>] [<c01463ee>] [<c0105bb0>] [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c012bfd0 <file_read_actor+0/f0>
Trace; c0116ea8 <mmput+48/70>
Trace; c014479e <exec_mmap+14e/170>
Trace; c014495d <flush_old_exec+9d/2d0>
Trace; c015ac26 <load_elf_binary+466/ad0>
Trace; c0139d6a <do_page_cache_readahead+7a/120>
Trace; c0144242 <copy_strings+1c2/240>
Trace; c015a7c0 <load_elf_binary+0/ad0>
Trace; c0144f5c <search_binary_handler+ac/1e0>
Trace; c0145227 <do_execve+197/240>
Trace; c01463ee <getname+5e/a0>
Trace; c0105bb0 <sys_execve+30/60>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>
   0:   0f 0b                     ud2a  =20
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010282
eax: cbff88d4   ebx: c03ccabc   ecx: cbff88d4   edx: fffee638
esi: 0000005c   edi: 00000000   ebp: cbff88d4   esp: f7501f10
ds: 0018   es: 0018   ss: 0018
Stack: cbff88d4 c0127930 c03cc93c f7505f70 bfffc000 00004000 f7552660 00000=
000=20
       cbff88d4 c03ccabc 0000005c 00000128 cbff88d4 c012aa9c cbff88d4 00000=
001=20
       c011b068 00000282 fffffff6 f7510c80 00000002 f79e5340 00000000 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c011b068>] [<c0116ea8>] [<c011bc34>=
]=20
   [<c01114e6>] [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c011b068 <release_task+a8/b0>
Trace; c0116ea8 <mmput+48/70>
Trace; c011bc34 <do_exit+c4/2a0>
Trace; c01114e6 <smp_apic_timer_interrupt+f6/120>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

/: clean, 285771kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010282
eax: cbff9ea8   ebx: c03cc390   ecx: cbff9ea8   edx: fffe5ff8
esi: 00000090   edi: 00000000   ebp: cbff9ea8   esp: f74abc20
ds: 0018   es: 0018   ss: 0018
Stack: cbff9ea8 003c8000 c100001c cbff5410 c19a001c c034628c 00000203 fffff=
ffe=20
       cbff9ea8 c03cc390 00000090 00000094 cbff9ea8 c012aa9c cbff9ea8 f7966=
280=20
       f74abca0 f74abc6c c012bfd0 f7510e60 f74aa000 00000000 f7510e60 c0116=
ea8=20
Call Trace: [<c012aa9c>] [<c012bfd0>] [<c0116ea8>] [<c014479e>] [<c014495d>=
]=20
   [<c015ac26>] [<c0139d6a>] [<c0144242>] [<c015a7c0>] [<c0144f5c>] [<c0145=
227>]=20
   [<c01463ee>] [<c0105bb0>] [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c012bfd0 <file_read_actor+0/f0>
Trace; c0116ea8 <mmput+48/70>
Trace; c014479e <exec_mmap+14e/170>
Trace; c014495d <flush_old_exec+9d/2d0>
Trace; c015ac26 <load_elf_binary+466/ad0>
Trace; c0139d6a <do_page_cache_readahead+7a/120>
Trace; c0144242 <copy_strings+1c2/240>
Trace; c015a7c0 <load_elf_binary+0/ad0>
Trace; c0144f5c <search_binary_handler+ac/1e0>
Trace; c0145227 <do_execve+197/240>
Trace; c01463ee <getname+5e/a0>
Trace; c0105bb0 <sys_execve+30/60>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

 kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010282
eax: cbff5ba0   ebx: c03cca40   ecx: cbff5ba0   edx: fffee680
esi: 0000003d   edi: 00000000   ebp: cbff5ba0   esp: f74c9f10
ds: 0018   es: 0018   ss: 0018
Stack: cbff5ba0 c0127930 c03cc93c f7505ff0 bfffc000 00004000 f74dba80 00000=
000=20
       cbff5ba0 c03cca40 0000003d 00000054 cbff5ba0 c012aa9c cbff5ba0 f7a36=
f60=20
       f7520340 cc09eee0 f74d2b40 f7510f00 00000002 f74ef320 00000000 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c0116ea8>] [<c011bc34>] [<c013c402>=
]=20
   [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c0116ea8 <mmput+48/70>
Trace; c011bc34 <do_exit+c4/2a0>
Trace; c013c402 <filp_close+92/a0>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

 /2469152 files, kernel BUG at page_alloc.c:98!
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010286
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D

0127930 c03ce130 f7505f90 bfffb000 00005000 f74e9380 00000000=20
       cbff7778 c03ce160 00000008 000000a6 cbff7778 c012aa9c cbff7778 f74ef=
960=20
       c011b068 00000282 00000059 f7510d20 00000002 f79e5340 00000800 c0116=
ea8=20
Call Trace: [<c0127930>] [<c012aa9c>] [<c011b068>] [<c0116ea8>] [<c011bc34>=
]=20
   [<c01209e0>] [<c0114fa0>] [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

Trace; c0127930 <unmap_page_range+40/60>
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c011b068 <release_task+a8/b0>
Trace; c0116ea8 <mmput+48/70>
Trace; c011bc34 <do_exit+c4/2a0>
Trace; c01209e0 <process_timeout+0/10>
Trace; c0114fa0 <default_wake_function+0/40>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>
   0:   0f 0b                     ud2a  =20
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)

 /etc/rc.sysinit:kernel BUG line 295:    88 Segmentation fault      initlog=
 -c "fsck -T -a $fsckoptions /"
invalid operand: 0000
CPU:    7
EIP:    0010:[<c0132a0a>]    Not tainted
EFLAGS: 00010282
eax: cbff6e5c   ebx: c03cfb98   ecx: cbff6e5c   edx: fffeeff8
esi: 00000099   edi: 00000000   ebp: cbff6e5c   esp: f7501c20
ds: 0018   es: 0018   ss: 0018
Stack: cbff6e5c 003c8000 c100001c cbff5468 c19a001c c034628c 00000207 fffff=
ffe=20
       cbff6e5c c03cfb98 00000099 0000009d cbff6e5c c012aa9c cbff6e5c f7966=
280=20
       f7501ca0 f7501c6c c012bfd0 f74c8f20 f7500000 00000000 f74c8f20 c0116=
ea8=20
Call Trace: [<c012aa9c>] [<c012bfd0>] [<c0116ea8>] [<c014479e>] [<c014495d>=
]=20
   [<c015ac26>] [<c0115020>] [<c0139d6a>] [<c0144242>] [<c015a7c0>] [<c0144=
f5c>]=20
   [<c0145227>] [<c01463ee>] [<c0105bb0>] [<c010700b>]=20
Code: 0f 0b 62 00 06 6c 2e c0 8b 0c 24 ba 04 00 00 00 8b 41 14 83=20

>>EIP; c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
Trace; c012aa9c <exit_mmap+15c/220>
Trace; c012bfd0 <file_read_actor+0/f0>
Trace; c0116ea8 <mmput+48/70>
Trace; c014479e <exec_mmap+14e/170>
Trace; c014495d <flush_old_exec+9d/2d0>
Trace; c015ac26 <load_elf_binary+466/ad0>
Trace; c0115020 <__wake_up_common+40/60>
Trace; c0139d6a <do_page_cache_readahead+7a/120>
Trace; c0144242 <copy_strings+1c2/240>
Trace; c015a7c0 <load_elf_binary+0/ad0>
Trace; c0144f5c <search_binary_handler+ac/1e0>
Trace; c0145227 <do_execve+197/240>
Trace; c01463ee <getname+5e/a0>
Trace; c0105bb0 <sys_execve+30/60>
Trace; c010700b <syscall_call+7/b>
Code;  c0132a0a <__free_pages_ok+9a/320>
00000000 <_EIP>:
Code;  c0132a0a <__free_pages_ok+9a/320>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0132a0c <__free_pages_ok+9c/320>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132a0e <__free_pages_ok+9e/320>
   4:   06                        push   %es
Code;  c0132a0f <__free_pages_ok+9f/320>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c0132a10 <__free_pages_ok+a0/320>
   6:   2e c0 8b 0c 24 ba 04      rorb   $0x0,%cs:0x4ba240c(%ebx)
Code;  c0132a17 <__free_pages_ok+a7/320>
   d:   00=20
Code;  c0132a18 <__free_pages_ok+a8/320>
   e:   00 00                     add    %al,(%eax)
Code;  c0132a1a <__free_pages_ok+aa/320>
  10:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c0132a1d <__free_pages_ok+ad/320>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning issued.  Results may not be reliable.

--=-XB+YNemAQPiyzzpKCfWX--

