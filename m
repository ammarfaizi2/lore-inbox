Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUFANDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUFANDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUFANDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:03:52 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:51390 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265021AbUFANDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:03:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: compat syscall args
Date: Tue, 1 Jun 2004 15:03:16 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040529122319.49eaafe1.davem@redhat.com> <20040529123155.5ca76207.davem@redhat.com>
In-Reply-To: <20040529123155.5ca76207.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_U6HvA32wYFGZddu";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011503.16323.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_U6HvA32wYFGZddu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 29 May 2004 21:31, David S. Miller wrote:
> As it turns out we're taking care of this already via stubs
> in arch/sparc64/kernel/sys32.S, I just need to add them for
> select and futex.

Ah, thanks for solving this mystery.=20

select and futex may not be the only ones that need to be fixed
for sparc64. I grepped through the list of syscalls that you
call without a sys32.S wrapper and found these that take at least
five arguments:

compat_sys_io_getevents, compat_sys_mount, sys_fsetxattr,
sys_setsockopt, sys_llseek, sys_mremap, sys_remap_file_pages,
sys_setxattr, sys_lsetxattr, sys_fsetxattr, sys32_fadvise64,
sys32_fadvise64_64, sys32_ipc, sys32_mremap, sys32_pciconfig_read,
sys32_pciconfig_write, sys32_prctl, sys32_pread64, sys32_pwrite64,
sys32_rt_sigaction

I did not check which ones are safe anyway, but you probably
want to go through that list.

	Arnd <><

--Boundary-02=_U6HvA32wYFGZddu
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvH6U5t5GS2LDRf4RArU/AJ0afYM0qLOjNkxo+/O73h+/l+QVfACfbwnn
BqW7OcAt0lk4eOXQmgsa2Pc=
=+GgP
-----END PGP SIGNATURE-----

--Boundary-02=_U6HvA32wYFGZddu--
