Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289997AbSAWT01>; Wed, 23 Jan 2002 14:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289999AbSAWTZh>; Wed, 23 Jan 2002 14:25:37 -0500
Received: from freeside.toyota.com ([63.87.74.7]:4361 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289989AbSAWTYw>; Wed, 23 Jan 2002 14:24:52 -0500
Message-ID: <3C4F0DFA.50601@lexus.com>
Date: Wed, 23 Jan 2002 11:24:42 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020122
X-Accept-Language: en-us
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
In-Reply-To: <20020123091643.A182@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto here -

2.4.18-pre6 + previous low latency patch boots & runs -

2.4.18-pre6 + latest low latency panics after this line:

Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)

(next line would have been "Buffer-cache hash table entries...")

Here is the oops (be advised, it's copied by hand)

Kernel panic: can't allocate root vfsmount
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000c011a830
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011a830>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 000001f3   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: 00000000   edi: c02425a0   ebp: c020bf10   esp: c020bf10
ds: 0018   es: 0018  ss: 0018
Process (pid: -1072520631, stackpage=c020b000)
Stack: c020bf28 c011a8aa c020bf38 c024a5c0 00000000 c02425a0 c020bf30 
c01178dd
       c020bf48 c01177ef 00000000 00000000 c02425c0 fffffff6 c020bf64 
c01175db
       c02425c0 00000046 c020bf84 00000000 c0240900 c020bf7c c01082ac 
c01f9bc8
Call Trace:  [<c011a8aa>] [<c01178dd>] [<c01177ef>] [<c01175db>] 
[<c01082ac>]
[<c0105000>] [<c0105000>] [<c0110018>] [<c0113382>]
Code: 8b 02 85 c0 74 07 8b 02 83 e0 02 74 06 81 c1 c0 08 00 00 8b

 >>EIP; c011a830 <count_active_tasks+20/50>   <=====
Trace; c011a8aa <timer_bh+4a/270>
Trace; c01178dd <bh_action+1d/50>
Trace; c01177ef <tasklet_hi_action+4f/70>
Trace; c01175db <do_softirq+5b/b0>
Trace; c01082ac <do_IRQ+ac/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0110018 <do_page_fault+28/555>
Trace; c0113382 <panic+e2/f0>
Code;  c011a830 <count_active_tasks+20/50>
00000000 <_EIP>:
Code;  c011a830 <count_active_tasks+20/50>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c011a832 <count_active_tasks+22/50>
   2:   85 c0                     test   %eax,%eax
Code;  c011a834 <count_active_tasks+24/50>
   4:   74 07                     je     d <_EIP+0xd> c011a83d 
<count_active_tasks+2d/50>
Code;  c011a836 <count_active_tasks+26/50>
   6:   8b 02                     mov    (%edx),%eax
Code;  c011a838 <count_active_tasks+28/50>
   8:   83 e0 02                  and    $0x2,%eax
Code;  c011a83b <count_active_tasks+2b/50>
   b:   74 06                     je     13 <_EIP+0x13> c011a843 
<count_active_tasks+33/50>
Code;  c011a83d <count_active_tasks+2d/50>
   d:   81 c1 c0 08 00 00         add    $0x8c0,%ecx
Code;  c011a843 <count_active_tasks+33/50>
  13:   8b 00                     mov    (%eax),%eax

Kernel panic: Aiee, killing interrupt handler!

It looks like the newer version has substantial
changes in filemap.c and page_alloc.c relative
the the older version; if I had more time I'd
have looked into it further -

Best Regards,

joe


rwhron@earthlink.net wrote:

>>http://www.zip.com.au/~akpm/linux/2.4.18-pre6-low-latency.patch.gz
>>
>
>2.4.18-pre3 with 2.4.17-low-latency.patch worked fine on this system
>2.4.18-pre6 with 2.4.18-pre6-low-latency.patch panics at boot time.
>2.4.18-pre6 is fine also.
>
>System has reiserfs root filesystem.  No modules.
>/usr/src/linux/System.map was the System.map for 2.4.18pre6ll for
>the ksymoops below.
>
>No modules in ksyms, skipping objects
>No ksyms, skipping lsmod
>Kernel panic: can't allocate root vfsmount
> <1>Unable to handle kernel NULL pointer dereference at virtual address 0000002c
>c01234d3
>*pde = 00000000
>Oops: 0000
>CPU:    0
>EIP:    0010:[<c01234d3>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010046
>eax: 00000000   ebx: 00000008   ecx: 00000000   edx: 00000073
>esi: 00000000   edi: 00000018   ebp: 00000020   esp: c0215e78
>ds: 0018   es: 0018   ss: 0018
>Process  . (pid: -1072541344, stackpage=c0215000)
>Stack: 00000018 00000001 00000018 c0214568 c0117e6c 00000000 00000020 c0214000
>       00000018 00000018 00000000 c0117f4c 00000018 00000001 c0214568 00000086
>       00000018 c0214000 c0117ff4 00000018 00000001 c0214000 01ebb409 c0214000
>Call Trace: [<c0117e6c>] [<c0117f4c>] [<c0117ff4>] [<c0118253>] [<c0117208>]
>   [<c0117291>] [<c011759f>] [<c010a889>] [<c0107d1c>] [<c0107e82>] [<c0105000>]
>   [<c0109c18>] [<c0105000>] [<c0112020>]
>Code: f6 46 2c 01 74 02 0f 0b 9c 5f fa 8b 4e 08 39 d9 75 22 8b 4e
>
>>>EIP; c01234d2 <kmem_cache_alloc+2a/b8>   <=====
>>>
>Trace; c0117e6c <send_signal+2c/f0>
>Trace; c0117f4c <deliver_signal+1c/50>
>Trace; c0117ff4 <send_sig_info+74/88>
>Trace; c0118252 <send_sig+1a/20>
>Trace; c0117208 <update_one_process+68/d4>
>Trace; c0117290 <update_process_times+1c/88>
>Trace; c011759e <do_timer+22/70>
>Trace; c010a888 <timer_interrupt+60/10c>
>Trace; c0107d1c <handle_IRQ_event+30/5c>
>Trace; c0107e82 <do_IRQ+6a/a8>
>Trace; c0105000 <_stext+0/0>
>Trace; c0109c18 <call_do_IRQ+6/e>
>Trace; c0105000 <_stext+0/0>
>Trace; c0112020 <panic+c0/d0>
>Code;  c01234d2 <kmem_cache_alloc+2a/b8>
>00000000 <_EIP>:
>Code;  c01234d2 <kmem_cache_alloc+2a/b8>   <=====
>   0:   f6 46 2c 01               testb  $0x1,0x2c(%esi)   <=====
>Code;  c01234d6 <kmem_cache_alloc+2e/b8>
>   4:   74 02                     je     8 <_EIP+0x8> c01234da <kmem_cache_alloc+32/b8>
>Code;  c01234d8 <kmem_cache_alloc+30/b8>
>   6:   0f 0b                     ud2a
>Code;  c01234da <kmem_cache_alloc+32/b8>
>   8:   9c                        pushf
>Code;  c01234da <kmem_cache_alloc+32/b8>
>   9:   5f                        pop    %edi
>Code;  c01234dc <kmem_cache_alloc+34/b8>
>   a:   fa                        cli
>Code;  c01234dc <kmem_cache_alloc+34/b8>
>   b:   8b 4e 08                  mov    0x8(%esi),%ecx
>Code;  c01234e0 <kmem_cache_alloc+38/b8>
>   e:   39 d9                     cmp    %ebx,%ecx
>Code;  c01234e2 <kmem_cache_alloc+3a/b8>
>  10:   75 22                     jne    34 <_EIP+0x34> c0123506 <kmem_cache_alloc+5e/b8>
>Code;  c01234e4 <kmem_cache_alloc+3c/b8>
>  12:   8b 4e 00                  mov    0x0(%esi),%ecx
>
> <0>Kernel panic: Aiee, killing interrupt handler!
>


