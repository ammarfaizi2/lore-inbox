Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280054AbRKJAkD>; Fri, 9 Nov 2001 19:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280356AbRKJAjp>; Fri, 9 Nov 2001 19:39:45 -0500
Received: from 24-148-58-49.na.21stcentury.net ([24.148.58.49]:23921 "EHLO
	danapple.com") by vger.kernel.org with ESMTP id <S280054AbRKJAjb>;
	Fri, 9 Nov 2001 19:39:31 -0500
Message-Id: <200111100038.fAA0cbU13195@danapple.com>
To: linux-kernel@vger.kernel.org
Subject: paging Oops in 2.4.1{4,5-pre1}
From: "Daniel I. Applebaum" <kernel@danapple.com>
Reply-to: kernel@danapple.com
Date: Fri, 09 Nov 2001 18:38:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem with kernels 2.4.14 and 2.4.15-pre1.  As soon as my
system needs to page, it generates the following Oops.  I can
duplicate this error at will by running a few memory-intensive
processes, such as 4-5 simultaneously compiles, StarOffice, and
Netscape.  If I duplicate the test, but running with no swap, just
RAM, then I get the expected "Out of Memory: Killed process..."
errors.

The system is an IBM xSeries 200 with 128MB, Celeron 667Mhz, and 3Ware
Escalade 6400.  All fixed disk access is via the Escalade, even swap.
Additionally, there is a CDROM, CD-RW, and Travan tape drive connected
to the motherboard IDE controllers.  The system runs very reliably
with kernel 2.2.16-22 as delivered with RedHat Linux 7.0, with the
addition of the 3Ware driver.  (With the new kernel, I'm running the
3Ware driver that came with the kernel.)

I tried to look up the EIP: values, ie. 00000500 & c10c0a47, in the
namelist using nm(1), but I don't have confidence that they're
meaningful, since c10c0a47 isn't in the range of addresses output by
nm.

The kernel was built using:
% gcc --version
2.96
% ld -v
GNU ld version 2.10.90 (with BFD 2.10.0.18)
% as -v
GNU assembler version 2.10.90 (i386-redhat-linux) using BFD version 2.10.0.18

Please let me know if there is anything you'd like me to try in order
to gather more information.

Dan.
+++++++++++++++++
ksymoops 2.3.4 on i686 2.4.15-pre1.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre1/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
WARNING: USB Mass Storage data integrity not assured
Unable to handle kernel NULL pointer dereference at virtual address 00000500
00000500
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000500>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 00000005   edx: c8820000
esi: 00000005   edi: c25a9504   ebp: c53ecac0   esp: c4d59e98
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 3828, stackpage=c4d59000)
Stack: c10d1380 c011e41d c02b3e40 00000001 40141a90 00000000 c53ecac0 c0313c60 
       c011e69b c53ecac0 c0313c60 40141a90 c25a9504 00000500 00000000 c1ab66a4 
       00000011 c4d58560 c1ab66a4 c4d58560 c4d59fc4 c0106b4d 00000011 c4d58000 
Call Trace: [<c011e41d>] [<c011e69b>] [<c0106b4d>] [<c010e5ba>] [<c011a393>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00000500 Before first symbol   <=====
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c0106b4d <handle_signal+7d/100>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c011a393 <sys_rt_sigaction+93/f0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c10c0a47
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c10c0a47>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c02b3e40   ecx: 00000001   edx: c8820000
esi: 00000001   edi: 00000100   ebp: 00000001   esp: c2f23eb4
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 3824, stackpage=c2f23000)
Stack: c02b3e40 c01278f9 c02b3e40 c10c0a40 00000000 00000001 c10c0a40 00011000 
       c3c85328 080c6000 c0127320 c10c0a40 00004000 c011d718 c10c0a40 00000004 
       00000000 080d7000 c3c3d080 00000000 080d7000 c3c3d080 c73c6980 4014288c 
Call Trace: [<c01278f9>] [<c0127320>] [<c011d718>] [<c012cf3f>] [<c011fb08>] 
   [<c0110319>] [<c0114184>] [<c010e430>] [<c0106f57>] 
Code: c1 00 00 00 00 00 01 00 00 80 c5 1d c1 02 00 00 00 59 00 00 

