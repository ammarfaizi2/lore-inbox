Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287665AbRLaWSQ>; Mon, 31 Dec 2001 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287669AbRLaWSJ>; Mon, 31 Dec 2001 17:18:09 -0500
Received: from alteon01f.roc.frontiernet.net ([66.133.130.236]:43325 "HELO
	relay01.roc.frontiernet.net") by vger.kernel.org with SMTP
	id <S287665AbRLaWR6>; Mon, 31 Dec 2001 17:17:58 -0500
Date: Mon, 31 Dec 2001 17:17:47 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: oops in shrink_icache_memory()
Message-ID: <20011231171747.B1099@vaxerdec.homeip.net>
Mail-Followup-To: Scott McDermott <vaxerdec>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't reproduce this.  System was up for maybe a couple of weeks and I
did have a lot of VM usage at the time, but still had plenty of swap
left.

The system oopsed during some paging activity, but continued to run ok,
however as I was shutting down all my processes for a reboot several
more oopses occured.  I am appending them all, as well as kernel
messages from boot sequence (appended at end after oopses).

Let me know if more information or the kernel image is required (this is
stock 2.4.17).  Thanks.

***

ksymoops 2.4.1 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System-2.4.17.map (specified)

Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffcfff0
esi: c8375e00   edi: 364d0a0d   ebp: c1435f54   esp: c1435f3c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1435000)
Stack: 0000000a c59cdd88 c59cd9c8 00000009 000001d0 00000006 00000006 c0143016 
       000001fb c012a511 00000006 000001d0 00000006 000001d0 c01fdea8 00000006 
       000001d0 c01fdea8 00000000 c012a56c 00000020 c01fdea8 00000001 c1434000 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [kswapd_balance_pgdat+76/160] [kswapd_balance+19/48] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012a60c>] [<c012a673>] 
   [<c012a7c1>] [<c012a720>] [<c0105000>] [<c01054f6>] [<c012a720>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012a60c <kswapd_balance_pgdat+4c/a0>
Trace; c012a673 <kswapd_balance+13/30>
Trace; c012a7c1 <kswapd+a1/c0>
Trace; c012a720 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c012a720 <kswapd+0/c0>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffc7308
esi: c8375e00   edi: 364d0a0d   ebp: ccadddf8   esp: ccaddde0
ds: 0018   es: 0018   ss: 0018
Process fbi (pid: 17554, stackpage=ccadd000)
Stack: 0000000c cd89e648 cd89ebe8 00000008 000001d2 00000006 00000006 c0143016 
       000001fb c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 ccadc000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0121e34>] [<c0121ee0>] [<c0122018>] [<c01114b0>] [<c011cc7f>] [<c0111639>] 
   [<c011cdaa>] [<c011ce26>] [<c011bf93>] [<c0111e30>] [<c011c265>] [<c0118acb>] 
   [<c0112241>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0121e34 <do_anonymous_page+34/b0>
Trace; c0121ee0 <do_no_page+30/110>
Trace; c0122018 <handle_mm_fault+58/c0>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c011cc7f <send_signal+2f/110>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011cdaa <deliver_signal+4a/50>
Trace; c011ce26 <send_sig_info+76/90>
Trace; c011bf93 <update_process_times+23/90>
Trace; c0111e30 <process_timeout+0/50>
Trace; c011c265 <timer_bh+215/250>
Trace; c0118acb <bh_action+1b/40>
Trace; c0112241 <schedule+311/340>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffd00a0
esi: c8375e00   edi: 364d0a0d   ebp: cc8afe88   esp: cc8afe70
ds: 0018   es: 0018   ss: 0018
Process less (pid: 18091, stackpage=cc8af000)
Stack: 000000ad c68abc28 c615d9c8 00000010 000001d2 00000006 00000006 c0143016 
       0000014e c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 cc8ae000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0124ada>] [<c0124e9d>] [<c0124dc0>] [<c0130a28>] [<c0130984>] [<c0106dd3>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0124ada <do_generic_file_read+32a/430>
Trace; c0124e9d <generic_file_read+7d/140>
Trace; c0124dc0 <file_read_actor+0/60>
Trace; c0130a28 <sys_read+98/d0>
Trace; c0130984 <sys_llseek+d4/e0>
Trace; c0106dd3 <system_call+33/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffd7f68
esi: c8375e00   edi: 364d0a0d   ebp: cfc41df8   esp: cfc41de0
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 18137, stackpage=cfc41000)
Stack: 000000c0 c2d0ec28 cd6c4e08 0000000e 000001d2 00000006 00000006 c0143016 
       00000139 c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 cfc40000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0121e34>] [<c0121ee0>] [<c0122018>] [<c0111639>] [<c011bf93>] [<c0111e30>] 
   [<c011c265>] [<c0118acb>] [<c0112241>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0121e34 <do_anonymous_page+34/b0>
Trace; c0121ee0 <do_no_page+30/110>
Trace; c0122018 <handle_mm_fault+58/c0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011bf93 <update_process_times+23/90>
Trace; c0111e30 <process_timeout+0/50>
Trace; c011c265 <timer_bh+215/250>
Trace; c0118acb <bh_action+1b/40>
Trace; c0112241 <schedule+311/340>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffdc9e0
esi: c8375e00   edi: 364d0a0d   ebp: cfc41df8   esp: cfc41de0
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 18158, stackpage=cfc41000)
Stack: 00000001 c22e6a28 c22e6a28 00000019 000001d2 00000006 00000006 c0143016 
       00000202 c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 cfc40000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0121e34>] [<c0121ee0>] [<c0122018>] [<c0111639>] [<c011bf93>] [<c011be66>] 
   [<c011c075>] [<c0118acb>] [<c01189d3>] [<c01187cc>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0121e34 <do_anonymous_page+34/b0>
Trace; c0121ee0 <do_no_page+30/110>
Trace; c0122018 <handle_mm_fault+58/c0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011bf93 <update_process_times+23/90>
Trace; c011be66 <update_wall_time+16/40>
Trace; c011c075 <timer_bh+25/250>
Trace; c0118acb <bh_action+1b/40>
Trace; c01189d3 <tasklet_hi_action+53/80>
Trace; c01187cc <do_softirq+4c/90>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000006   edx: cfc41de4
esi: c8375e00   edi: 364d0a0d   ebp: cfc41df8   esp: cfc41de0
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 18178, stackpage=cfc41000)
Stack: 00000000 cfc41de4 cfc41de4 00000020 000001d2 00000006 00000006 c0143016 
       00000208 c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 cfc40000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0121e34>] [<c0121ee0>] [<c0122018>] [<c0111639>] [<c011bf93>] [<c0111e30>] 
   [<c011c265>] [<c0118acb>] [<c0112241>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0121e34 <do_anonymous_page+34/b0>
Trace; c0121ee0 <do_no_page+30/110>
Trace; c0122018 <handle_mm_fault+58/c0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011bf93 <update_process_times+23/90>
Trace; c0111e30 <process_timeout+0/50>
Trace; c011c265 <timer_bh+215/250>
Trace; c0118acb <bh_action+1b/40>
Trace; c0112241 <schedule+311/340>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000006   edx: c5ccbde4
esi: c8375e00   edi: 364d0a0d   ebp: c5ccbdf8   esp: c5ccbde0
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 18199, stackpage=c5ccb000)
Stack: 00000000 c5ccbde4 c5ccbde4 0000001d 000001d2 00000006 00000006 c0143016 
       0000020c c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 c5cca000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c0121e34>] [<c0121ee0>] [<c0122018>] [<c0111639>] [<c011bf93>] [<c0111e30>] 
   [<c011c265>] [<c0118acb>] [<c0112241>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c0121e34 <do_anonymous_page+34/b0>
Trace; c0121ee0 <do_no_page+30/110>
Trace; c0122018 <handle_mm_fault+58/c0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011bf93 <update_process_times+23/90>
Trace; c0111e30 <process_timeout+0/50>
Trace; c011c265 <timer_bh+215/250>
Trace; c0118acb <bh_action+1b/40>
Trace; c0112241 <schedule+311/340>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000006   edx: c19b7dd4
esi: c8375e00   edi: 364d0a0d   ebp: c19b7de8   esp: c19b7dd0
ds: 0018   es: 0018   ss: 0018
Process slrn (pid: 5160, stackpage=c19b7000)
Stack: 00000000 c19b7dd4 c19b7dd4 00000020 000001d2 00000006 00000006 c0143016 
       0000020e c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 c19b6000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c012b8a7>] [<c0121d0a>] [<c0121d4b>] [<c012202b>] [<c0111639>] [<c011d9ed>] 
   [<c011dddf>] [<c0112241>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c012b8a7 <read_swap_cache_async+67/a0>
Trace; c0121d0a <swapin_readahead+3a/50>
Trace; c0121d4b <do_swap_page+2b/e0>
Trace; c012202b <handle_mm_fault+6b/c0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c011d9ed <do_sigaction+ad/f0>
Trace; c011dddf <sys_rt_sigaction+9f/f0>
Trace; c0112241 <schedule+311/340>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

 <1>Unable to handle kernel paging request at virtual address 364d0a11
c0142f4b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[prune_icache+43/208]    Not tainted
EIP:    0010:[<c0142f4b>]    Not tainted
EFLAGS: 00010203
eax: 494d0a0d   ebx: 364d0a0d   ecx: 00000000   edx: cffc9da0
esi: c8375e00   edi: 364d0a0d   ebp: c7b77de8   esp: c7b77dd0
ds: 0018   es: 0018   ss: 0018
Process mozilla-bin (pid: 3192, stackpage=c7b77000)
Stack: 00000004 c749ac28 c9018688 00000003 000001d2 00000006 00000006 c0143016 
       00000212 c012a511 00000006 000001d2 00000006 000001d2 c01fdea8 00000006 
       000001d2 c01fdea8 00000000 c012a56c 00000020 c7b76000 c01fdea8 000001d2 
Call Trace: [shrink_icache_memory+38/64] [shrink_caches+113/144] [try_to_free_pages+60/96] [balance_classzone+101/576] [__alloc_pages+264/368] 
Call Trace: [<c0143016>] [<c012a511>] [<c012a56c>] [<c012af85>] [<c012b268>] 
   [<c012b8a7>] [<c0121d0a>] [<c0121d4b>] [<c012202b>] [<c01331b7>] [<c0111639>] 
   [<c0126a43>] [<c0126ab6>] [<c0130b21>] [<c01114b0>] [<c0106ee4>] 
Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38 00 00 00 75 55 0b 

>>EIP; c0142f4b <prune_icache+2b/d0>   <=====
Trace; c0143016 <shrink_icache_memory+26/40>
Trace; c012a511 <shrink_caches+71/90>
Trace; c012a56c <try_to_free_pages+3c/60>
Trace; c012af85 <balance_classzone+65/240>
Trace; c012b268 <__alloc_pages+108/170>
Trace; c012b8a7 <read_swap_cache_async+67/a0>
Trace; c0121d0a <swapin_readahead+3a/50>
Trace; c0121d4b <do_swap_page+2b/e0>
Trace; c012202b <handle_mm_fault+6b/c0>
Trace; c01331b7 <__block_commit_write+a7/d0>
Trace; c0111639 <do_page_fault+189/4f0>
Trace; c0126a43 <generic_file_write+4f3/6c0>
Trace; c0126ab6 <generic_file_write+566/6c0>
Trace; c0130b21 <sys_write+c1/d0>
Trace; c01114b0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Code;  c0142f4b <prune_icache+2b/d0>
00000000 <_EIP>:
Code;  c0142f4b <prune_icache+2b/d0>   <=====
   0:   8b 7f 04                  mov    0x4(%edi),%edi   <=====
Code;  c0142f4e <prune_icache+2e/d0>
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c0142f51 <prune_icache+31/d0>
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  c0142f57 <prune_icache+37/d0>
   c:   a9 38 00 00 00            test   $0x38,%eax
Code;  c0142f5c <prune_icache+3c/d0>
  11:   75 55                     jne    68 <_EIP+0x68> c0142fb3 <prune_icache+93/d0>
Code;  c0142f5e <prune_icache+3e/d0>
  13:   0b 00                     or     (%eax),%eax

***

klogd 1.4.1, log source = /proc/kmsg started.
Inspecting /boot/System.map
Loaded 13806 symbols from /boot/System.map.
Symbols match kernel version 2.4.17.
Loaded 110 symbols from 12 modules.
Linux version 2.4.17 (vaxerdec@vaxerdec.homeip.net) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Dec 27 03:41:16 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff0800 (ACPI NVS)
 BIOS-e820: 000000000fff0800 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=testing ro root=302 BOOT_FILE=/boot/bzImage-2.4.17 video=matrox:mem:32,init,memtype:0,sgram,xres:1600,yres:1200,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen:192,vslen:3,sync:4,font:SUN12x22
Initializing CPU#0
Detected 551.260 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1101.00 BogoMIPS
Memory: 255936k/262080k available (860k kernel code, 5756k reserved, 236k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xEC000000, mapped to 0xd0805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA18.2, ATA DISK drive
hdd: NEC CD-ROM DRIVE:282, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 36094464 sectors (18480 MB) w/371KiB Cache, CHS=35808/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Real Time Clock Driver v1.10e
Adding Swap: 226760k swap-space (priority -1)
ip_tables: (c)2000 Netfilter core team
ip_conntrack (2047 buckets, 16376 max)
PCI: Found IRQ 5 for device 00:09.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe800. Vers LK1.1.16
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 10, want irq 11
00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.16
