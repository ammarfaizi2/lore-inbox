Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUIMOrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUIMOrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUIMOrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:47:01 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:1507 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267455AbUIMOpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:45:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Constantine Gavrilov <constg@qlusters.com>
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Date: Mon, 13 Sep 2004 16:44:54 +0200
User-Agent: KMail/1.6.2
Cc: bugs@x86-64.org, linux-kernel@vger.kernel.org
References: <4145A8E1.8010409@qlusters.com>
In-Reply-To: <4145A8E1.8010409@qlusters.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_mJbRBFZ4cYVlyRx";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131644.54441.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_mJbRBFZ4cYVlyRx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 13. September 2004 16:04, Constantine Gavrilov wrote:
> We have a piece of kernel code that calls some system calls in kernel=20
> context (from a process with mm and a daemonized kernel thread that does=
=20
> not have mm). This works fine on IA64 and i386 architectures.

You can find the list of system calls that are supposed to work
from kernel space in asm/unistd.h inside #ifdef __KERNEL__SYSCALLS__.
On current kernels, that list only contains execve(), which should
be avoided as well in favor of call_usermodehelper. Other calls
might work on some architectures but that is not a supported
interface any more.

You could call the sys_* functions directly if they are exported,
but it is unlikely that such code gets integrated in the mainline
kernel.

The real answer for your problem highly depends on which syscalls
you want to use.

	Arnd <><

--Boundary-02=_mJbRBFZ4cYVlyRx
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRbJm5t5GS2LDRf4RAnNbAJ9N93mFR1GzZ3gQevLM6VzgZ3JjnACfQ+4z
DF9Naiz31wQdbe5GHr6QpxA=
=b6Ag
-----END PGP SIGNATURE-----

--Boundary-02=_mJbRBFZ4cYVlyRx--