>>EIP; c10c0a47 <END_OF_CODE+ded483/???   <=====
Trace; c01278f9 <remove_exclusive_swap_page+a9/c0>
Trace; c0127320 <free_page_and_swap_cache+20/30>
Trace; c011d718 <zap_page_range+148/200>
Trace; c012cf3f <fput+af/d0>
Trace; c011fb08 <exit_mmap+b8/120>
Trace; c0110319 <mmput+39/60>
Trace; c0114184 <do_exit+84/1b0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0106f57 <system_call+33/38>
Code;  c10c0a47 <END_OF_CODE+ded483/???
00000000 <_EIP>:
Code;  c10c0a47 <END_OF_CODE+ded483/???   <=====
   0:   c1 00 00                  roll   $0x0,(%eax)   <=====
Code;  c10c0a4a <END_OF_CODE+ded486/???
   3:   00 00                     add    %al,(%eax)
Code;  c10c0a4c <END_OF_CODE+ded488/???
   5:   00 01                     add    %al,(%ecx)
Code;  c10c0a4e <END_OF_CODE+ded48a/???
   7:   00 00                     add    %al,(%eax)
Code;  c10c0a50 <END_OF_CODE+ded48c/???
   9:   80 c5 1d                  add    $0x1d,%ch
Code;  c10c0a53 <END_OF_CODE+ded48f/???
   c:   c1 02 00                  roll   $0x0,(%edx)
Code;  c10c0a56 <END_OF_CODE+ded492/???
   f:   00 00                     add    %al,(%eax)
Code;  c10c0a58 <END_OF_CODE+ded494/???
  11:   59                        pop    %ecx

 <1>Unable to handle kernel paging request at virtual address 00004900
00004900
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00004900>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 00000049   edx: c8820000
esi: 00000049   edi: 00000001   ebp: 000010b3   esp: c7fbbf28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c7fbb000)
Stack: c1199d80 c01260d3 c02b3e40 c013d85e c7fba000 00000129 000001d0 c025e348 
       0000000b 0000000b c1203730 00000000 0000000b 000001d0 00000003 00006e22 
       c0126248 00000003 00000005 c025e348 00000003 000001d0 c025e348 00000000 
Call Trace: [<c01260d3>] [<c013d85e>] [<c0126248>] [<c012629c>] [<c0126341>] 
   [<c01263b6>] [<c01264f1>] [<c0126450>] [<c010576b>] 
Code:  Bad EIP value.

>>EIP; 00004900 Before first symbol   <=====
Trace; c01260d3 <shrink_cache+293/2d0>
Trace; c013d85e <prune_icache+ce/e0>
Trace; c0126248 <shrink_caches+58/80>
Trace; c012629c <try_to_free_pages+2c/50>
Trace; c0126341 <kswapd_balance_pgdat+51/a0>
Trace; c01263b6 <kswapd_balance+26/40>
Trace; c01264f1 <kswapd+a1/c0>
Trace; c0126450 <kswapd+0/c0>
Trace; c010576b <kernel_thread+2b/40>

 <1>Unable to handle kernel paging request at virtual address 00004b00
00004b00
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00004b00>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 0000004b   edx: c8820000
esi: 0000004b   edi: 00000020   ebp: 0000098d   esp: c40c3dc0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 4413, stackpage=c40c3000)
Stack: c119b240 c01260d3 c02b3e40 0000000c c40c2000 000000f9 000001d2 c025e348 
       00067b30 00001000 c12032d0 00000000 00000020 000001d2 00000006 00007306 
       c0126248 00000006 0000000f c025e348 00000006 000001d2 c025e348 00000000 
