Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVKGVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVKGVoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVKGVoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:44:02 -0500
Received: from smtp04.auna.com ([62.81.186.14]:53958 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S965014AbVKGVoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:44:00 -0500
Date: Mon, 7 Nov 2005 22:43:07 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107224307.698da24b@werewolf.auna.net>
In-Reply-To: <20051107105257.333248c0.akpm@osdl.org>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
	<20051107020905.69c0b6dc.akpm@osdl.org>
	<17263.11214.992300.34384@cse.unsw.edu.au>
	<20051107023723.5cf63393.akpm@osdl.org>
	<436F3020.1040209@reub.net>
	<20051107105257.333248c0.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.99cvs17 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_12s=PqIcc=hHbLpfR88p2/4";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Mon, 7 Nov 2005 22:43:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_12s=PqIcc=hHbLpfR88p2/4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Nov 2005 10:52:57 -0800, Andrew Morton <akpm@osdl.org> wrote:

> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> >  Debug: sleeping function called from invalid context at include/asm/se=
maphore.h:99
> >  in_atomic():1, irqs_disabled():1
> >    [<c0103c46>] dump_stack+0x17/0x19
> >    [<c011a173>] __might_sleep+0x9c/0xae
> >    [<c028f82b>] scsi_disk_get_from_dev+0x15/0x48
> >    [<c029006e>] sd_prepare_flush+0x17/0x5a
> >    [<c027f8ff>] scsi_prepare_flush_fn+0x30/0x33
> >    [<c0259da0>] blk_start_pre_flush+0xd5/0x13f
> >    [<c025936b>] elv_next_request+0x113/0x170
> >    [<c027fd45>] scsi_request_fn+0x4b/0x2fd
> >    [<c025b393>] blk_run_queue+0x2b/0x3c
> >    [<c027f0b3>] scsi_run_queue+0xa4/0xb6
> >    [<c027f11f>] scsi_next_command+0x16/0x19
> >    [<c027f1db>] scsi_end_request+0x93/0xc5
> >    [<c027f494>] scsi_io_completion+0x141/0x46b
> >    [<c02901e9>] sd_rw_intr+0x117/0x22b
> >    [<c027ae5f>] scsi_finish_command+0x7f/0x93
> >    [<c027ad43>] scsi_softirq+0xa8/0x11a
> >    [<c0121eb8>] __do_softirq+0x88/0x141
> >    [<c0104fd9>] do_softirq+0x77/0x81
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    [<c012205a>] irq_exit+0x48/0x4a
> >    [<c0104e84>] do_IRQ+0x74/0xa7
> >    [<c010374e>] common_interrupt+0x1a/0x20
> >    [<f8918c04>] acpi_processor_idle+0x11f/0x2c7 [processor]
> >    [<c0100d71>] cpu_idle+0x49/0xa0
> >    [<c01002d7>] rest_init+0x37/0x39
> >    [<c03fd8c5>] start_kernel+0x166/0x179
> >    [<c0100210>] 0xc0100210
>=20
> ah-hah, that's a different trace.
>=20
> sd_issue_flush() has been altered to run scsi_disk_get_from_dev(), which
> takes a semaphore.  It does this from within spinlock and, as we see here,
> from within softirq.
>=20

fwiw, I get this on a RADI5 SATA setup:

Nov  7 15:57:35 nada kernel: scheduling while atomic: swapper/0x00000200/0
Nov  7 15:57:35 nada kernel:  [schedule+1599/2032] schedule+0x63f/0x7f0
Nov  7 15:57:35 nada kernel:  [<b037e00f>] schedule+0x63f/0x7f0
Nov  7 15:57:35 nada kernel:  [ata_qc_issue+83/144] ata_qc_issue+0x53/0x90
Nov  7 15:57:35 nada kernel:  [<b02d9ce3>] ata_qc_issue+0x53/0x90
Nov  7 15:57:35 nada kernel:  [ata_scsi_translate+93/272] ata_scsi_translat=
e+0x5d/0x110
Nov  7 15:57:35 nada kernel:  [<b02dc9bd>] ata_scsi_translate+0x5d/0x110
Nov  7 15:57:35 nada kernel:  [scsi_done+0/32] scsi_done+0x0/0x20
Nov  7 15:57:35 nada kernel:  [<b02c3250>] scsi_done+0x0/0x20
Nov  7 15:57:35 nada kernel:  [__down+235/304] __down+0xeb/0x130
Nov  7 15:57:35 nada kernel:  [<b037f52b>] __down+0xeb/0x130
Nov  7 15:57:35 nada kernel:  [default_wake_function+0/16] default_wake_fun=
ction+0x0/0x10
Nov  7 15:57:35 nada kernel:  [<b0118350>] default_wake_function+0x0/0x10
Nov  7 15:57:35 nada kernel:  [__sched_text_start+7/12] __down_failed+0x7/0=
xc
Nov  7 15:57:35 nada kernel:  [<b037d96f>] __down_failed+0x7/0xc
Nov  7 15:57:35 nada kernel:  [sd_prepare_flush+0/112] sd_prepare_flush+0x0=
/0x70
Nov  7 15:57:35 nada kernel:  [<b02df230>] sd_prepare_flush+0x0/0x70
Nov  7 15:57:35 nada kernel:  [.text.lock.sd+43/129] .text.lock.sd+0x2b/0x81
Nov  7 15:57:35 nada kernel:  [<b02e06ca>] .text.lock.sd+0x2b/0x81
Nov  7 15:57:35 nada kernel:  [sd_prepare_flush+30/112] sd_prepare_flush+0x=
1e/0x70
Nov  7 15:57:35 nada kernel:  [<b02df24e>] sd_prepare_flush+0x1e/0x70
Nov  7 15:57:35 nada kernel:  [scsi_prepare_flush_fn+44/48] scsi_prepare_fl=
ush_fn+0x2c/0x30
Nov  7 15:57:35 nada kernel:  [<b02c85dc>] scsi_prepare_flush_fn+0x2c/0x30
Nov  7 15:57:35 nada kernel:  [blk_start_post_flush+183/272] blk_start_post=
_flush+0xb7/0x110
Nov  7 15:57:35 nada kernel:  [<b02965e7>] blk_start_post_flush+0xb7/0x110
Nov  7 15:57:35 nada kernel:  [__blk_complete_barrier_rq+108/160] __blk_com=
plete_barrier_rq+0x6c/0xa0
Nov  7 15:57:35 nada kernel:  [<b02966ac>] __blk_complete_barrier_rq+0x6c/0=
xa0
Nov  7 15:57:35 nada kernel:  [blk_complete_barrier_rq+15/32] blk_complete_=
barrier_rq+0xf/0x20
Nov  7 15:57:35 nada kernel:  [<b02966ef>] blk_complete_barrier_rq+0xf/0x20
Nov  7 15:57:35 nada kernel:  [scsi_io_completion+77/1168] scsi_io_completi=
on+0x4d/0x490
Nov  7 15:57:35 nada kernel:  [<b02c803d>] scsi_io_completion+0x4d/0x490
Nov  7 15:57:35 nada kernel:  [sd_rw_intr+85/608] sd_rw_intr+0x55/0x260
Nov  7 15:57:35 nada kernel:  [<b02df325>] sd_rw_intr+0x55/0x260
Nov  7 15:57:35 nada kernel:  [__wake_up+56/80] __wake_up+0x38/0x50
Nov  7 15:57:35 nada kernel:  [<b0118408>] __wake_up+0x38/0x50
Nov  7 15:57:35 nada kernel:  [scsi_finish_command+121/160] scsi_finish_com=
mand+0x79/0xa0
Nov  7 15:57:35 nada kernel:  [<b02c34c9>] scsi_finish_command+0x79/0xa0
Nov  7 15:57:35 nada kernel:  [scsi_softirq+183/304] scsi_softirq+0xb7/0x130
Nov  7 15:57:35 nada kernel:  [<b02c3397>] scsi_softirq+0xb7/0x130
Nov  7 15:57:35 nada kernel:  [__rcu_process_callbacks+86/208] __rcu_proces=
s_callbacks+0x56/0xd0
Nov  7 15:57:35 nada kernel:  [<b012e5f6>] __rcu_process_callbacks+0x56/0xd0
Nov  7 15:57:35 nada kernel:  [__do_softirq+114/224] __do_softirq+0x72/0xe0
Nov  7 15:57:35 nada kernel:  [<b01220e2>] __do_softirq+0x72/0xe0
Nov  7 15:57:35 nada kernel:  [do_softirq+91/96] do_softirq+0x5b/0x60
Nov  7 15:57:35 nada kernel:  [<b01051fb>] do_softirq+0x5b/0x60
Nov  7 15:57:35 nada kernel:  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Nov  7 15:57:35 nada kernel:  [do_IRQ+73/112] do_IRQ+0x49/0x70
Nov  7 15:57:35 nada kernel:  [<b01050c9>] do_IRQ+0x49/0x70
Nov  7 15:57:35 nada kernel:  [common_interrupt+26/32] common_interrupt+0x1=
a/0x20
Nov  7 15:57:35 nada kernel:  [<b0103892>] common_interrupt+0x1a/0x20
Nov  7 15:57:35 nada kernel:  [default_idle+0/96] default_idle+0x0/0x60
Nov  7 15:57:35 nada kernel:  [<b0100d30>] default_idle+0x0/0x60
Nov  7 15:57:35 nada kernel:  [default_idle+44/96] default_idle+0x2c/0x60
Nov  7 15:57:35 nada kernel:  [<b0100d5c>] default_idle+0x2c/0x60
Nov  7 15:57:35 nada kernel:  [cpu_idle+94/128] cpu_idle+0x5e/0x80
Nov  7 15:57:35 nada kernel:  [<b0100e0e>] cpu_idle+0x5e/0x80


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_12s=PqIcc=hHbLpfR88p2/4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDb8prRlIHNEGnKMMRAo4wAJ9dkYDsq1v4zl/T/s04MeyYT3Hp1wCfRR6n
Otq7ylF4wopx0XX8fvBHUIU=
=fqOC
-----END PGP SIGNATURE-----

--Sig_12s=PqIcc=hHbLpfR88p2/4--
