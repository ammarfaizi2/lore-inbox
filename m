Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTEEOj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTEEOj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:39:26 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:12843 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262278AbTEEOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:39:23 -0400
Date: Mon, 05 May 2003 10:48:08 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.69: ipv6, irq, pcmcia trouble (oops)
To: linux-kernel@vger.kernel.org
Message-id: <20030505144808.GA18518@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=GvXjxJ+pjyke8COw;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

modprobe pf-net-17 (af_packet) gets stuck during boot and just sits
there looping and sucking up cpu.

during start up of init programs:
---
Linux version 2.5.69 (root@butterfly) (gcc version 3.2.3) #2 Mon May 5 09:4=
1:52 EDT 2003
------------[ cut here ]------------
kernel BUG at include/linux/module.h:284!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<d8b4d3f4>]    Not tainted
EFLAGS: 00010246
EIP is at inet6_create+0x394/0x440 [ipv6]
eax: 00000000   ebx: 0000003a   ecx: 00000000   edx: d8b7e900
esi: d50a4000   edi: d8b7cdc0   ebp: d50a5f08   esp: d50a5ee8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 765, threadinfo=3Dd50a4000 task=3Dd5177340)
Stack: d8b7e900 d503ab20 0000039c d7d89460 d503ab20 00000001 0000000a 00000=
003=20
       d50a5f54 c0254d1c d515be20 0000003a 0000003a d8b7e160 d515be20 fffff=
f9f=20
       d50a5f50 c0122964 d8b7e100 d7fc4240 d7fc4240 00000003 0000416d d654b=
820=20
Call Trace:
 [<d8b7e900>] +0x0/0xe0 [ipv6]
 [<c0254d1c>] sock_create+0x10c/0x2d0
 [<d8b7e160>] ipv6_root_table+0x0/0x60 [ipv6]
 [<c0122964>] register_proc_table+0x94/0x130
 [<d8b7e100>] ipv6_net_table+0x0/0x60 [ipv6]
 [<d8b7e900>] +0x0/0xe0 [ipv6]
 [<d89597dd>] icmpv6_init+0x2d/0x100 [ipv6]
 [<d8b7f428>] __icmpv6_socket+0x0/0x4 [ipv6]
 [<d8b7e900>] +0x0/0xe0 [ipv6]
 [<d89591cb>] inet6_init+0x14b/0x320 [ipv6]
 [<d8b7cda8>] inet6_family_ops+0x0/0x18 [ipv6]
 [<c0132ea9>] sys_init_module+0x109/0x1c0
 [<d8b7e900>] +0x0/0xe0 [ipv6]
 [<c010a33b>] syscall_call+0x7/0xb

Code: 0f 0b 1c 01 5c 28 b7 d8 e9 ba fd ff ff 0f 0b 1e 01 73 28 b7=20
---
=20

on hard eject of pcmcia modem/nic card (3ccfem556).
---
irq 3: nobody cared!
Call Trace:
 [<c010bc99>] handle_IRQ_event+0x99/0x120
 [<c010beec>] do_IRQ+0x9c/0x130
 [<c010a4a8>] common_interrupt+0x18/0x20
 [<c01d3e82>] pci_bus_read_config_word+0x72/0x90
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abc80e>] yenta_set_socket+0x5e/0x1d0 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abd051>] yenta_clear_maps+0x51/0x90 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8b0f490>] dead_socket+0x0/0xc [pcmcia_core]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abd24c>] yenta_init+0x1c/0x30 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abd6b4>] ti_init+0x14/0x30 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abc036>] +0x36/0x40 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8b06a9c>] init_socket+0x2c/0x30 [pcmcia_core]
 [<d8b06e27>] shutdown_socket+0x17/0x100 [pcmcia_core]
 [<d8b0737b>] parse_events+0xcb/0x130 [pcmcia_core]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abcd8d>] yenta_bh+0x4d/0x60 [yenta_socket]
 [<d8abf1d8>] +0x38/0x840 [yenta_socket]
 [<d8abf1d4>] +0x34/0x840 [yenta_socket]
 [<c012c4d0>] worker_thread+0x1f0/0x2d0
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abf1a0>] +0x0/0x840 [yenta_socket]
 [<d8abcd40>] yenta_bh+0x0/0x60 [yenta_socket]
 [<c011a260>] default_wake_function+0x0/0x20
 [<c010a212>] ret_from_fork+0x6/0x14
 [<c011a260>] default_wake_function+0x0/0x20
 [<c012c2e0>] worker_thread+0x0/0x2d0
 [<c010826d>] kernel_thread_helper+0x5/0x18
handlers:
[<d8afc450>] (el3_interrupt+0x0/0x270 [3c574_cs])
Trying to free nonexistent resource <000003e8-000003ef>
---

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tnmoCGPRljI8080RAiS/AJ4923V4LDSP66oUlQeZS9wG85klOgCeJ8of
eY7VCTtwG5xWHJTyXVowIiU=
=ip+p
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