Call Trace: [<c01260d3>] [<c0126248>] [<c012629c>] [<c0126b63>] [<c0126dfb>] 
   [<c011e4b5>] [<c011e554>] [<c011e688>] [<c010e5ba>] [<c010b6a2>] [<c012c373>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00004b00 Before first symbol   <=====
Trace; c01260d3 <shrink_cache+293/2d0>
Trace; c0126248 <shrink_caches+58/80>
Trace; c012629c <try_to_free_pages+2c/50>
Trace; c0126b63 <balance_classzone+53/1a0>
Trace; c0126dfb <__alloc_pages+14b/1d0>
Trace; c011e4b5 <do_anonymous_page+35/a0>
Trace; c011e554 <do_no_page+34/110>
Trace; c011e688 <handle_mm_fault+58/c0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c010b6a2 <old_mmap+102/140>
Trace; c012c373 <sys_read+c3/d0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00004a00
00004a00
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00004a00>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 0000004a   edx: c8820000
esi: 0000004a   edi: 00000020   ebp: 00000997   esp: c2777d7c
ds: 0018   es: 0018   ss: 0018
Process soffice.bin (pid: 4200, stackpage=c2777000)
Stack: c119aa40 c01260d3 c02b3e40 00000000 c2776000 000000fe 000001d2 c025e348 
       c1336a58 00000002 c1207980 00000000 00000020 000001d2 00000006 0000733e 
       c0126248 00000006 0000000f c025e348 00000006 000001d2 c025e348 00000000 
Call Trace: [<c01260d3>] [<c0126248>] [<c012629c>] [<c0126b63>] [<c0126dfb>] 
   [<c0120621>] [<c0120699>] [<c012170b>] [<c01f740b>] [<c0121600>] [<c011e573>] 
   [<c011e688>] [<c011efc0>] [<c010e5ba>] [<c01d971e>] [<c010827c>] [<c011536d>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00004a00 Before first symbol   <=====
Trace; c01260d3 <shrink_cache+293/2d0>
Trace; c0126248 <shrink_caches+58/80>
Trace; c012629c <try_to_free_pages+2c/50>
Trace; c0126b63 <balance_classzone+53/1a0>
Trace; c0126dfb <__alloc_pages+14b/1d0>
Trace; c0120621 <page_cache_read+61/b0>
Trace; c0120699 <read_cluster_nonblocking+29/40>
Trace; c012170b <filemap_nopage+10b/210>
Trace; c01f740b <tcp_v4_do_rcv+2b/110>
Trace; c0121600 <filemap_nopage+0/210>
Trace; c011e573 <do_no_page+53/110>
Trace; c011e688 <handle_mm_fault+58/c0>
Trace; c011efc0 <do_mmap_pgoff+420/4d0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c01d971e <net_rx_action+13e/220>
Trace; c010827c <handle_IRQ_event+3c/70>
Trace; c011536d <do_softirq+4d/90>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00004700
00004700
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00004700>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 00000047   edx: c8820000
esi: 00000047   edi: 00000020   ebp: 00000998   esp: c6581dc0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 4549, stackpage=c6581000)
Stack: c119aa00 c01260d3 c02b3e40 c476eb78 c6580000 00000100 000001d2 c025e348 
       c01f01ce c476eaa0 c1207520 00000000 00000020 000001d2 00000006 0000732e 
       c0126248 00000006 0000000f c025e348 00000006 000001d2 c025e348 00000000 
Call Trace: [<c01260d3>] [<c01f01ce>] [<c0126248>] [<c012629c>] [<c0126b63>] 
   [<c0126dfb>] [<c011e4b5>] [<c011e554>] [<c011e688>] [<c010e5ba>] [<c010b6a2>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00004700 Before first symbol   <=====
Trace; c01260d3 <shrink_cache+293/2d0>
Trace; c01f01ce <tcp_rcv_established+34e/760>
Trace; c0126248 <shrink_caches+58/80>
Trace; c012629c <try_to_free_pages+2c/50>
Trace; c0126b63 <balance_classzone+53/1a0>
Trace; c0126dfb <__alloc_pages+14b/1d0>
Trace; c011e4b5 <do_anonymous_page+35/a0>
Trace; c011e554 <do_no_page+34/110>
Trace; c011e688 <handle_mm_fault+58/c0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c010b6a2 <old_mmap+102/140>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00001100
00001100
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00001100>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 00000011   edx: c8820000
esi: 00000011   edi: c3b04504   ebp: c53ec840   esp: c3375e98
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 3687, stackpage=c3375000)
Stack: c10618c0 c011e41d c02b3e40 00000001 40141a90 00000000 c53ec840 c544e140 
       c011e69b c53ec840 c544e140 40141a90 c3b04504 00001100 00000000 c62e56c4 
       00000011 c3374560 c62e56c4 c3374560 c3375fc4 c0106b4d 00000011 c3374000 
Call Trace: [<c011e41d>] [<c011e69b>] [<c0106b4d>] [<c010e5ba>] [<c011a393>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00001100 Before first symbol   <=====
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c0106b4d <handle_signal+7d/100>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c011a393 <sys_rt_sigaction+93/f0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000d00
c10fb6c0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c10fb6c0>]    Not tainted
EFLAGS: 00010207
eax: 00000000   ebx: c02b3e40   ecx: 0000000d   edx: c8820000
esi: 0000000d   edi: 00000d00   ebp: 00000001   esp: c4b15eb4
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 3677, stackpage=c4b15000)
Stack: c02b3e40 c01278f9 c02b3e40 c10fb6c0 00000000 00000001 c10fb6c0 00014000 
       c2e83328 080c6000 c0127320 c10fb6c0 00004000 c011d718 c10fb6c0 00000004 
       00000000 080da000 c4adf080 00000000 080da000 c4adf080 c3c26920 4014288c 
