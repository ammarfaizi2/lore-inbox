Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268252AbTBMUC5>; Thu, 13 Feb 2003 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268132AbTBMUCz>; Thu, 13 Feb 2003 15:02:55 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:64555 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268252AbTBMUCw>;
	Thu, 13 Feb 2003 15:02:52 -0500
Date: Thu, 13 Feb 2003 12:04:45 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.60 and current bk oops in file_ra_state_init
Message-ID: <20030213120445.A15070@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Using the scsi-misc-2.5 (2.5.60 plus a few changes), or the current
bk (as of this morning) I'm hitting an oops in file_ra_state_init.

I was trying to run a bunch of raw IO's (/dev/raw/rawN) at once to several
(well 25) disks, trying to maximize IO's/second by repeatedly reading the
same block of a disk, and got the following oops. I hit this both on a
netfinity and NUMAQ box.

The oops does not always occur, but it is fairly easy to hit on the NUMAQ
(8 cpus).

The program I'm using reads one block, seeks to the start, and repeats.

I have not tried earlier kernels.

[patman@elm3b79 patman]$ <1>Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c013a389
*pde = 5a5a5a5a
Oops: 0000
CPU:    4
EIP:    0060:[<c013a389>]    Not tainted
EFLAGS: 00010246
EIP is at file_ra_state_init+0x19/0x30
eax: 6b6b6b6b   ebx: f329f374   ecx: 00000000   edx: f329f3c4
esi: f3f8c158   edi: f329f3e0   ebp: f3249f28   esp: f3249f24
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 2069, threadinfo=f3248000 task=f4660680)
Stack: ffffffe9 f3249f54 c0152d2e f329f3c4 f34a5988 c0110b65 00001000 f35b5000 
       00008000 f51f87a8 00000000 f35b5000 f3249f9c c0152cbc f322a0c4 f51f87a8 
       00008000 f322a0c4 f51f87a8 0000000e bffff6b0 000003f9 00000001 00000001 
Call Trace:
 [<c0152d2e>] dentry_open+0x5e/0x1d0
 [<c0110b65>] old_mmap+0x125/0x140
 [<c0152cbc>] filp_open+0x4c/0x60
 [<c0153125>] sys_open+0x35/0x80
 [<c01094db>] syscall_call+0x7/0xb

Code: 8b 00 89 42 18 5f 5d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 


Here's the first set of garbled oopses:


[patman@elm3b79 patman]$ Unable to handle kernel pa<g1>iUnnga brleqe uteos th anadtl vei krteuranel l adpdargiensgs  6rbeq6bu6ebs6tb<
4> a pt rvinirttinuagl e iapd:dr
ess c60b163ba368b69
b
*pd per <=1i >5Unna2atbcilnef g0t7 o1e
 haipnOdo:l
e<p1s c:>ke U010nra3n0eab03l0l 
e89 p
taCgo PhUi*:nagp n dd r lee e q7 =u
k e6ersb6tEnbeI6P<l:4b > p6a  b 
gati  0n0v6i0g: [rr<ct0ue1q3aal3u8 e9a>sd]d tr e   saNsot t6  tbavi6inbtre6tdu
bal6 EbaF
dLdAGrSe: s0s0  0p160r2bi4n6t
6inbg6 bei6bp:

EIP  cips0 1art3i anft3ii8lneg9_ r
ae_istpa:t
*ep_dien cit0+10=3x 16a93b/806x9
30
b6*bep6adbx
:e  6=b 66b6b6bb66bb 6 b e
bx: f3057ac4   ecx: 00000000   edx: f3057b14
esi: f3f8c518   edi: f3057b30   ebp: f3149f28   esp: f3149f24
ds: 007b   es: 007b   ss: 0068
Process reread_loop (pid: 1985, threadinfo=f3148000 task=f4509360)
Stack: ffffffe9 f3149f54 c0152d2e f3057b14 f34a5af4 f3149f44 00001000 f3018000 
       00000000 f51f87a8 00000003 f3018000 f3149f9c c0152cbc f322b34c f51f87a8 
       00000000 f322b34c f51f87a8 0000000e 40016000 00000402 00000001 00000001 
Call Trace:
 [<c0152d2e>] dentry_open+0x5e/0x1d0
 [<c0152cbc>] filp_open+0x4c/0x60
 [<c0153125>] sys_open+0x35/0x80
 [<c01094db>] syscall_call+0x7/0xb

Code: 8b 00 89 42 18 5f 5d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 
 Oops: 0000
CPU:    4
EIP:    0060:[<c013a389>]    Not tainted
EFLAGS: 00010246
EIP is at file_ra_state_init+0x19/0x30
eax: 6b6b6b6b   ebx: f3353be4   ecx: 00000000   edx: f3353c34
esi: f32ccbf8   edi: f3353c50   ebp: f3377f28   esp: f3377f24
ds: 007b   es: 007b   ss: 0068
Process reread_loop (pid: 1987, threadinfo=f3376000 task=f31f5320)
Stack: ffffffe9 f3377f54 c0152d2e f3353c34 f34a581c f3377f44 00001000 f2fcc000 
       00000000 f51f87a8 00000003 f2fcc000 f3377f9c c0152cbc f322a1d4 f51f87a8 
       00000000 f322a1d4 f51f87a8 0000000e 40016000 00000402 00000001 00000001 
Call Trace:
 [<c0152d2e>] dentry_open+0x5e/0x1d0
 [<c0152cbc>] filp_open+0x4c/0x60
 [<c0153125>] sys_open+0x35/0x80
 [<c01094db>] syscall_call+0x7/0xb

Code: 8b 00 89 42 18 5f 5d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 
 Oops: 0000
CPU:    2
EIP:    0060:[<c013a389>]    Not tainted
EFLAGS: 00010246
EIP is at file_ra_state_init+0x19/0x30
eax: 6b6b6b6b   ebx: f31a2d04   ecx: 00000000   edx: f31a2d54
esi: f32cc838   edi: f31a2d70   ebp: f3321f28   esp: f3321f24
ds: 007b   es: 007b   ss: 0068
Process reread_loop (pid: 1988, threadinfo=f3320000 task=f31f4d00)
Stack: ffffffe9 f3321f54 c0152d2e f31a2d54 f34a56b0 f3321f44 00001000 f34a8000 
       00000000 f51f87a8 00000003 f34a8000 f3321f9c c0152cbc f322a2e4 f51f87a8 
       00000000 f322a2e4 f51f87a8 0000000e 40016000 00000402 00000001 00000001 
Call Trace:
 [<c0152d2e>] dentry_open+0x5e/0x1d0
 [<c0152cbc>] filp_open+0x4c/0x60
 [<c0153125>] sys_open+0x35/0x80
 [<c01094db>] syscall_call+0x7/0xb

Code: 8b 00 89 42 18 5f 5d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 

-- Patrick Mansfield
