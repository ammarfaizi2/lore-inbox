Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCOPyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCOPyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCOPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:54:14 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:41638 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261343AbVCOPxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:53:49 -0500
Date: Wed, 16 Mar 2005 02:53:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 iSeries: cleanup viopath
Message-Id: <20050316025339.318fc246.sfr@canb.auug.org.au>
In-Reply-To: <0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org>
References: <20050315143412.0c60690a.sfr@canb.auug.org.au>
	<0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__16_Mar_2005_02_53_39_+1100_ehdPPm1B4zl97c0V"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__16_Mar_2005_02_53_39_+1100_ehdPPm1B4zl97c0V
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 Mar 2005 08:32:27 -0600 Hollis Blanchard <hollis@penguinppc.org> wrote:
>
> On Mar 14, 2005, at 9:34 PM, Stephen Rothwell wrote:
> >
> > Since you brought this file to my attention, I figured I might as well 
> > do
> > some simple cleanups.  This patch does:
> > 	- single bit int bitfields are a bit suspect and Anndrew pointed
> > 	  out recently that they are probably slower to access than ints
> 
> > --- linus/arch/ppc64/kernel/viopath.c	2005-03-13 04:07:42.000000000 
> > +1100
> > +++ linus-cleanup.1/arch/ppc64/kernel/viopath.c	2005-03-15 
> > 14:02:48.000000000 +1100
> > @@ -56,8 +57,8 @@
> >   * But this allows for other support in the future.
> >   */
> >  static struct viopathStatus {
> > -	int isOpen:1;		/* Did we open the path?            */
> > -	int isActive:1;		/* Do we have a mon msg outstanding */
> > +	int isOpen;		/* Did we open the path?            */
> > +	int isActive;		/* Do we have a mon msg outstanding */
> >  	int users[VIO_MAX_SUBTYPES];
> >  	HvLpInstanceId mSourceInst;
> >  	HvLpInstanceId mTargetInst;
> 
> Why not use a byte instead of a full int (reordering the members for 
> alignment)?

Because "classical" boleans are ints.

Because I don't know the relative speed of accessing single byte variables.

Because it was easy.

Because we only allocate 32 of these structures.  Changing them really
only adds four bytes per structure.  I guess using bytes and rearranging
the structure could actually save 4 bytes per structure.

I originally changed them to unsigned int single bit bitfields, but
changed my mind - would that be better?

It really makes little difference, I was just trying to get rid of the
silly signed single bit bitfields ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__16_Mar_2005_02_53_39_+1100_ehdPPm1B4zl97c0V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCNwUK4CJfqux9a+8RAqcGAJ9umONgGQ8JcHNuYtXagju38ycVKACgjlpE
Z9DqTPxZ0geAJJznNQgNliQ=
=wpfU
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Mar_2005_02_53_39_+1100_ehdPPm1B4zl97c0V--