Call Trace: [<c01278f9>] [<c0127320>] [<c011d718>] [<c012cf3f>] [<c011fb08>] 
   [<c0110319>] [<c0114184>] [<c010e430>] [<c0106f57>] 
Code: c0 0c 07 c1 c0 d3 0b c1 00 00 00 00 00 0d 00 00 00 ba 07 c1 

>>EIP; c10fb6c0 <END_OF_CODE+e280fc/???   <=====
Trace; c01278f9 <remove_exclusive_swap_page+a9/c0>
Trace; c0127320 <free_page_and_swap_cache+20/30>
Trace; c011d718 <zap_page_range+148/200>
Trace; c012cf3f <fput+af/d0>
Trace; c011fb08 <exit_mmap+b8/120>
Trace; c0110319 <mmput+39/60>
Trace; c0114184 <do_exit+84/1b0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0106f57 <system_call+33/38>
Code;  c10fb6c0 <END_OF_CODE+e280fc/???
00000000 <_EIP>:
Code;  c10fb6c0 <END_OF_CODE+e280fc/???   <=====
   0:   c0 0c 07 c1               rorb   $0xc1,(%edi,%eax,1)   <=====
Code;  c10fb6c4 <END_OF_CODE+e28100/???
   4:   c0 d3 0b                  rcl    $0xb,%bl
Code;  c10fb6c7 <END_OF_CODE+e28103/???
   7:   c1 00 00                  roll   $0x0,(%eax)
Code;  c10fb6ca <END_OF_CODE+e28106/???
   a:   00 00                     add    %al,(%eax)
Code;  c10fb6cc <END_OF_CODE+e28108/???
   c:   00 0d 00 00 00 ba         add    %cl,0xba000000
Code;  c10fb6d2 <END_OF_CODE+e2810e/???
  12:   07                        pop    %es
Code;  c10fb6d3 <END_OF_CODE+e2810f/???
  13:   c1 00 00                  roll   $0x0,(%eax)

 <1>Unable to handle kernel paging request at virtual address 00003b00
00003b00
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00003b00>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 0000003b   edx: c8820000
esi: 0000003b   edi: 00000020   ebp: 0000099d   esp: c6ca1dc0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 4560, stackpage=c6ca1000)
Stack: c11992c0 c01260d3 c02b3e40 c12c91c0 c6ca0000 00000100 000001d2 c025e348 
       c476f538 00000004 c12070c0 00000000 00000020 000001d2 00000006 0000736c 
       c0126248 00000006 0000000f c025e348 00000006 000001d2 c025e348 00000000 
Call Trace: [<c01260d3>] [<c0126248>] [<c012629c>] [<c0126b63>] [<c0126dfb>] 
   [<c01e3b96>] [<c011e4b5>] [<c011e554>] [<c011e688>] [<c010e5ba>] [<c010b6a2>] 
   [<c011563b>] [<c0115550>] [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00003b00 Before first symbol   <=====
Trace; c01260d3 <shrink_cache+293/2d0>
Trace; c0126248 <shrink_caches+58/80>
Trace; c012629c <try_to_free_pages+2c/50>
Trace; c0126b63 <balance_classzone+53/1a0>
Trace; c0126dfb <__alloc_pages+14b/1d0>
Trace; c01e3b96 <ip_queue_xmit+336/470>
Trace; c011e4b5 <do_anonymous_page+35/a0>
Trace; c011e554 <do_no_page+34/110>
Trace; c011e688 <handle_mm_fault+58/c0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c010b6a2 <old_mmap+102/140>
Trace; c011563b <bh_action+1b/50>
Trace; c0115550 <tasklet_hi_action+40/60>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00027000
00027000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00027000>]    Not tainted
EFLAGS: 00010202
eax: 00000007   ebx: c02b3e40   ecx: 00000270   edx: c8820000
esi: 00000270   edi: c4adc104   ebp: c53ec0c0   esp: c41f9e98
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 3453, stackpage=c41f9000)
Stack: c11cbb40 c011e41d c02b3e40 00000001 40041a14 00000000 c53ec0c0 c3187740 
       c011e69b c53ec0c0 c3187740 40041a14 c4adc104 00027000 00000000 c476e0e0 
       c476e0e0 00000000 c01d5386 c1207360 c476e0e0 00000000 c01ea25f c41f8000 
