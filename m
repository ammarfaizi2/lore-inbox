Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUGVXsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUGVXsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUGVXsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:48:24 -0400
Received: from S01060001023ff1ee.su.shawcable.net ([24.76.66.102]:16512 "EHLO
	spacebox.net") by vger.kernel.org with ESMTP id S267427AbUGVXqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:46:48 -0400
Date: Thu, 22 Jul 2004 19:50:10 -0400
From: Matt DeLuco <duke@spacebox.net>
To: linux-kernel@vger.kernel.org
Subject: oops related crash
Message-ID: <20040722235010.GA2483@mobius.su.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
X-URL: http://spacebox.net/
X-HTML: HTML in email is a Bad Thing(tm).
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

last night I had a seemingly random crash with serveral oopses.  I say
random because my debug log showed nothing for 7 hours between the last
log and the oops log.  Though I don't really know if that's significant.

Anywho, I read Documentation/oops-tracing.txt.  As suggested I ran the
oops through ksymoops and I've attached the output.  I'm not sure how
reliable it'll be.. I had to edit all the log stuff (host, date/time,
etc.) out of the oops.

I'm running a "vanilla" 2.4.26 kernel with a patch I inserted manually
to prevent distcc from causing the system to crash.  The patch seemed to
be holding up well, and nothing was being compiled at the time of last
night's oops attack.  I have attached the patch (which I found on the
lkml.)

Sorry for not having done much else, but my skills in dealing with the
kernel are.. limited at best.

I hope this info is useful.  Please let me know if there's anything else
I can do.

Thanks,

    -- Matt.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.out"

ksymoops 2.4.9 on i686 2.4.26.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /usr/src/linux/System.map (default)

