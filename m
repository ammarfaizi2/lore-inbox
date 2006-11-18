Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756027AbWKRGz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbWKRGz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbWKRGz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:55:27 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:32188 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1756027AbWKRGz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:55:26 -0500
Date: Sat, 18 Nov 2006 17:53:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oleg Verych <olecom@flower.upol.cz>
Message-Id: <20061118175340.2e98966d.sfr@canb.auug.org.au>
In-Reply-To: <slrneltauh.dd3.olecom@flower.upol.cz>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
	<20061118054413.8884.99940.sendpatchset@schroedinger.engr.sgi.com>
	<20061118173253.85d5b7e8.sfr@canb.auug.org.au>
	<slrneltauh.dd3.olecom@flower.upol.cz>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__18_Nov_2006_17_53_40_+1100_K5p2I2gNh+K2+PGy"
Subject: Re: [RFC 6/7] Use an external declaration in exit.c for fs_cachep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__18_Nov_2006_17_53_40_+1100_K5p2I2gNh+K2+PGy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2006 06:44:33 +0000 Oleg Verych <olecom@flower.upol.cz> wrote:
>
>
> On 2006-11-18, Stephen Rothwell wrote:
> []
> >> --- linux-2.6.19-rc5-mm2.orig/kernel/exit.c	2006-11-15 16:48:11.485511089 -0600
> >> +++ linux-2.6.19-rc5-mm2/kernel/exit.c	2006-11-17 23:04:09.764530373 -0600
> >> @@ -48,6 +48,8 @@
> >>  #include <asm/pgtable.h>
> >>  #include <asm/mmu_context.h>
> >>
> >> +extern kmem_cache_t *fs_cachep;
> >
> > You know what I am going to say, right? :-)
>
> I know, externs must be in headers. Please, explain why.

So that there is only one declaration.  That way if it is changed,
everywhere that uses it will notice.  Also, the same header must be
included by the file that defines the variable or function so any
discrepancy between declaration and definition will be obvious.

i.e. we are protecting ourselves against change and making maintainance
easier.

In this particular case, the type is probably never going to change, but
consistency is good.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__18_Nov_2006_17_53_40_+1100_K5p2I2gNh+K2+PGy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXq30FdBgD/zoJvwRApDgAJ4xno8ERs6xF1qb3ZaMD+NHnQoz9ACfXZCp
R18p21wI6YSdid+MUC0pE6s=
=NEdB
-----END PGP SIGNATURE-----

--Signature=_Sat__18_Nov_2006_17_53_40_+1100_K5p2I2gNh+K2+PGy--
