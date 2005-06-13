Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVFMW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVFMW0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFMWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:24:48 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:53688 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261530AbVFMWUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:20:53 -0400
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
From: Tom Duffy <tduffy@sun.com>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GUmXZw4iQW5OH3dV6w5L"
Date: Mon, 13 Jun 2005 15:20:45 -0700
Message-Id: <1118701245.9114.23.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GUmXZw4iQW5OH3dV6w5L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-13 at 16:47 -0500, Langsdorf, Mark wrote:
> Okay, I think I have figured this out.  During initialization,
> the cpufreq infrastruture only initializes the first core of
> each processor.  When a request comes into the second core,
> it's data structre is unitialized and we get the null point
> dereference.
>=20
> The solution is to assign the pointer to the data structure for
> the first core to all the other cores.
>=20
> Tom, could you try this patch and see if it helps?

Yes!  It fixed the panic.  I get much further.

Thanks!

Unfortunately, after starting cpuspeed daemon, I get this:

Starting cpuspeed: [  OK  ]
Starting pcmcia:  Starting PCMCIA services:
CPU 6: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 4129a3d70d
Kernel panic - not syncing: Machine check
 <1>Unable to handle kernel NULL pointer dereference at 00000000000000ff RI=
P:
[<00000000000000ff>]
PGD 41460067 PUD 3f12c067 PMD 0
Oops: 0010 [1] SMP
CPU 6
Modules linked in: video container button battery ac ohci_hcd ehci_hcd i2c_=
nforce2 i2c_core shpchp usbnet mii dm_snapshot dm_zero dm_mirror ext3 jbd d=
m_mod sata_nv libata mptscsih mptbase sd_mod scsi_mod
Pid: 1672, comm: usb.agent Tainted: G   M  2.6.12-rc6andro
RIP: 0010:[<00000000000000ff>] [<00000000000000ff>]
RSP: 0000:ffff81003fe63fa0  EFLAGS: 00010006
RAX: ffff81007f5b1fd8 RBX: 0000000000000008 RCX: 0000ffff0000ffff
RDX: 00000000000000ff RSI: 0000000000000008 RDI: 0000ffff0000ffff
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000004129a3cf88 R14: ffffffff80370a7d R15: 0000000000000001
FS:  00002aaaaaae0ee0(0000) GS:ffffffff80498400(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000000ff CR3: 000000003e7e5000 CR4: 00000000000006e0
Process usb.agent (pid: 1672, threadinfo ffff81007f5b0000, task ffff81007fd=
dcff0)
Stack: ffffffff8011ac99 ffffffff80370a7d ffffffff8010f247 ffff81007fea2c88 =
 <EOI>
       0000000000000005 0000000000000030 00000000000000fa 0000000000000000
       ffffffff8011a860 0000000000000000
Call Trace: <IRQ> <ffffffff8011ac99>{smp_call_function_interrupt+73}
       <ffffffff8010f247>{call_function_interrupt+99}  <EOI>  <#MC> <ffffff=
ff8011a860>{smp_really_stop_cpu+0}
       <ffffffff8011aa68>{smp_send_stop+72} <ffffffff80136ebc>{panic+140}
       <ffffffff80115ce8>{print_mce+136} <ffffffff80115db9>{mce_panic+137}
       <ffffffff8011643f>{do_machine_check+767} <ffffffff8010facb>{machine_=
check+127}
       <ffffffff8010f24c>{apic_timer_interrupt+0}  <EOE> <ffffffff801224dc>=
{do_page_fault+1196}
       <ffffffff801224d9>{do_page_fault+1193} <ffffffff8018c14e>{sys_newsta=
t+46}       <ffffffff8010f401>{error_exit+0}

Code:  Bad RIP value.
RIP [<00000000000000ff>] RSP <ffff81003fe63fa0>
CR2: 00000000000000ff
 <0>Kernel panic - not syncing: Oops

The machine resets itself after this.

-tduffy

--=-GUmXZw4iQW5OH3dV6w5L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrga9dY502zjzwbwRAhAAAJ9fwFLJbKI+jY2AwTMxP3pJAXWW6wCgnjaf
pkB/Nn7R5+x42IA+51Y5Zwg=
=BmyD
-----END PGP SIGNATURE-----

--=-GUmXZw4iQW5OH3dV6w5L--
