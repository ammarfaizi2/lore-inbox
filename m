Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTLSNxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTLSNxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:53:51 -0500
Received: from ik-dynamic-66-102-65-15.kingston.net ([66.102.65.15]:11906 "EHLO
	linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S262868AbTLSNxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:53:43 -0500
Subject: Re: oops with 2.6.0 on IBM 600X
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20031219132806.GO31393@holomorphy.com>
References: <pan.2003.12.19.13.22.08.801900@interlinx.bc.ca>
	 <20031219132806.GO31393@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3QKOiC81ah7EuVYxv2LP"
Message-Id: <1071842015.5759.64.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-1mdk 
Date: Fri, 19 Dec 2003 08:53:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3QKOiC81ah7EuVYxv2LP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-12-19 at 08:28, William Lee Irwin III wrote:
> On Fri, Dec 19, 2003 at 08:22:09AM -0500, Brian J. Murrell wrote:
> > Trying to boot 2.6.0 on an IBM 600X (I have seen a report of the same w=
ith
> > a 600E as well) I get the following 100% reproducable error and stack t=
race:
> > devfs_remove: ide/host0/bus0/target0/lun0 not found, cannot remove
>=20
> devfs is not really in a state to be used (maybe it should be removed);
> could you try without?

The same kernels that cause this problem on my IBM laptop do not cause
the same problems on my desktop Athlon 800 (Thunderbird) machine, so
this has to be some strange interaction with this hardware, no?

In any case, with a devfs enabled kernel booted with "devfs=3Dnomount"
causes the same problem.

A non-devfs enabled kernel no error message regarding devfs and no stack
trace from it, but I still get an oops:

hdc: CRN-8241B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
8
 printing eip:
c0184e78
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0184e78>]    Not tainted
EFLAGS: 00010282
EIP is at sysfs_hash_and_remove+0x8/0x69
eax: 00000000   ebx: c03f589c   ecx: c03f58c8   edx: 00000000
esi: 00000000   edi: c03f5700   ebp: cbf997dc   esp: cbf997d4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=3Dcbf98000 task=3Dcbe2b8c0)
Stack: c03f589c c0347ef8 cbf997f4 c01fe58c 00000000 c03f58c8 c03f589c c03f5=
c48=20
       cbf99808 c01fe6d4 c03f589c c03f589c c03f5c48 cbf9981c c01fd754 c03f5=
89c=20
       c03f589c 00000001 cbf9982c c01fd7ad c03f589c c03f57ac cbf99e60 c0220=
d23=20
Call Trace:
 [<c01fe58c>] device_release_driver+0x1c/0x60
 [<c01fe6d4>] bus_remove_device+0x44/0x80
 [<c01fd754>] device_del+0x54/0xa0
 [<c01fd7ad>] device_unregister+0xd/0x20
 [<c0220d23>] ide_unregister+0x683/0x810
 [<c011dbd9>] recalc_task_prio+0xf9/0x200
 [<c011dd88>] try_to_wake_up+0xa8/0x140
 [<c011eb36>] __wake_up_common+0x26/0x50
 [<c0128479>] __mod_timer+0x59/0x80
 [<c022ab00>] cursor_timer_handler+0x0/0x30
 [<c022ab2a>] cursor_timer_handler+0x2a/0x30
 [<c0128b58>] run_timer_softirq+0xa8/0x160
 [<c0128a7c>] update_process_times+0x2c/0x40
 [<c0122473>] profile_hook+0x13/0x18
 [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
 [<c0128a7c>] update_process_times+0x2c/0x40
 [<c0128a7c>] update_process_times+0x2c/0x40
 [<c0122473>] profile_hook+0x13/0x18
 [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
 [<c0110f36>] timer_interrupt+0xb6/0xe0
 [<c013d54d>] buffered_rmqueue+0xad/0x120
 [<c013d652>] __alloc_pages+0x92/0x320
 [<c013d54d>] buffered_rmqueue+0xad/0x120
 [<c013d652>] __alloc_pages+0x92/0x320
 [<c013d1aa>] __rmqueue+0xda/0x140
 [<c022105a>] ide_register_hw+0x14a/0x170
 [<c0227e31>] idepnp_probe+0x61/0x90
 [<c0184d25>] sysfs_new_inode+0x55/0x90
 [<c01dc406>] compare_pnp_id+0x86/0xa0
 [<c01dc44d>] match_device+0x2d/0x50
 [<c01dc542>] pnp_device_probe+0x72/0x90
 [<c01fe3ff>] bus_match+0x2f/0x70
 [<c01fe51f>] driver_attach+0x3f/0x90
 [<c01fe76e>] bus_add_driver+0x5e/0xa0
 [<c01feb6f>] driver_register+0x2f/0x40
 [<c01dc5fa>] pnp_register_driver+0x2a/0x60
 [<c039a41a>] probe_for_hwifs+0x1a/0x20
 [<c039a428>] ide_init_builtin_drivers+0x8/0x20
 [<c039a476>] ide_init+0x36/0x50
 [<c0380742>] do_initcalls+0x22/0x90
 [<c0105089>] init+0x29/0xe0
 [<c0105060>] init+0x0/0xe0
 [<c0109275>] kernel_thread_helper+0x5/0x10

Code: 8b 46 08 8d 48 68 ff 48 68 78 56 8b 4d 0c 51 56 e8 83 ff ff=20
 <0>Kernel panic: Attempted to kill init!
=20

b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-3QKOiC81ah7EuVYxv2LP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4wLdl3EQlGLyuXARAk4qAKDJB71Cf16KeBdDSYxmIbk9gK4laACg3ZtU
+DWMFMrGSf+rkdhb+twmKeA=
=hmyt
-----END PGP SIGNATURE-----

--=-3QKOiC81ah7EuVYxv2LP--

