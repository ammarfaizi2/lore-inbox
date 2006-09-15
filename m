Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWIOMlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIOMlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWIOMlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:41:09 -0400
Received: from systemlinux.org ([83.151.29.59]:17631 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1751342AbWIOMlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:41:07 -0400
Date: Fri, 15 Sep 2006 14:40:43 +0200
From: Andre Noll <maan@systemlinux.org>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: 2.6.18-rc5 page_to_pfn: Unable to handle kernel NULL pointer dereference
Message-ID: <20060915124043.GA20462@skl-net.de>
References: <20060908073125.GA23642@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20060908073125.GA23642@skl-net.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:31, Andre Noll wrote:
> The following just happend to one of our 8-way Opteron cluster nodes
> (nfs client version 3, solaris nfs server).

The problem is still present in 2.6.18-rc7. This time it happend on a
2-processor Opteron machine:

Pid: 945, comm: sge_execd Not tainted 2.6.18-rc7-tt64-6-g1883c5ab #4
RIP: 0010:[<ffffffff80150cad>]  [<ffffffff80150cad>] page_to_pfn+0x0/0x33
RSP: 0018:ffff8100fac73bb0  EFLAGS: 00010283
RAX: 0000000000000a57 RBX: 00000000000004ae RCX: 0000000000000a57
RDX: ffff8100fac73bf0 RSI: ffff8101b9b1c540 RDI: 0000000000000000
RBP: 00000000000005a9 R08: ffff8101f7aa31d0 R09: ffff8101f7aa3040
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000b52
R13: ffff8100fac73bf8 R14: 0000000000002000 R15: ffff8101f7aa32e8
FS:  00002b83ded037a0(0000) GS:ffff8101000dc540(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000fad78000 CR4: 00000000000006a0
Process sge_execd (pid: 945, threadinfo ffff8100fac72000, task ffff810004be=
5180)
Stack:  ffffffff801d6276 ffff8101fc4f0440 ffff8101b9b1c3c0 0000000000000a57
 ffff8101f7aa31d0 00000000000005a9 ffffffff801d64fc 0000000000000001
 ffff8101ffec2e18 0000000000000000 ffff8101f7aa31d0 ffff8101ffec2e18
Call Trace:
 [<ffffffff801d6276>] nfs_readpage_truncate_uninitialised_page+0x76/0xeb
 [<ffffffff801d64fc>] nfs_readpage_sync+0x211/0x253
 [<ffffffff801d6f89>] nfs_readpage+0x118/0x151
 [<ffffffff8014c6fe>] do_generic_mapping_read+0x1ec/0x398
 [<ffffffff8014c8aa>] file_read_actor+0x0/0xd1
 [<ffffffff8014caf2>] __generic_file_aio_read+0x177/0x1b0
 [<ffffffff8014cb5f>] generic_file_aio_read+0x34/0x39
 [<ffffffff801cf3eb>] nfs_file_read+0x84/0x93
 [<ffffffff8016e0fc>] do_sync_read+0xc9/0x106
 [<ffffffff8013e5fd>] autoremove_wake_function+0x0/0x2e
 [<ffffffff8015bf32>] do_mmap_pgoff+0x5fd/0x6de
 [<ffffffff8016e1e6>] vfs_read+0xad/0x14c
 [<ffffffff8016e520>] sys_read+0x45/0x6e
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 48 8b 07 48 c1 e8 3a 48 8b 14 c5 c0 79 5f 80 48 b8 b7 6d db=20
RIP  [<ffffffff80150cad>] page_to_pfn+0x0/0x33
 RSP <ffff8100fac73bb0>
CR2: 0000000000000000

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFCp9LWto1QDEAkw8RAthNAJ4uFGdDXnRPD8hMlJ0cL3R/4Nk38QCeJ7Qf
62TPfDu9ghc5swNp909BIsE=
=3lab
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
