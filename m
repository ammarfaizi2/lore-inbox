Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbVHGLMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbVHGLMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbVHGLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:12:14 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:43688 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751518AbVHGLMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:12:14 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] ARCH_HAS_IRQ_PER_CPU avoids dead code in __do_IRQ()
Date: Sun, 7 Aug 2005 13:07:20 +0200
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200508061814.31719.annabellesgarden@yahoo.de> <200508062329.05081.ioe-lkml@rameria.de> <200508071225.21825.annabellesgarden@yahoo.de>
In-Reply-To: <200508071225.21825.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart22040379.6f5tcRWrBl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508071307.26221.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart22040379.6f5tcRWrBl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Karsten,

On Sunday 07 August 2005 12:25, Karsten Wiese wrote:
> With my proposal the
> 	#if defined(ARCH_HAS_IRQ_PER_CPU)
> 	....
> 	#endif
> lets readers of __do_IRQ() immediately grasp:
>  "this block might not be compiled / depends an ARCH"
> And you'll get compile error's using IRQ_PER_CPU on ie i386,
> letting you immediately know,
> that you've got to change something to be able to use IRQ_PER_CPU.
>=20
> That are advantages I think.

That's a valid argument. But an if is an if for the reader.
It is a conditional he has to be aware of and it usally has
no idention, if it is just inside "#if" instead of "if ()".

I have seen people seen missing "#if 0" [1] around code while=20
reading it. Missing an normal if () is harder with proper idention.

A normal conditional has also the advantage, that the compiler
checks the code for syntactic and some semantic errors within it.

In an "#if 0" you can basically write any plain text[2] and any error
will go undetected, until it becomes an "#if 1".

Since your define is true for most compilations out there,
this argument is not very strong.

Last argument: Many kernel developers -- including Linus --=20
don't like "#if" in C files and prefer them in headers.=20
Their reasons might be similiar to my own.


Regards

Ingo Oeser

[1] Let's just consider the values of the pre-processor symbols here, ok?
[2] Pavel Machek used this already to combine Makefile and C file :-)


--nextPart22040379.6f5tcRWrBl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9etuU56oYWuOrkARAn1ZAKCMCa+lJ9LwJ/KsBWNvbH3m+6hCXQCglcZ6
aOmPx5fVG+WXm+sgLYvP66U=
=b6Mx
-----END PGP SIGNATURE-----

--nextPart22040379.6f5tcRWrBl--