Call Trace: [<c011e41d>] [<c011e69b>] [<c01d5386>] [<c01ea25f>] [<c010e5ba>] 
   [<c013cb1f>] [<c013bca1>] [<c012cf3f>] [<c012bf15>] [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00027000 Before first symbol   <=====
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c01d5386 <sk_free+36/40>
Trace; c01ea25f <tcp_close+5bf/5d0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c013cb1f <destroy_inode+1f/30>
Trace; c013bca1 <dput+101/120>
Trace; c012cf3f <fput+af/d0>
Trace; c012bf15 <filp_close+55/60>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00028100
00028100
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00028100>]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: c02b3e40   ecx: 00000281   edx: c8820000
esi: 00000281   edi: c10fec40   ebp: 400fe000   esp: c41f9ca8
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 3453, stackpage=c41f9000)
Stack: c10fec40 c01272ec c02b3e40 c025e220 c02b3e40 c0127973 c10fec40 00001000 
       00008000 c4adc3fc c011d726 00028100 00000001 00000000 40106000 c49c0400 
       00000000 40106000 c49c0400 00000000 00000046 00000000 c01184b6 00000001 
Call Trace: [<c01272ec>] [<c0127973>] [<c011d726>] [<c01184b6>] [<c01186c4>] 
   [<c011fb08>] [<c011536d>] [<c0110319>] [<c0114184>] [<c0210018>] [<c0107493>] 
   [<c010e7b7>] [<c01d91be>] [<c01d90c0>] [<c01e380c>] [<c010e5ba>] [<c01e3b96>] 
   [<c010e430>] [<c0107048>] [<c011e41d>] [<c011e69b>] [<c01d5386>] [<c01ea25f>] 
   [<c010e5ba>] [<c013cb1f>] [<c013bca1>] [<c012cf3f>] [<c012bf15>] [<c010e430>] 
   [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00028100 Before first symbol   <=====
Trace; c01272ec <delete_from_swap_cache+2c/40>
Trace; c0127973 <free_swap_and_cache+63/90>
Trace; c011d726 <zap_page_range+156/200>
Trace; c01184b6 <update_wall_time+16/50>
Trace; c01186c4 <timer_bh+24/250>
Trace; c011fb08 <exit_mmap+b8/120>
Trace; c011536d <do_softirq+4d/90>
Trace; c0110319 <mmput+39/60>
Trace; c0114184 <do_exit+84/1b0>
Trace; c0210018 <svc_makesock+48/50>
Trace; c0107493 <die+53/60>
Trace; c010e7b7 <do_page_fault+387/4d0>
Trace; c01d91be <dev_queue_xmit+fe/270>
Trace; c01d90c0 <dev_queue_xmit+0/270>
Trace; c01e380c <ip_output+ac/100>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c01e3b96 <ip_queue_xmit+336/470>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c01d5386 <sk_free+36/40>
Trace; c01ea25f <tcp_close+5bf/5d0>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c013cb1f <destroy_inode+1f/30>
Trace; c013bca1 <dput+101/120>
Trace; c012cf3f <fput+af/d0>
Trace; c012bf15 <filp_close+55/60>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 00002200
00002200
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00002200>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c02b3e40   ecx: 00000022   edx: c8820000
esi: 00000022   edi: c5f44504   ebp: c69e2960   esp: c5fade98
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 2691, stackpage=c5fad000)
Stack: c115a8c0 c011e41d c02b3e40 00000001 40141a90 00000000 c69e2960 c5dff860 
       c011e69b c69e2960 c5dff860 40141a90 c5f44504 00002200 00000000 c5e97bc4 
       00000011 c5fac560 c5e97bc4 c5fac560 c5fadfc4 c0106b4d 00000011 c5fac000 
