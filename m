Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTF0EqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 00:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTF0EqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 00:46:14 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:5322 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263665AbTF0EqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 00:46:12 -0400
Date: Fri, 27 Jun 2003 09:00:20 +0400
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] irq handling code consolidation (common part)
Message-ID: <20030627050020.GX9679@pazke>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030626110247.GT9679@pazke> <20030626175554.GA22089@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TcuvTDpCAASXpu1W"
Content-Disposition: inline
In-Reply-To: <20030626175554.GA22089@krispykreme>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.0 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TcuvTDpCAASXpu1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 178, 06 27, 2003 at 03:55:54AM +1000, Anton Blanchard wrote:
>=20
> > the irq handling consolidation patch returns from the dead !
> > Now with runaway irq detection code included !
> >=20
> > This patch (against 2.5.73) contains common part of it.
>=20
> Great! Well it wasnt dead, I was also keeping it up to date and sending
> it on to akpm :)
>
> I have two suggestions that will help in my crusade to kill NR_IRQS.
>=20
> 1. define irq_desc, irq_valid, for_each_irq in include/linux/irq.h if
> HAVE_ARCH_IRQ_DESC isnt defined (instead of in each architecture).
> Basically I want to start using these macros in a few places and dont
> want to break every architecture that hasnt converted to the new scheme.

Why in include/linux/irq.h ? These macros are definetely arch specific.
Do you talk about generic array based implementation wrapped in=20
#ifdef ARCH_HAVE_FOO ?
=20
> On the other hand if we decide to move the irq descriptor definition
> into each arch as hch suggested, this wont be necessary as all archs
> will break anyway :)

Why it will break ? Every arch defines irq descriptors itself now.
May be I'm missing some point here ?

> 2. define irq_atoi that converts an irq into a printable string. We have
> a bunch of #ifdef CONFIG_SPARC stuff we can then get rid of, and other
> archs can start using it if wanted (eg on ppc64 I can subtract our
> software offset so the irqs printed match the hardware)

I thinked about this already, but i wanted to finish cleanup work first.

BTW sparc implementation of irq_itoa() uses static buffer for the formatted=
=20
string, is it really irq/preempt safe ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--TcuvTDpCAASXpu1W
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++89kby9O0+A2ZecRAnAjAJ9twJJoB/Fk4MPGXl6UJJOWtpXbqgCgvtBB
GserlhkaY/LBKojTJn0vzeI=
=B6Bb
-----END PGP SIGNATURE-----

--TcuvTDpCAASXpu1W--
