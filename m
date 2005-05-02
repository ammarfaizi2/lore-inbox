Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVEBPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVEBPcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEBPcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:32:24 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:15117 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261328AbVEBPcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:32:06 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Mon, 2 May 2005 17:31:57 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <20050501150624.7696fc31.akpm@osdl.org> <200505020801.31860.damir.perisa@solnet.ch>
In-Reply-To: <200505020801.31860.damir.perisa@solnet.ch>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1246204.dV6cbmMQsP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505021732.00590.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1246204.dV6cbmMQsP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 02 May 2005 08:01, Damir Perisa a =E9crit=A0:
> sure. i recompiled the kernel with magic keys and debugger activated
> [1], and kswapd0 does idle normally, now. it seems to solve my issue,
> but i don't know why.

now, running the debug-enabled kernel for some time (the whole day - ~7h=20
uptime), kswapd0 shows same sympthoms (started at around 4h uptime). it=20
is triggered later than before (where it started almost immediately after=20
boot), but now i get something more interesting from Regs:

[4314013.408000] SysRq : Show Regs
[4314013.408000]
[4314013.408000] Pid: 156, comm:              kswapd0
[4314013.408000] EIP: 0060:[<c05acc49>] CPU: 0
[4314013.408000] EIP is at _write_lock_irqsave+0x79/0xb0
[4314013.408000]  EFLAGS: 00000282    Not tainted  (2.6.12-rc3-mm2-ARCH)
[4314013.408000] EAX: c15e8ec0 EBX: efb9586c ECX: c15e8ee0 EDX: 00000001
[4314013.408000] ESI: efcc2000 EDI: efb9586c EBP: efcc3ee4 DS: 007b ES:=20
007b
[4314013.408000] CR0: 8005003b CR2: b58a4000 CR3: 254e6000 CR4: 00000690
[4314013.408000]  [<c0375be4>] __cachefs_block_put+0x24/0x80
[4314013.408000]  [<c037dae0>] cachefs_releasepage+0x60/0xc0
[4314013.408000]  [<c0154be2>] shrink_list+0x492/0x560
[4314013.408000]  [<c0154fc0>] shrink_cache+0xa0/0x1d0
[4314013.408000]  [<c01555fe>] shrink_zone+0xae/0xe0
[4314013.408000]  [<c0155af1>] balance_pgdat+0x261/0x3f0
[4314013.408000]  [<c013c7e0>] prepare_to_wait+0x20/0x70
[4314013.408000]  [<c0155d64>] kswapd+0xe4/0x140
[4314013.408000]  [<c013c910>] autoremove_wake_function+0x0/0x60
[4314013.408000]  [<c0103142>] ret_from_fork+0x6/0x14
[4314013.408000]  [<c013c910>] autoremove_wake_function+0x0/0x60
[4314013.408000]  [<c0155c80>] kswapd+0x0/0x140
[4314013.408000]  [<c0101225>] kernel_thread_helper+0x5/0x10

hope this helps to find out how to solve it.=20

greetings,
Damir

=2D-=20
It is much easier to suggest solutions when you know nothing about the=20
problem.

--nextPart1246204.dV6cbmMQsP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCdkfwPABWKV6NProRAqt/AKCaWbeFI6hV1at1GfAXxG5BUPl0QgCfcj4U
nYSlAhfJQs6o9h2QAo7Wz6c=
=spHh
-----END PGP SIGNATURE-----

--nextPart1246204.dV6cbmMQsP--
