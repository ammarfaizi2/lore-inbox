Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSDBTeR>; Tue, 2 Apr 2002 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312899AbSDBTeJ>; Tue, 2 Apr 2002 14:34:09 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:49414 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S312904AbSDBTd4>; Tue, 2 Apr 2002 14:33:56 -0500
Date: Tue, 2 Apr 2002 12:33:48 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre5 - kernel BUG at page_alloc.c
Message-ID: <20020402123348.A20799@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from Alpha UP1500 (Nautilus) with a kernel based on 2.4.19-pre5
and somewhat modified in Nautilus specific parts to be bootable on that
machine at all.  I have seen similar incidents before and they seem to
be too repeateable just to chalk them to "not really stable yet" status
of the machine in question although what is in a register a4, i.e. a
string "ghijklmn", surely looks unusual.

Anyway, the box went catatonic but before doing that left in log
files a series of oopses which decoded look like that:

ksymoops 2.4.1 on alpha 2.4.19-pre5.ink.agp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5.ink.agp/ (default)
     -m /boot/System.map-2.4.19-pre5.ink.agp (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
kernel BUG at page_alloc.c:241!
run-parts(3421): Kernel Bug 1
pc = [rmqueue+888/1024]  ra = [rmqueue+876/1024]  ps = 0000    Not tainted
pc = [<fffffc0000845448>]  ra = [<fffffc000084543c>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000020  t0 = 0000000000000001  t1 = fffffc00de0a3ec8
t2 = 000000000000002a  t3 = 0000000000000001  t4 = fffffc0000af40c8
t5 = fffffc00d9184bc0  t6 = 0000000000000065  t7 = fffffc00bf4f8000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000000  a4 = 6e6d6c6b6a696867  a5 = 0000000000000002
t8 = fffffc0000af4d20  t9 = 0000000000004000  t10= fffffc0000af4d28
t11= fffffc0000af4d38  pv = fffffc0000820d30  at = 0000000000003fff
gp = fffffc0000ae8ce8  sp = fffffc00bf4fbd60
Trace:fffffc000084590c fffffc00008454fc fffffc0000836538 fffffc0000836604 fffffc0000837238 fffffc000081fec8 fffffc0000812e3c 
Code: 225f00f1  a77da708  6b5b7d5d  27ba002a  23bd38ac  00000081 <a04a0000> 44501001 

>>PC;  fffffc0000845448 <rmqueue+378/400>   <=====
Trace; fffffc000084590c <__alloc_pages+7c/260>
Trace; fffffc00008454fc <_alloc_pages+2c/40>
Trace; fffffc0000836538 <do_wp_page+a8/3e0>
Trace; fffffc0000836604 <do_wp_page+174/3e0>
Trace; fffffc0000837238 <handle_mm_fault+118/1c0>
Trace; fffffc000081fec8 <do_page_fault+208/4c0>
Trace; fffffc0000812e3c <entMM+9c/c0>
Code;  fffffc0000845430 <rmqueue+360/400>
0000000000000000 <_PC>:
Code;  fffffc0000845430 <rmqueue+360/400>
   0:   f1 00 5f 22       lda  a2,241(zero)
Code;  fffffc0000845434 <rmqueue+364/400>
   4:   08 a7 7d a7       ldq  t12,-22776(gp)
Code;  fffffc0000845438 <rmqueue+368/400>
   8:   5d 7d 5b 6b       jsr  ra,(t12),fffffffffffff580 <_PC+0xfffffffffffff580> fffffc00008449b0 <rw_swap_page_base+1b0/1e0>
Code;  fffffc000084543c <rmqueue+36c/400>
   c:   2a 00 ba 27       ldah gp,42(ra)
Code;  fffffc0000845440 <rmqueue+370/400>
  10:   ac 38 bd 23       lda  gp,14508(gp)
Code;  fffffc0000845444 <rmqueue+374/400>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc0000845448 <rmqueue+378/400>   <=====
  18:   00 00 4a a0       ldl  t1,0(s1)   <=====
Code;  fffffc000084544c <rmqueue+37c/400>
  1c:   01 10 50 44       and  t1,0x80,t0

kernel BUG at page_alloc.c:241!
diskcheck(3422): Kernel Bug 1
pc = [rmqueue+888/1024]  ra = [rmqueue+876/1024]  ps = 0000    Not tainted
pc = [<fffffc0000845448>]  ra = [<fffffc000084543c>]  ps = 0000    Not tainted
v0 = 0000000000000020  t0 = 0000000000000001  t1 = fffffc00de0a3ec8
t2 = 0000000000000028  t3 = 0000000000000001  t4 = fffffc0000af40c8
t5 = fffffc00d91843c0  t6 = 0000000000000065  t7 = fffffc00bf938000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000000  a4 = 6e6d6c6b6a696867  a5 = 0000000000000002
t8 = fffffc0000af4d20  t9 = 0000000000004000  t10= fffffc0000af4d28
t11= fffffc0000af4d38  pv = fffffc0000820d30  at = 0000000000003fff
gp = fffffc0000ae8ce8  sp = fffffc00bf93bd60
Trace:fffffc000084590c fffffc00008454fc fffffc0000836538 fffffc0000836604 fffffc0000837238 fffffc000081fec8 fffffc0000812e3c fffffc0000818c94 
Code: 225f00f1  a77da708  6b5b7d5d  27ba002a  23bd38ac  00000081 <a04a0000> 44501001 

>>PC;  fffffc0000845448 <rmqueue+378/400>   <=====
Trace; fffffc000084590c <__alloc_pages+7c/260>
Trace; fffffc00008454fc <_alloc_pages+2c/40>
Trace; fffffc0000836538 <do_wp_page+a8/3e0>
Trace; fffffc0000836604 <do_wp_page+174/3e0>
Trace; fffffc0000837238 <handle_mm_fault+118/1c0>
Trace; fffffc000081fec8 <do_page_fault+208/4c0>
Trace; fffffc0000812e3c <entMM+9c/c0>
Trace; fffffc0000818c94 <do_entInt+84/170>
Code;  fffffc0000845430 <rmqueue+360/400>
0000000000000000 <_PC>:
Code;  fffffc0000845430 <rmqueue+360/400>
   0:   f1 00 5f 22       lda  a2,241(zero)
Code;  fffffc0000845434 <rmqueue+364/400>
   4:   08 a7 7d a7       ldq  t12,-22776(gp)
Code;  fffffc0000845438 <rmqueue+368/400>
   8:   5d 7d 5b 6b       jsr  ra,(t12),fffffffffffff580 <_PC+0xfffffffffffff580> fffffc00008449b0 <rw_swap_page_base+1b0/1e0>
Code;  fffffc000084543c <rmqueue+36c/400>
   c:   2a 00 ba 27       ldah gp,42(ra)
Code;  fffffc0000845440 <rmqueue+370/400>
  10:   ac 38 bd 23       lda  gp,14508(gp)
Code;  fffffc0000845444 <rmqueue+374/400>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc0000845448 <rmqueue+378/400>   <=====
  18:   00 00 4a a0       ldl  t1,0(s1)   <=====
Code;  fffffc000084544c <rmqueue+37c/400>
  1c:   01 10 50 44       and  t1,0x80,t0

kernel BUG at page_alloc.c:241!
X(1207): Kernel Bug 1
pc = [rmqueue+888/1024]  ra = [rmqueue+876/1024]  ps = 0000    Not tainted
pc = [<fffffc0000845448>]  ra = [<fffffc000084543c>]  ps = 0000    Not tainted
v0 = 0000000000000020  t0 = 0000000000000001  t1 = fffffc00de0a3ec8
t2 = 0000000000000058  t3 = 0000000000000001  t4 = fffffc0000af40c8
t5 = fffffc0003d456c0  t6 = 0000000000000065  t7 = fffffc00dc12c000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000000  a4 = 6e6d6c6b6a696867  a5 = 0000000000000002
t8 = fffffc0000af4d20  t9 = 0000000000004000  t10= fffffc0000af4d28
t11= fffffc0000af4d38  pv = fffffc0000820d30  at = 0000000000003fff
gp = fffffc0000ae8ce8  sp = fffffc00dc12fd40
Trace:fffffc000084590c fffffc000099ef0c fffffc00008454fc fffffc0000836e68 fffffc0000836d98 fffffc0000836f0c fffffc00008371e8 fffffc000081fec8 fffffc0000812e3c 
Code: 225f00f1  a77da708  6b5b7d5d  27ba002a  23bd38ac  00000081 <a04a0000> 44501001 

>>PC;  fffffc0000845448 <rmqueue+378/400>   <=====
Trace; fffffc000084590c <__alloc_pages+7c/260>
Trace; fffffc000099ef0c <kfree_skbmem+1c/a0>
Trace; fffffc00008454fc <_alloc_pages+2c/40>
Trace; fffffc0000836e68 <do_anonymous_page+128/170>
Trace; fffffc0000836d98 <do_anonymous_page+58/170>
Trace; fffffc0000836f0c <do_no_page+5c/270>
Trace; fffffc00008371e8 <handle_mm_fault+c8/1c0>
Trace; fffffc000081fec8 <do_page_fault+208/4c0>
Trace; fffffc0000812e3c <entMM+9c/c0>
Code;  fffffc0000845430 <rmqueue+360/400>
0000000000000000 <_PC>:
Code;  fffffc0000845430 <rmqueue+360/400>
   0:   f1 00 5f 22       lda  a2,241(zero)
Code;  fffffc0000845434 <rmqueue+364/400>
   4:   08 a7 7d a7       ldq  t12,-22776(gp)
Code;  fffffc0000845438 <rmqueue+368/400>
   8:   5d 7d 5b 6b       jsr  ra,(t12),fffffffffffff580 <_PC+0xfffffffffffff580> fffffc00008449b0 <rw_swap_page_base+1b0/1e0>
Code;  fffffc000084543c <rmqueue+36c/400>
   c:   2a 00 ba 27       ldah gp,42(ra)
Code;  fffffc0000845440 <rmqueue+370/400>
  10:   ac 38 bd 23       lda  gp,14508(gp)
Code;  fffffc0000845444 <rmqueue+374/400>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc0000845448 <rmqueue+378/400>   <=====
  18:   00 00 4a a0       ldl  t1,0(s1)   <=====
Code;  fffffc000084544c <rmqueue+37c/400>
  1c:   01 10 50 44       and  t1,0x80,t0

kernel BUG at page_alloc.c:241!
X(3433): Kernel Bug 1
pc = [rmqueue+888/1024]  ra = [rmqueue+876/1024]  ps = 0000    Not tainted
pc = [<fffffc0000845448>]  ra = [<fffffc000084543c>]  ps = 0000    Not tainted
v0 = 0000000000000020  t0 = 0000000000000001  t1 = fffffc00de0a3ec8
t2 = 000000000000002c  t3 = 0000000000000001  t4 = fffffc0000af40c8
t5 = fffffc0003d45dc0  t6 = 0000000000000065  t7 = fffffc00d98e0000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000000  a4 = 6e6d6c6b6a696867  a5 = 0000000000000002
t8 = fffffc0000af4d20  t9 = 0000000000004000  t10= fffffc0000af4d28
t11= fffffc0000af4d38  pv = fffffc0000820d30  at = 0000000000003fff
gp = fffffc0000ae8ce8  sp = fffffc00d98e3d40
Trace:fffffc000084590c fffffc0000882630 fffffc00008454fc fffffc0000836e68 fffffc0000836d98 fffffc0000836f0c fffffc00008371e8 fffffc000081fec8 fffffc0000812e3c 
Code: 225f00f1  a77da708  6b5b7d5d  27ba002a  23bd38ac  00000081 <a04a0000> 44501001 

>>PC;  fffffc0000845448 <rmqueue+378/400>   <=====
Trace; fffffc000084590c <__alloc_pages+7c/260>
Trace; fffffc0000882630 <ext3_commit_write+1b0/220>
Trace; fffffc00008454fc <_alloc_pages+2c/40>
Trace; fffffc0000836e68 <do_anonymous_page+128/170>
Trace; fffffc0000836d98 <do_anonymous_page+58/170>
Trace; fffffc0000836f0c <do_no_page+5c/270>
Trace; fffffc00008371e8 <handle_mm_fault+c8/1c0>
Trace; fffffc000081fec8 <do_page_fault+208/4c0>
Trace; fffffc0000812e3c <entMM+9c/c0>
Code;  fffffc0000845430 <rmqueue+360/400>
0000000000000000 <_PC>:
Code;  fffffc0000845430 <rmqueue+360/400>
   0:   f1 00 5f 22       lda  a2,241(zero)
Code;  fffffc0000845434 <rmqueue+364/400>
   4:   08 a7 7d a7       ldq  t12,-22776(gp)
Code;  fffffc0000845438 <rmqueue+368/400>
   8:   5d 7d 5b 6b       jsr  ra,(t12),fffffffffffff580 <_PC+0xfffffffffffff580> fffffc00008449b0 <rw_swap_page_base+1b0/1e0>
Code;  fffffc000084543c <rmqueue+36c/400>
   c:   2a 00 ba 27       ldah gp,42(ra)
Code;  fffffc0000845440 <rmqueue+370/400>
  10:   ac 38 bd 23       lda  gp,14508(gp)
Code;  fffffc0000845444 <rmqueue+374/400>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc0000845448 <rmqueue+378/400>   <=====
  18:   00 00 4a a0       ldl  t1,0(s1)   <=====
Code;  fffffc000084544c <rmqueue+37c/400>
  1c:   01 10 50 44       and  t1,0x80,t0


1 warning issued.  Results may not be reliable.

Not that I can repeat that performance on demand. :-)

  Michal
