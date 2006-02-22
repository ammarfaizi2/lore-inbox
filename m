Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWBVUcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWBVUcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWBVUcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:32:54 -0500
Received: from mout0.freenet.de ([194.97.50.131]:15550 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750765AbWBVUcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:32:54 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: PowerPC: Sleeping function called from invalid context at emulate_instruction()
Date: Wed, 22 Feb 2006 21:29:31 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Message-Id: <200602222129.31700.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1332879.bmkva5zc7q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1332879.bmkva5zc7q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On a powerPC 32bit, I got the following debugging assertion failure:

[  733.209827] Debug: sleeping function called from invalid context at arch=
/powerpc/kernel/traps.c:697
[  733.210682] in_atomic():0, irqs_disabled():1
[  733.211347] Call Trace:
[  733.211969] [D6023EB0] [C0007F84] show_stack+0x58/0x174 (unreliable)
[  733.212765] [D6023EE0] [C0022C34] __might_sleep+0xbc/0xd0
[  733.213523] [D6023EF0] [C000D158] program_check_exception+0x1d8/0x4fc
[  733.214309] [D6023F40] [C000E744] ret_from_except_full+0x0/0x4c
[  733.215076] --- Exception: 700 at 0x102a7100
[  733.215785]     LR =3D 0xdb9ef04

It is caused by the line
if (get_user(instword, (u32 __user *)(regs->nip)))
in arch/powerpc/kernel/traps.c:emulate_instruction()

I am not sure, if this is an indication for a bug, or just false alarm.
In case of false alarm, the debugging message should be made quiet
somehow, though.

=2D-=20
Greetings Michael.

--nextPart1332879.bmkva5zc7q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/Mmrlb09HEdWDKgRAsEfAKCMR/vtV/0vQnieMGXC3jb1QMaM/QCfXRbJ
hktcRfZ6Dj7XnUlhHGGlVWo=
=2Mp0
-----END PGP SIGNATURE-----

--nextPart1332879.bmkva5zc7q--
