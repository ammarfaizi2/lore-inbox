Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136563AbREDXIg>; Fri, 4 May 2001 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136566AbREDXIR>; Fri, 4 May 2001 19:08:17 -0400
Received: from 110-ZARA-X5.libre.retevision.es ([62.82.231.110]:27663 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S136563AbREDXIO>;
	Fri, 4 May 2001 19:08:14 -0400
Message-ID: <3AF2CAC1.9040208@zaralinux.com>
Date: Fri, 04 May 2001 17:29:05 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i586; en-US; 0.8) Gecko/20010226
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux SMP <linux-smp@vger.kernel.org>
Subject: Re: Memory management issues with 2.4.4
In-Reply-To: <Pine.LNX.4.21.0105021625520.4127-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

 >
 > On Wed, 2 May 2001, Jorge Nerin wrote:
 >
 >> Short version:
 >> Under very heavy thrashing (about four hours) the system either lockups
 >> or OOM handler kills a task even when there is swap space left.
 >
 >
 > First of all, please try to reproduce the problem with 2.4.5-pre1.
 >
 > If it still happens with pre1, please show us the output of "cat
 > /proc/slabinfo" when the kernel is about to trigger the OOM killer.
 >
 > Thanks.
 >


Well, as I had said this morning I have feed the Oops to ksymoops, note 
that I may have mirtyped something, but anyway here is the output of 
ksymoops:


ksymoops 2.3.4 on i586 2.4.5-pre1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.5-pre1/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol 
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring 
ksyms_base entry
invalid operand: 0000
CPU: 1
EIP: 0010:[<c0123c4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010096
eax: 0000001b ebx: ffffffff ecx: 00000001 edx: 00000001
esi: c021b960 edi: c5fe2000 ebp: c5fe3ce0 esp: c5fe3c88
Stack: c01e89a5 c01c8af6 000002c5 00000000 c021b960 c021b954 00000000 
00000001
        00000020 000000cc c02961c0 00000120 c012ca08 c5fe2000 00000000 
c216960
        c21b954  c5fe2000 00000080 00000001 c5fe2000 00000001 00000001 
c12da64
Call Trace:   [<c012ca08>] [<c012da64>] [<c012dbcc>] [<c0113bbb>] 
[<c01058c9>] [<c0106d07>] [<c010e568>]
  [<c01054ea>] [<c010e591>] [<c010e568>] [<c01746de>] [<c0172dfd>] 
[<c0173fcc>] [<c017405c>] [<c0108516>]
  [<c0108709>] [<c0106de0>] [<c010fc60>] [<c0129e78>] [<c0129c78>] 
[<c0129e52>] [<c0129e78>] [<c0129f56>]
  [<c0129e78>] [<c0129f83>] [<c0129a29>] [<c01471a4>] [<c012cc9b>] 
[<c012cd2b>] [<c0105000>] [<c01054f3>]
Code: 0f 0b 8d 65 b4 5b 5f 89 ec 5d c3 55 89 e5 83 ec 18 57 56

 >>EIP; 0c0123c4 Before first symbol   <=====
Trace; c012ca08 <free_shortage+1c/100>
Trace; c012da64 <__alloc_pages+16c/2c0>
Trace; c012dbcc <__get_free_pages+14/20>
Trace; c0113bbb <do_fork+93/770>
Trace; c01058c9 <sys_clone+1d/24>
Trace; c0106d07 <system_call+37/40>
Trace; c010e568 <apm_magic+0/8>
Trace; c01054ea <kernel_thread+1a/30>
Trace; c010e591 <apm_power_off+21/3c>
Trace; c010e568 <apm_magic+0/8>
Trace; c01746de <handle_sysrq+de/230>
Trace; c0172dfd <handle_scancode+1bd/318>
Trace; c0173fcc <handle_kbd_event+130/1a4>
Trace; c017405c <keyboard_interrupt+1c/28>
Trace; c0108516 <handle_IRQ_event+52/7c>
Trace; c0108709 <do_IRQ+99/ec>
Trace; c0106de0 <ret_from_intr+0/20>
Trace; c010fc60 <smp_call_function+8c/c0>
Trace; c0129e78 <do_ccupdate_local+0/40>
Trace; c0129c78 <kmem_cache_create+220/3e0>
Trace; c0129e52 <smp_call_function_all_cpus+1a/40>
Trace; c0129e78 <do_ccupdate_local+0/40>
Trace; c0129f56 <drain_cpu_caches+9e/c0>
Trace; c0129e78 <do_ccupdate_local+0/40>
Trace; c0129f83 <__kmem_cache_shrink+b/6c>
Trace; c0129a29 <kmem_slab_destroy+79/a8>
Trace; c01471a4 <shrink_dcache_memory+2c/30>
Trace; c012cc9b <do_try_to_free_pages+5f/7c>
Trace; c012cd2b <kswapd+73/110>
Trace; c0105000 <init+0/1b0>
Trace; c01054f3 <kernel_thread+23/30>
Code;  0c0123c4 Before first symbol
00000000 <_EIP>:
Code;  0c0123c4 Before first symbol   <=====
    0:   0f 0b                     ud2a      <=====
Code;  0c0123c6 Before first symbol
    2:   8d 65 b4                  lea    0xffffffb4(%ebp),%esp
Code;  0c0123c9 Before first symbol
    5:   5b                        pop    %ebx
Code;  0c0123ca Before first symbol
    6:   5f                        pop    %edi
Code;  0c0123cb Before first symbol
    7:   89 ec                     mov    %ebp,%esp
Code;  0c0123cd Before first symbol
    9:   5d                        pop    %ebp
Code;  0c0123ce Before first symbol
    a:   c3                        ret
Code;  0c0123cf Before first symbol
    b:   55                        push   %ebp
Code;  0c0123d0 Before first symbol
    c:   89 e5                     mov    %esp,%ebp
Code;  0c0123d2 Before first symbol
    e:   83 ec 18                  sub    $0x18,%esp
Code;  0c0123d5 Before first symbol
   11:   57                        push   %edi
Code;  0c0123d6 Before first symbol
   12:   56                        push   %esi

Kernel panic Aiee killing interrupt handler

2 warnings issued.  Results may not be reliable.

As I said I have tried to no make errors, but I copied it at 7 in the 
morning, so who knows ... ;-)

-- 
Jorge Nerin
<comandante@zaralinux.com>



