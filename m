Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSHTOC4>; Tue, 20 Aug 2002 10:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSHTOC4>; Tue, 20 Aug 2002 10:02:56 -0400
Received: from ppp-217-133-223-78.dialup.tiscali.it ([217.133.223.78]:45231
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318166AbSHTOCz>; Tue, 20 Aug 2002 10:02:55 -0400
Subject: Re: [PATCH] (re-xmit): kprobes for i386
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <3D62365E.8030905@iram.es>
References: <20020819235020.56DF12C483@lists.samba.org>
	<1029844464.1745.49.camel@ldb>  <3D62365E.8030905@iram.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sjpVWmNgRiznb2Uj2Bpd"
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Aug 2002 16:06:58 +0200
Message-Id: <1029852418.8662.267.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sjpVWmNgRiznb2Uj2Bpd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > Something like this:
> > ENTRY(debug)
> > 	testl $0x3, 4(%esp)
> > 	jz handle_kernel_mode_debug
> > 
> 
> This check is insufficient, it can go the wrong way if the interrupted
> taks is in vm 86 mode (and open a big security hole, I believe).
Right.
This test from ret_from_intr could be used instead:

push %es
push %ds
push %eax
movl 8(%esp), %eax
movb 4(%esp), %al
testl $(VM_MASK | 3), %eax
jz handle_kernel_mode

There is however a potential register stall for the eax read after the
al write.

BTW, vm86 has the VM flag set so the comment in ret_from_intr is wrong.
The code seems to be right though.


--=-sjpVWmNgRiznb2Uj2Bpd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Yk0Cdjkty3ft5+cRAhMbAKC1AY7C5YO3znXVP19DpJNoD7n0dgCgiwz2
hA2g191iKW2MOfY4X8atAyg=
=B73g
-----END PGP SIGNATURE-----

--=-sjpVWmNgRiznb2Uj2Bpd--
