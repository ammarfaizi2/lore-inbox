Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUHBNPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUHBNPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHBNPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:15:07 -0400
Received: from exeter-w-mailserver-fw.wrl.org ([209.96.177.100]:9641 "EHLO
	franklin.wrl.org") by vger.kernel.org with ESMTP id S266508AbUHBNOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:14:24 -0400
Date: Mon, 2 Aug 2004 09:14:19 -0400 (EDT)
From: Brett Charbeneau <brett@wrl.org>
To: linux-kernel@vger.kernel.org
Subject: Possible dcache BUG
Message-ID: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

	I am getting the oops below - twice since 7/26, but I haven't a 
clue what's causing it.
	I am not a subscriber, so any replies directed to me would be 
gratefully received.
	Thank you for your hard work on this!

-- 

Brett Charbeneau, Network Administrator         Tel: 757-259-7750
Williamsburg Regional Library                   FAX: 757-259-7798
7770 Croaker Road                               brett@wrl.org
Williamsburg, VA 23188-7064                     http://www.wrl.org


ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map (specified)

1151MB HIGHMEM available.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
kernel BUG at dcache.c:345!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014322d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00040000   ebx: eb8d7c70   ecx: c281b394   edx: e5636700
esi: eb8d7c58   edi: c281b394   ebp: d2b15f34   esp: d2b15f08
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 14814, stackpage=d2b15000)
Stack: c0128f81 c281b49c c281f000 00000246 d2b15f34 f721e1a0 00000466 f721e178 
       f721e178 f721e178 c02991c0 d2b15f44 c01435a6 00000150 f7b6f400 d2b15f5c 
       c013714f f721e178 d2b15f88 08052179 0804d82b d2b15f7c c013afea f7b6f400 
Call Trace:    [<c0128f81>] [<c01435a6>] [<c013714f>] [<c013afea>] [<c01472d0>]
  [<c01472ee>] [<c0106d93>]
Code: 0f 0b 59 01 1e d6 25 c0 8d 56 10 8b 4a 04 8b 46 10 89 48 04 


>>EIP; c014322d <prune_dcache+5d/140>   <=====

>>ebx; eb8d7c70 <_end+2b5bb734/384f6ac4>
>>ecx; c281b394 <_end+24fee58/384f6ac4>
>>edx; e5636700 <_end+2531a1c4/384f6ac4>
>>esi; eb8d7c58 <_end+2b5bb71c/384f6ac4>
>>edi; c281b394 <_end+24fee58/384f6ac4>
>>ebp; d2b15f34 <_end+127f99f8/384f6ac4>
>>esp; d2b15f08 <_end+127f99cc/384f6ac4>

Trace; c0128f81 <kmem_cache_free+1c1/270>
Trace; c01435a6 <shrink_dcache_parent+16/30>
Trace; c013714f <kill_super+5f/f0>
Trace; c013afea <path_release+2a/40>
Trace; c01472d0 <sys_umount+80/90>
Trace; c01472ee <sys_oldumount+e/20>
Trace; c0106d93 <system_call+33/38>

Code;  c014322d <prune_dcache+5d/140>
00000000 <_EIP>:
Code;  c014322d <prune_dcache+5d/140>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014322f <prune_dcache+5f/140>
   2:   59                        pop    %ecx
Code;  c0143230 <prune_dcache+60/140>
   3:   01 1e                     add    %ebx,(%esi)
Code;  c0143232 <prune_dcache+62/140>
   5:   d6                        (bad)  
Code;  c0143233 <prune_dcache+63/140>
   6:   25 c0 8d 56 10            and    $0x10568dc0,%eax
Code;  c0143238 <prune_dcache+68/140>
   b:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c014323b <prune_dcache+6b/140>
   e:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c014323e <prune_dcache+6e/140>
  11:   89 48 04                  mov    %ecx,0x4(%eax)

kernel BUG at dcache.c:345!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014322d>]    Not tainted
EFLAGS: 00010206
eax: 00040000   ebx: ea612c70   ecx: c281b394   edx: dd1f64bc
esi: ea612c58   edi: c281b394   ebp: c2825f00   esp: c2825ed4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c2825000)
Stack: 00000187 00000003 c2825ef4 c0128525 c281b418 d8728000 c281b418 00000006 
       00000000 c233bfb0 00000003 c2825f0c c01435e2 00000d1d c2825f4c c012a284 
       00000006 000001d0 c2824000 ffffffff 00012199 000001d0 c02970d0 c2825f50 
Call Trace:    [<c0128525>] [<c01435e2>] [<c012a284>] [<c012a462>] [<c012a501>]
  [<c012a580>] [<c012a739>] [<c012a7b6>] [<c012a8ff>] [<c012a860>] [<c0105000>]
  [<c01055b6>] [<c012a860>]
Code: 0f 0b 59 01 1e d6 25 c0 8d 56 10 8b 4a 04 8b 46 10 89 48 04 


>>EIP; c014322d <prune_dcache+5d/140>   <=====

>>ebx; ea612c70 <_end+2a2f6734/384f6ac4>
>>ecx; c281b394 <_end+24fee58/384f6ac4>
>>edx; dd1f64bc <_end+1ced9f80/384f6ac4>
>>esi; ea612c58 <_end+2a2f671c/384f6ac4>
>>edi; c281b394 <_end+24fee58/384f6ac4>
>>ebp; c2825f00 <_end+25099c4/384f6ac4>
>>esp; c2825ed4 <_end+2509998/384f6ac4>

Trace; c0128525 <__kmem_cache_shrink_locked+45/70>
Trace; c01435e2 <shrink_dcache_memory+22/40>
Trace; c012a284 <shrink_cache+294/370>
Trace; c012a462 <refill_inactive+102/170>
Trace; c012a501 <shrink_caches+31/40>
Trace; c012a580 <try_to_free_pages_zone+70/f0>
Trace; c012a739 <kswapd_balance_pgdat+59/b0>
Trace; c012a7b6 <kswapd_balance+26/40>
Trace; c012a8ff <kswapd+9f/c0>
Trace; c012a860 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01055b6 <arch_kernel_thread+26/40>
Trace; c012a860 <kswapd+0/c0>

Code;  c014322d <prune_dcache+5d/140>
00000000 <_EIP>:
Code;  c014322d <prune_dcache+5d/140>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014322f <prune_dcache+5f/140>
   2:   59                        pop    %ecx
Code;  c0143230 <prune_dcache+60/140>
   3:   01 1e                     add    %ebx,(%esi)
Code;  c0143232 <prune_dcache+62/140>
   5:   d6                        (bad)  
Code;  c0143233 <prune_dcache+63/140>
   6:   25 c0 8d 56 10            and    $0x10568dc0,%eax
Code;  c0143238 <prune_dcache+68/140>
   b:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c014323b <prune_dcache+6b/140>
   e:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c014323e <prune_dcache+6e/140>
  11:   89 48 04                  mov    %ecx,0x4(%eax)