Call Trace: [<c011e41d>] [<c011e69b>] [<c0106b4d>] [<c010e5ba>] [<c011a393>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00002200 Before first symbol   <=====
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c0106b4d <handle_signal+7d/100>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c011a393 <sys_rt_sigaction+93/f0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

 <1>Unable to handle kernel paging request at virtual address 27c0c138
c114e4c0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c114e4c0>]    Not tainted
EFLAGS: 00010207
eax: 00000000   ebx: c02b3e40   ecx: 00000019   edx: c8820000
esi: 00000019   edi: 00001900   ebp: 00000001   esp: c5ab5eb4
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 2688, stackpage=c5ab5000)
Stack: c02b3e40 c01278f9 c02b3e40 c114e4c0 00000000 00000001 c114e4c0 0001e000 
       c13f3328 080c6000 c0127320 c114e4c0 00004000 c011d718 c114e4c0 00000004 
       00000000 080e4000 c7e66080 00000000 080e4000 c7e66080 c609a140 40141a90 
Call Trace: [<c01278f9>] [<c0127320>] [<c011d718>] [<c012cf3f>] [<c011fb08>] 
   [<c0110319>] [<c0114184>] [<c010e430>] [<c0106f57>] 
Code: c0 91 1f c1 c0 27 12 c1 00 00 00 00 00 19 00 00 00 00 00 00 

>>EIP; c114e4c0 <END_OF_CODE+e7aefc/???   <=====
Trace; c01278f9 <remove_exclusive_swap_page+a9/c0>
Trace; c0127320 <free_page_and_swap_cache+20/30>
Trace; c011d718 <zap_page_range+148/200>
Trace; c012cf3f <fput+af/d0>
Trace; c011fb08 <exit_mmap+b8/120>
Trace; c0110319 <mmput+39/60>
Trace; c0114184 <do_exit+84/1b0>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0106f57 <system_call+33/38>
Code;  c114e4c0 <END_OF_CODE+e7aefc/???
00000000 <_EIP>:
Code;  c114e4c0 <END_OF_CODE+e7aefc/???   <=====
   0:   c0 91 1f c1 c0 27 12      rclb   $0x12,0x27c0c11f(%ecx)   <=====
Code;  c114e4c7 <END_OF_CODE+e7af03/???
   7:   c1 00 00                  roll   $0x0,(%eax)
Code;  c114e4ca <END_OF_CODE+e7af06/???
   a:   00 00                     add    %al,(%eax)
Code;  c114e4cc <END_OF_CODE+e7af08/???
   c:   00 19                     add    %bl,(%ecx)

 <1>Unable to handle kernel paging request at virtual address 00027300
00027300
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00027300>]    Not tainted
EFLAGS: 00010202
eax: 00000002   ebx: c02b3e40   ecx: 00000273   edx: c8820000
esi: 00000273   edi: c3c3b210   ebp: c69e2780   esp: c2651e98
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 4665, stackpage=c2651000)
Stack: c11cc680 c011e41d c02b3e40 00000001 400846a0 00000000 c69e2780 c609a200 
       c011e69b c69e2780 c609a200 400846a0 c3c3b210 00027300 00000000 c7facc78 
       00000000 c1336a00 00000000 00000000 00000000 c01b4560 c1336a00 c2650000 
Call Trace: [<c011e41d>] [<c011e69b>] [<c01b4560>] [<c010e5ba>] [<c016c15c>] 
   [<c0115709>] [<c01184b6>] [<c01186c4>] [<c011563b>] [<c0115550>] [<c011536d>] 
   [<c010e430>] [<c0107048>] 
Code:  Bad EIP value.

>>EIP; 00027300 Before first symbol   <=====
Trace; c011e41d <do_swap_page+7d/e0>
Trace; c011e69b <handle_mm_fault+6b/c0>
Trace; c01b4560 <scsi_io_completion+180/430>
Trace; c010e5ba <do_page_fault+18a/4d0>
Trace; c016c15c <batch_entropy_process+ac/b0>
Trace; c0115709 <__run_task_queue+49/60>
Trace; c01184b6 <update_wall_time+16/50>
Trace; c01186c4 <timer_bh+24/250>
Trace; c011563b <bh_action+1b/50>
Trace; c0115550 <tasklet_hi_action+40/60>
Trace; c011536d <do_softirq+4d/90>
Trace; c010e430 <do_page_fault+0/4d0>
Trace; c0107048 <error_code+34/3c>

