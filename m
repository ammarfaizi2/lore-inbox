Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUFIUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUFIUkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUFIUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:40:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8578 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265953AbUFIUka (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:40:30 -0400
Message-Id: <200406092040.i59KeMaC028141@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: arjanv@redhat.com
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8) 
In-Reply-To: Your message of "Wed, 09 Jun 2004 22:21:26 +0200."
             <1086812486.2810.21.camel@laptop.fenrus.com> 
From: Valdis.Kletnieks@vt.edu
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> <20040609113455.U22989@build.pdx.osdl.net> <1086812001.13026.63.camel@cherry>
            <1086812486.2810.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_893967310P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Jun 2004 16:40:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_893967310P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <28127.1086813620.1@turing-police.cc.vt.edu>

On Wed, 09 Jun 2004 22:21:26 +0200, Arjan van de Ven said:

> > + */
> > +void *kcalloc(size_t n, size_t size, int flags)
> > +{
> > +	void *ret = kmalloc(n * size, flags);
> 
> how about making sure n*size doesn't overflow an int in this function?
> We had a few security holes due to that happening a while ago; might as
> well prevent it from happening entirely

Do we want 'int', or is some other value (size_t? u32?) a better bet? (I see on
some of the 64-bit boxes a compat_size_t for 32-bits as well, which hints at
the problems here....

I'm worried that 'int' will Do The Wrong Thing when it runs into stuff like
this from asm-i386/types.h:

/* DMA addresses come in generic and 64-bit flavours.  */

#ifdef CONFIG_HIGHMEM64G
typedef u64 dma_addr_t;
#else
typedef u32 dma_addr_t;
#endif
typedef u64 dma64_addr_t;

Are there any platforms where 'int' and 'max reasonable kmalloc size' have the
same number of bits?

--==_Exmh_893967310P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAx3W2cC3lWbTT17ARAvJzAJ4vxk24VZaTsyUt7b6gwDKmtYEUHgCeOvDM
mGtuXTazQi1jRCI15Td+4Kk=
=U8Ch
-----END PGP SIGNATURE-----

--==_Exmh_893967310P--
