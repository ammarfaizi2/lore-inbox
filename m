Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKGWmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTKGW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:45 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:42980 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S264446AbTKGQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:13:14 -0500
Date: Fri, 7 Nov 2003 17:12:02 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ptrace + EFLAGS_RF
Message-Id: <20031107171202.02ac8a41.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__7_Nov_2003_17_12_02_+0100_rap8Ud6z9E+paBL8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__7_Nov_2003_17_12_02_+0100_rap8Ud6z9E+paBL8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

In arch/i386/kernel/ptrace.c the kernel defines which bits of the eflags
register user programs have access to using ptrace (PTRACE_SETREGS). Among
the "forbidden" bits is the resume flag (0x10000), i.e. the kernel masks
it out if userland sets it.

/* determines which flags the user has access to. */
/* 1 = access 0 = no access */
#define FLAG_MASK 0x00044dd5

When using hardware-assisted breakpoints via the debug registers (DR0...7),
it would be helpful if the debugger could set the resume flag in order not
to immediately hit the same breakpoint again at PTRACE_CONT/SYSCALL.

What is the motivation for disallowing user programs to set the RF flag?
I see no obvious reason how setting it could possibly screw the kernel.
Am I overlooking something?

Alternatively - what is the suggested approach to skip over breakpointed
instructions? Resetting the breakpoint, doing a singlestep and setting it
again doesn't seem very convenient to me.

Regards,
-Udo.

--Signature=_Fri__7_Nov_2003_17_12_02_+0100_rap8Ud6z9E+paBL8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/q8RWnhRzXSM7nSkRAkrkAJ9onIgmENioB7NXkBQV1s99hBxIHwCfWYCk
PELrnS08LF3aoo11/4wT+d4=
=uSYO
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Nov_2003_17_12_02_+0100_rap8Ud6z9E+paBL8--
