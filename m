Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSKCQLj>; Sun, 3 Nov 2002 11:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSKCQLj>; Sun, 3 Nov 2002 11:11:39 -0500
Received: from ua133d34hel.dial.kolumbus.fi ([62.248.232.133]:32093 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S262084AbSKCQLi>; Sun, 3 Nov 2002 11:11:38 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Jussi Laako <jussi.laako@kolumbus.fi>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3Nma7VigEoahCgwnoAxG"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 18:17:51 +0200
Message-Id: <1036340272.26281.5.camel@vaarlahti.uworld>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3Nma7VigEoahCgwnoAxG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-11-03 at 18:17, Denis Vlasenko wrote:

Jump target 17e0 is aligned (with nops):

>     17dd:	88 02                	mov    %al,(%edx)
>     17df:	90                   	nop   =20
>     17e0:	89 d0                	mov    %edx,%eax
>     17e2:	5a                   	pop    %edx

>     17ec:	eb f2                	jmp    17e0 <__constant_memcpy+0x20>

>     17fa:	eb e4                	jmp    17e0 <__constant_memcpy+0x20>

>     1800:	eb de                	jmp    17e0 <__constant_memcpy+0x20>

>     187c:	e9 5f ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
>     1881:	eb 0d                	jmp    1890 <__constant_memcpy+0xd0>
>     1883:	90                   	nop   =20
...
>     188f:	90                   	nop   =20
>     1890:	c1 e9 02             	shr    $0x2,%ecx
>     1893:	89 d7                	mov    %edx,%edi

And also jump target 1890 is aligned.


I think the penalty of few NOPs is smaller than result of jump to
unaligned address. This is especially true with P4 architecture.


	- Jussi Laako

--=-3Nma7VigEoahCgwnoAxG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9xUwvS3txJU4L5RQRAtD9AJ4npxAiIK3d5e6Cq/VduKswbeC4OACdGrdt
FLJXVrjpxawp9TH3m6UP3RU=
=S8Av
-----END PGP SIGNATURE-----

--=-3Nma7VigEoahCgwnoAxG--

