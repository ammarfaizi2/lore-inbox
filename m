Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWIWPzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWIWPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIWPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:55:25 -0400
Received: from cweiske.de ([80.237.146.62]:33174 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S1751259AbWIWPzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:55:24 -0400
Message-ID: <45155915.7080107@cweiske.de>
Date: Sat, 23 Sep 2006 17:56:05 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at virtual
 address 000,0000a
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB6A4EDECAC48B518AE7A6B76"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6A4EDECAC48B518AE7A6B76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,


I have a reproducible BUG on my server that occurs whenever disk usage
gets too high / too much swapping occurs (at least I think that is). The
box has one reiserfs filesystem of about 187GB size, the disk is on an
Epia 5000 board, between them is a Promise Ultra 100 PCI IDE controller
card.


Any hints about how to resolve this problem are very welcome.


The trace from the serial console:
-------------
Oops: 0002 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c0112a54>]    Not tainted VLI
EFLAGS: 00010013   (2.6.18 #1)
EIP is at scheduler_tick+0x84/0x340
eax: 00000002   ebx: c7eec590   ecx: c5e960d5   edx: 4457222b
esi: c5e96100   edi: 0000002b   ebp: c7f43864   esp: c7f43850
ds: 007b   es: 007b   ss: 0068
Process  (pid: 6820, ti=3Dc7f42000 task=3Dc7eec590 task.ti=3D00000002)
Stack: 00000000 c7eec590 c7eec590 00000000 00000000 c7f438d0 c0120c83
c7f438d0
       00000000 c010597b 00000000 c04fbe00 c013d785 00000000 00000000
c7f438d0
       c056ea00 00000000 c04fbe00 c7f438d0 c013d833 00000000 c7f438d0
c04fbe00
Call Trace:
 [<c0120c83>] update_process_times+0x33/0x80
 [<c010597b>] timer_interrupt+0x3b/0x70
 [<c013d785>] handle_IRQ_event+0x35/0x70
 [<c013d833>] __do_IRQ+0x73/0x100
 [<c01047f5>] do_IRQ+0x25/0x50
 [<c0102e7a>] common_interrupt+0x1a/0x20
 [<c028300e>] _mmx_memcpy+0x6e/0x180
 [<c01b69f6>] leaf_copy_items+0x36/0x100
 [<c0282f1c>] memcpy+0x3c/0x50
 [<c0282f88>] memmove+0x38/0x50
 [<c01b72c5>] leaf_paste_in_buffer+0xa5/0x340
 [<c019fc4c>] balance_leaf+0x2cc/0x2e10
 [<c01af706>] get_parents+0x106/0x1a0
 [<c01a2ac1>] do_balance+0x61/0xf0
 [<c01b0d41>] wait_tb_buffers_until_unlocked+0x211/0x280
 [<c01b0f46>] fix_nodes+0x196/0x3d0
 [<c01bd3b6>] reiserfs_paste_into_item+0x196/0x1c0
 [<c01ab701>] reiserfs_allocate_blocks_for_region+0x971/0x13c0
 [<c01baea4>] search_for_position_by_key+0x134/0x330
 [<c013f6a6>] add_to_page_cache+0x46/0xc0
 [<c0162f92>] alloc_buffer_head+0x12/0x50
 [<c0160385>] alloc_page_buffers+0x65/0xc0
 [<c01a5606>] make_cpu_key+0x36/0x40
 [<c01b9b16>] pathrelse+0x26/0x40
 [<c01ad7a4>] reiserfs_file_write+0x694/0x720
 [<c01404f6>] __generic_file_aio_read+0x196/0x210
 [<c0140280>] file_read_actor+0x0/0xe0
 [<c012039c>] change_clocksource+0xc/0x140
 [<c0120b4d>] update_wall_time+0x18d/0x290
 [<c012b0c0>] autoremove_wake_function+0x0/0x40
 [<c0112c65>] scheduler_tick+0x295/0x340
 [<c015e254>] vfs_write+0x84/0x150
 [<c015e3cd>] sys_write+0x3d/0x70
 [<c0102c17>] syscall_call+0x7/0xb
Code: da 8b 5d f0 01 4b 50 11 53 54 39 1d 04 5d 5a c0 89 35 f8 5c 5a c0
89 3d fc
 5c 5a c0 74 12 a1 0c 5d 5a c0 39 43 30 74 1f 8b 43 04 <0f> ba 68 08 03
8d 65 f4
 5b 5e 5f 5d c3 eb 0d 90 90 90 90 90 90
EIP: [<c0112a54>] scheduler_tick+0x84/0x340 SS:ESP 0068:c7f43850
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual
address 000
0000a
 printing eip:
c01123b2
*pde =3D 00000000
Oops: 0002 [#2]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c01123b2>]    Not tainted VLI
EFLAGS: 00010097   (2.6.18 #1)
EIP is at try_to_wake_up+0x52/0xb0
eax: 00000002   ebx: cf79fa90   ecx: cf79fab8   edx: c7eec590
esi: c05a5ce0   edi: 00000000   ebp: c7f436c8   esp: c7f436b8
ds: 007b   es: 007b   ss: 0068
Process  (pid: 6820, ti=3Dc7f42000 task=3Dc7eec590 task.ti=3D00000002)
Stack: 00000012 00000000 c04fbfcc 00000001 c7f436ec c0112d66 cf79fa90
00000001
       00000000 00000000 c7f42000 00000000 00000012 c7f43714 c0112dc2
c04fbfcc
       00000001 00000001 00000000 00000000 000031f8 00000046 000031f8
fffff5d8
Call Trace:
 [<c0112d66>] __wake_up_common+0x36/0x70
 [<c0112dc2>] __wake_up+0x22/0x50
 [<c011786a>] release_console_sem+0xda/0x100
 [<c01175af>] vprintk+0x18f/0x2b0
 [<c01176b9>] vprintk+0x299/0x2b0
 [<c010323d>] show_stack_log_lvl+0x8d/0xb0
 [<c0112a68>] scheduler_tick+0x98/0x340
 [<c011740f>] printk+0xf/0x20
 [<c010ded3>] bust_spinlocks+0x43/0x50
 [<c0103575>] die+0x85/0x210
 [<c010e1c0>] do_page_fault+0x0/0x570
 [<c010e490>] do_page_fault+0x2d0/0x570
 [<c0112d66>] __wake_up_common+0x36/0x70
 [<c010e1c0>] do_page_fault+0x0/0x570
 [<c0102ec9>] error_code+0x39/0x40
 [<c0112a54>] scheduler_tick+0x84/0x340
 [<c0120c83>] update_process_times+0x33/0x80
 [<c010597b>] timer_interrupt+0x3b/0x70
 [<c013d785>] handle_IRQ_event+0x35/0x70
 [<c013d833>] __do_IRQ+0x73/0x100
 [<c01047f5>] do_IRQ+0x25/0x50
 [<c0102e7a>] common_interrupt+0x1a/0x20
 [<c028300e>] _mmx_memcpy+0x6e/0x180
 [<c01b69f6>] leaf_copy_items+0x36/0x100
 [<c0282f1c>] memcpy+0x3c/0x50
 [<c0282f88>] memmove+0x38/0x50
 [<c01b72c5>] leaf_paste_in_buffer+0xa5/0x340
 [<c019fc4c>] balance_leaf+0x2cc/0x2e10
 [<c01af706>] get_parents+0x106/0x1a0
 [<c01a2ac1>] do_balance+0x61/0xf0
 [<c01b0d41>] wait_tb_buffers_until_unlocked+0x211/0x280
 [<c01b0f46>] fix_nodes+0x196/0x3d0
 [<c01bd3b6>] reiserfs_paste_into_item+0x196/0x1c0
 [<c01ab701>] reiserfs_allocate_blocks_for_region+0x971/0x13c0
 [<c01baea4>] search_for_position_by_key+0x134/0x330
 [<c013f6a6>] add_to_page_cache+0x46/0xc0
 [<c0162f92>] alloc_buffer_head+0x12/0x50
 [<c0160385>] alloc_page_buffers+0x65/0xc0
 [<c01a5606>] make_cpu_key+0x36/0x40
 [<c01b9b16>] pathrelse+0x26/0x40
 [<c01ad7a4>] reiserfs_file_write+0x694/0x720
 [<c01404f6>] __generic_file_aio_read+0x196/0x210
 [<c0140280>] file_read_actor+0x0/0xe0
 [<c012039c>] change_clocksource+0xc/0x140
 [<c0120b4d>] update_wall_time+0x18d/0x290
 [<c012b0c0>] autoremove_wake_function+0x0/0x40
 [<c0112c65>] scheduler_tick+0x295/0x340
 [<c015e254>] vfs_write+0x84/0x150
 [<c015e3cd>] sys_write+0x3d/0x70
 [<c0102c17>] syscall_call+0x7/0xb
Code: 3d 83 f8 02 74 63 a8 40 75 62 6a 01 56 53 e8 f6 fe ff ff 8b 45 10
83 c4 0c
 85 c0 75 1c 8b 56 20 8b 42 1c 39 43 1c 7d 11 8b 42 04 <0f> ba 68 08 03
89 f6 8d
 bc 27 00 00 00 00 bf 01 00 00 00 c7 03
EIP: [<c01123b2>] try_to_wake_up+0x52/0xb0 SS:ESP 0068:c7f436b8
 <0>Kernel panic - not syncing: Fatal exception in interrupt
-------------


# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 533.373
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1068.09


# ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dojo 2.6.18 #1 PREEMPT Sat Sep 23 16:24:51 Local time zone must be
set--see  i686 VIA Samuel 2 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded




Please CC me as I am not subscribed.

--=20
Regards/MfG,
Christian Weiske


--------------enigB6A4EDECAC48B518AE7A6B76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFFVkZFMhaCCTq+CMRAumcAJ9QTQaFy8f2Ki8eVD98QKlPWEJlVwCg4GcL
UXozWkpCo4BntqYG1v2uq0Q=
=YnfS
-----END PGP SIGNATURE-----

--------------enigB6A4EDECAC48B518AE7A6B76--
