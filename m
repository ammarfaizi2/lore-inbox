Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135954AbRAMLsz>; Sat, 13 Jan 2001 06:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbRAMLso>; Sat, 13 Jan 2001 06:48:44 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:10306 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S135954AbRAMLsb>; Sat, 13 Jan 2001 06:48:31 -0500
Date: Sat, 13 Jan 2001 12:46:00 +0100
From: Christian Zander <phoenix@minion.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
Message-ID: <20010113124559.A2108@chronos>
Reply-To: Christian Zander <phoenix@minion.de>
In-Reply-To: <20010112201130.A710@chronos> <3654.979348291@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3654.979348291@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Jan 13, 2001 at 12:11:31PM +1100
X-Accept-Language: de, en, fr
X-Operating-System: Gnu/Linux [2.2.18][i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2001 at 12:11:31PM +1100, kaos@ocs.com.au wrote:
> My apologies.  I read the patch, not the full source code and the patch
> does not have enough programming context to show that the driver is
> only searching its own symbol space.  In my own defense, the references
> to spinlock_t unload_lock and MOD_CAN_QUERY(mp) in the patch are highly
> misleading, those statements only make sense when you are looking at a
> symbol table for another module.  When searching your own symbol table
> the current module must be live with a non-zero use count, not being
> unloaded and it can always be queried.
>=20
> >Contrary to what you're saying, the patch does not just inline the old
> >get_module_symbol algorithm nor does it access any of module.c's internal
> >data.
>=20
> unload_lock and MOD_CAN_QUERY were copied verbatim from the old
> get_module_symbol, even though they are completely unnecessary.  That
> looks like inlining the old algorithm to me.
>=20
> struct module_symbol, mp->nsyms and mp->syms are module.c internal
> data.  If it is ever necessary to change those structures, nothing
> outside module.c, the 32/64 handlers for module system calls and
> modutils should be affected.  Now if I change module_symbol, other bits
> of the kernel will unexpectedly break, this is not good.

I see what you mean. What do you suggest should be done in the context of
the driver? As you can easily tell, I'm not overly familiar with the=20
internal workings of the kernel. That and the mere impossibility to get=20
any kind of help at the mere mention of the Nvidia driver module ("go bitch
at nvidia", "who cares", ...) do not exactly make it easier to fix problems=
=20
that arise from changes to the kernel.=20

--
----------------------------------------------------------------------
 christian zander              we come to bury dos, not to praise it.
 zander@hdz.uni-dortmund.de    -- paul vojta
----------------------------------------------------------------------

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6YD/3Y28vJpqNKtcRAiVJAJ9X7pNpIXxYarCY5QaKGKQzuwh5ewCffAc6
oVCJkGYq1jhceAKSgRQRrFY=
=cc1m
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
