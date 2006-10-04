Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWJDDrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWJDDrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWJDDrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:47:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48258 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751089AbWJDDq7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:46:59 -0400
Message-Id: <200610040346.k943kvwM006684@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Steven Truong <midair77@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kexec / kdump kernel panic
In-Reply-To: Your message of "Tue, 03 Oct 2006 17:18:21 PDT."
             <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159933617_3990P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 23:46:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159933617_3990P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Oct 2006 17:18:21 PDT, Steven Truong said:

> /usr/sbin/kexec -p /boot/vmlinux
> --initrd=/boot/initrd-2.6.18-kdump.img --args-linux
> --append="root=/dev/sda3  irqpoll init 1"

If the /boot/vmlinux is the one you usually use to boot, that won't work.

Your usual vmlinux is almost certainly linked to load at the 1M line,
and you need a kernel linked to load at the 16M line (as set in crashkernel=).

See the CONFIG_PHYSICAL_START config option, and there's other details
in Documentation/kdump/kdump.txt - it looks like you have most of it right,
except you need to build *TWO* specially configured kernels (your production
one with KEXEC support and a few other things, and then the dump kernel
with a different PHYSICAL_START and a few settings).

--==_Exmh_1159933617_3990P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIy6xcC3lWbTT17ARAj6NAJ99YRx2xKN2RS8gkYFq0TMB4X+YHQCePO38
wXS6Jk/CG0bbyx6KveJK3lM=
=mvgd
-----END PGP SIGNATURE-----

--==_Exmh_1159933617_3990P--
