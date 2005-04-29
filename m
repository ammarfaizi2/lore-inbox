Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVD2OVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVD2OVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVD2OVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:21:36 -0400
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:1963 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262712AbVD2OVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:21:13 -0400
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Date: Fri, 29 Apr 2005 15:21:08 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt> <20050429050833.6b3d805b.akpm@osdl.org>
In-Reply-To: <20050429050833.6b3d805b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4140391.XnE1KzfmZg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504291521.08711.pjvenda@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4140391.XnE1KzfmZg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 April 2005 13:08, Andrew Morton wrote:
> "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt> wrote:
> > We've made some changes on our ftp server, and since that it's been
> > crashing frequently (everyday) with a kernel panic.
> >
> >  We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM =
on
> > top of that. All filesystems are reiserfs. The other change we made to
> > the server was changing from a patched 2.6.10-ac12 kernel into a newer
> > 2.6.11.7.
> >
> >  Not being able to see the whole stacktrace on screen, we've started a
> >  netconsole to investigate. Started the server and loaded it pretty bad
> > with rsyncs and such... until it crashed after just 20 minutes.
> >
> >  The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634=
!"
>
> Strange.  It'd be interesting to try disabling CONFIG_4KSTACKS.  Also,
> please add this to get a bit more info.

hi,

I'll try that. Should I do it with or without preemption?

regards,
pedro venda.

>
> diff -puN kernel/sched.c~a kernel/sched.c
> --- 25/kernel/sched.c~a	2005-04-29 05:05:24.792004408 -0700
> +++ 25-akpm/kernel/sched.c	2005-04-29 05:06:36.015176840 -0700
> @@ -2631,7 +2631,12 @@ void fastcall add_preempt_count(int val)
>  	/*
>  	 * Underflow?
>  	 */
> -	BUG_ON(((int)preempt_count() < 0));
> +	if ((int)preempt_count() < 0) {
> +		printk("preempt_count=3D%d\n", preempt_count());
> +		BUG();
> +	}
> +	if ((int)preempt_count() > 1000)
> +		printk("preempt_count=3D%d\n", preempt_count());
>  	preempt_count() +=3D val;
>  	/*
>  	 * Spinlock count overflowing soon?
> _

=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administra=E7=E3o de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior T=E9cnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt

--nextPart4140391.XnE1KzfmZg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCckLUeRy7HWZxjWERAmLDAKDPMM5dqGG6HjGBsnHdTankna/6hQCgvbrk
Cyyz371L13SXoRRY3Wz34gM=
=P9xD
-----END PGP SIGNATURE-----

--nextPart4140391.XnE1KzfmZg--
