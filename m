Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTI2Pwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTI2Pwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:52:54 -0400
Received: from h80ad2481.async.vt.edu ([128.173.36.129]:33736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263636AbTI2Pv5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:51:57 -0400
Message-Id: <200309291551.h8TFpZtH028192@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jamie Lokier <jamie@shareable.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits 
In-Reply-To: Your message of "Mon, 29 Sep 2003 16:34:37 BST."
             <20030929153437.GB21798@mail.jlokier.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030929090629.GF29313@actcom.co.il>
            <20030929153437.GB21798@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1901227542P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 11:51:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1901227542P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 16:34:37 BST, Jamie Lokier said:
> Muli Ben-Yehuda wrote:
> > -/* Optimisation macro. */
> > +/* Optimisation macro, used to be defined as: */
> > +/* ((bit1 == bit2) ? (x & bit1) : (x & bit1) ? bit2 : 0) */ 
> > +/* but this version is faster */ 
> > +/* "check if bit1 is on in 'x'. If it is, return bit2" */ 
> >  #define _calc_vm_trans(x,bit1,bit2) \
> >    ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
> >     : ((x) & (bit1)) / ((bit1) / (bit2)))
> 
> I agree with the intent of that comment, but the code in it is
> unnecessarily complex.  See if you like this, and if you do feel free
> to submit it as a patch:
> 
> /* Optimisation macro.  It is equivalent to:
>       (x & bit1) ? bit2 : 0
>    but this version is faster.  ("bit1" and "bit2" must be single bits). */

Is this supposed to return the bitmask bit2, or (x & bit2)?  If the former,
then your code is right.  If the latter,  (x & bit1) ? (x & bit2) : 0

I'm totally failing to see why the original did the bit1 == bit2 compare,
so maybe mhyself and Jamie are both missing some subtlety?

--==_Exmh_1901227542P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eFUGcC3lWbTT17ARAlyGAKCg7kX3F6Jd4v3nGVX0147E1BWtVACfbTmh
JrEQcKN3KMtz86X3mcMYNoI=
=87KW
-----END PGP SIGNATURE-----

--==_Exmh_1901227542P--