Warning (compare_maps): ksyms_base symbol sk_chk_filter_R__ver_sk_chk_filter not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol sk_run_filter_R__ver_sk_run_filter not found in vmlinux.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 31383131
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__kmem_cache_alloc+160/240]    Not tainted
EIP:    0010:[<c012aa00>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 31383131   ebx: c158f5d8   ecx: d5667540  
esi: c158f5d0   edi: 00000246   ebp: 000001f0  
ds: 0018   es: 0018   ss: 0018
Process ircd (pid: 2342, stackpage=d8ad9000)
Stack: 000005a8 d86d8118 d9572c00 000001f0 d86d817c c788e2e0 c01b810a c158f5d0 
000001f0 d86d80c0 d86d80c0 c01d4749 00000680 000001f0 00000042 00000000 
d8ad9e28 00000000 d8ad8000 00000001 00000000 00000000 d86d8118 402bc4d8 
Call Trace:    [alloc_skb+170/448] [tcp_sendmsg+2297/4032] [inet_recvmsg+82/112] [inet_sendmsg+66/80] [sock_sendmsg+117/176]
Call Trace:    [<c01b810a>] [<c01d4749>] [<c01f1482>] [<c01f14e2>] [<c01b4c55>] [sockfd_lookup+28/128] [sockfd_lookup+28/128] [sys_sendto+227/256] [locate_hd_struct+56/144] [account_io_end+42/80] [req_finished_io+76/96] [<c01b4a6c>] [<c01b4a6c>] [<c01b5c93>] [<c0193968>] [<c0193a7a>] [<c0193bcc>] [sock_poll+44/64] [do_pollfd+79/144] [sys_send+55/64] [sys_socketcall+311/608] [system_call+51/56] [<c01b513c>] [<c014232f>] [<c01b5ce7>] [<c01b6557>] [<c010720b>]
Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 46 08 89 48 04 89 01 89 


>>EIP; c012aa00 <__kmem_cache_alloc+a0/f0>   <=====

>>ebx; c158f5d8 <_end+12dc514/205adf9c>
>>ecx; d5667540 <_end+153b447c/205adf9c>
>>esi; c158f5d0 <_end+12dc50c/205adf9c>

Trace; c01b810a <alloc_skb+aa/1c0>
Trace; c01d4749 <tcp_sendmsg+8f9/fc0>
Trace; c01f1482 <inet_recvmsg+52/70>
Trace; c01f14e2 <inet_sendmsg+42/50>
Trace; c01b4c55 <sock_sendmsg+75/b0>

Code;  c012aa00 <__kmem_cache_alloc+a0/f0>
00000000 <_EIP>:
Code;  c012aa00 <__kmem_cache_alloc+a0/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c012aa02 <__kmem_cache_alloc+a2/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c012aa05 <__kmem_cache_alloc+a5/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012aa0b <__kmem_cache_alloc+ab/f0>
   b:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012aa0e <__kmem_cache_alloc+ae/f0>
   e:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012aa11 <__kmem_cache_alloc+b1/f0>
  11:   89 01                     mov    %eax,(%ecx)
Code;  c012aa13 <__kmem_cache_alloc+b3/f0>
  13:   89 00                     mov    %eax,(%eax)

<1>Unable to handle kernel paging request at virtual address 31303838
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__kmem_cache_alloc+160/240]    Not tainted
EIP:    0010:[<c012aa00>]    Not tainted
EFLAGS: 00010006
eax: 31303838   ebx: c158f5d8   ecx: d5667540  
esi: c158f5d0   edi: 00000246   ebp: 000001f0  
ds: 0018   es: 0018   ss: 0018
Process gkrellmd (pid: 1754, stackpage=dd62d000)
Stack: 00000008 00000282 d7298780 000001f0 d86d8e7c cceeede0 c01b810a c158f5d0 000001f0 d86d8dc0 d86d8dc0 c01d4749 00000680 000001f0 00000002 ffffffff c48ab220 fffffff4 c0239638 c0239808 00000000 000001d2 d86d8e18 08063e48 
Call Trace:    [alloc_skb+170/448] [tcp_sendmsg+2297/4032] [inet_sendmsg+66/80] [sock_sendmsg+117/176] [sockfd_lookup+28/128]
Call Trace:    [<c01b810a>] [<c01d4749>] [<c01f14e2>] [<c01b4c55>] [<c01b4a6c>] [sys_sendto+227/256] [link_path_walk+1333/1664] [cp_new_stat64+247/288] [sys_send+55/64] [sys_socketcall+311/608] [math_state_restore+30/64] [<c01b5c93>] [<c013d4e5>] [<c013a3a7>] [<c01b5ce7>] [<c01b6557>] [<c010828e>] [system_call+51/56] [<c010720b>]
Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 46 08 89 48 04 89 01 89 


>>EIP; c012aa00 <__kmem_cache_alloc+a0/f0>   <=====

>>ebx; c158f5d8 <_end+12dc514/205adf9c>
>>ecx; d5667540 <_end+153b447c/205adf9c>
>>esi; c158f5d0 <_end+12dc50c/205adf9c>

Trace; c01b810a <alloc_skb+aa/1c0>
Trace; c01d4749 <tcp_sendmsg+8f9/fc0>
Trace; c01f14e2 <inet_sendmsg+42/50>
Trace; c01b4c55 <sock_sendmsg+75/b0>
Trace; c01b4a6c <sockfd_lookup+1c/80>

Code;  c012aa00 <__kmem_cache_alloc+a0/f0>
00000000 <_EIP>:
Code;  c012aa00 <__kmem_cache_alloc+a0/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c012aa02 <__kmem_cache_alloc+a2/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c012aa05 <__kmem_cache_alloc+a5/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012aa0b <__kmem_cache_alloc+ab/f0>
   b:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012aa0e <__kmem_cache_alloc+ae/f0>
   e:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012aa11 <__kmem_cache_alloc+b1/f0>
  11:   89 01                     mov    %eax,(%ecx)
Code;  c012aa13 <__kmem_cache_alloc+b3/f0>
  13:   89 00                     mov    %eax,(%eax)

<1>Unable to handle kernel paging request at virtual address 32333031
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[kmem_cache_reap+128/448]    Not tainted
EIP:    0010:[<c012a4f0>]    Not tainted
EFLAGS: 00010003
eax: 32333031   ebx: 00000001   ecx: c158f5d0  
esi: 00000000   edi: 00000001   ebp: c158f6a8  
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1599000)
Stack: c11c89d4 000001d0 c158f5d0 00000000 00000003 00000003 00000020 000001d0 c0239638 c0239638 c012b3ec c1599f84 000001d0 0000003c 00000020 c012b483 c1599f84 c1598000 00000000 00000000 c0239638 c1598000 c0239560 00000000 
Call Trace:    [shrink_caches+28/96] [try_to_free_pages_zone+83/224] [kswapd_balance_pgdat+94/160] [kswapd_balance+25/48] [kswapd+141/176]
Call Trace:    [<c012b3ec>] [<c012b483>] [<c012b62e>] [<c012b689>] [<c012b7ad>] [kswapd+0/176] [rest_init+0/64] [arch_kernel_thread+43/64] [kswapd+0/176] [<c012b720>] [<c0105000>] [<c010574b>] [<c012b720>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c012a4f0 <kmem_cache_reap+80/1c0>   <=====

>>ecx; c158f5d0 <_end+12dc50c/205adf9c>
>>ebp; c158f6a8 <_end+12dc5e4/205adf9c>

Trace; c012b3ec <shrink_caches+1c/60>
Trace; c012b483 <try_to_free_pages_zone+53/e0>
Trace; c012b62e <kswapd_balance_pgdat+5e/a0>
Trace; c012b689 <kswapd_balance+19/30>
Trace; c012b7ad <kswapd+8d/b0>


3 warnings issued.  Results may not be reliable.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="distcc.patch"

--- a/mm/page_alloc.c.orig 2004-04-29 17:38:14.184021976 -0300
+++ b/mm/page_alloc.c 2004-04-29 17:47:27.906843312 -0300
@@ -46,6 +46,34 @@
 
 int vm_gfp_debug = 0;
 
+static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
+
+static spinlock_t free_pages_ok_no_irq_lock = SPIN_LOCK_UNLOCKED;
+struct page * free_pages_ok_no_irq_head;
+
+static void do_free_pages_ok_no_irq(void * arg)
+{
+       struct page * page, * __page;
+
+       spin_lock_irq(&free_pages_ok_no_irq_lock);
+
+       page = free_pages_ok_no_irq_head;
+       free_pages_ok_no_irq_head = NULL;
+
+       spin_unlock_irq(&free_pages_ok_no_irq_lock);
+
+       while (page) {
+               __page = page;
+               page = page->next_hash;
+               __free_pages_ok(__page, __page->index);
+       }
+}
+
+static struct tq_struct free_pages_ok_no_irq_task = {
+       .routine        = do_free_pages_ok_no_irq,
+};
+
+
 /*
  * Temporary debugging check.
  */
@@ -81,7 +109,6 @@
  * -- wli
  */
 
-static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
  unsigned long index, page_idx, mask, flags;
@@ -94,8 +121,20 @@
   * a reference to a page in order to pin it for io. -ben
   */
  if (PageLRU(page)) {
-  if (unlikely(in_interrupt()))
-   BUG();
+  if (unlikely(in_interrupt())) {
+   unsigned long flags;
+
+   spin_lock_irqsave(&free_pages_ok_no_irq_lock, flags);
+   page->next_hash = free_pages_ok_no_irq_head;
+   free_pages_ok_no_irq_head = page;
+   page->index = order;
+ 
+   spin_unlock_irqrestore(&free_pages_ok_no_irq_lock, flags);
+ 
+   schedule_task(&free_pages_ok_no_irq_task);
+   return;
+  }
+  
   lru_cache_del(page);
  }

--gKMricLos+KVdGMg--
