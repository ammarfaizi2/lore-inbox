Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWCVFoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWCVFoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCVFoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:44:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37797 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750779AbWCVFoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:44:02 -0500
Message-Id: <200603220540.k2M5ej65018396@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Lang <dlang@digitalinsight.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Benjamin LaHaise <bcrl@kvack.org>,
       Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH]micro optimization of kcalloc 
In-Reply-To: Your message of "Mon, 20 Mar 2006 10:44:00 PST."
             <Pine.LNX.4.62.0603201043060.17740@qynat.qvtvafvgr.pbz> 
From: Valdis.Kletnieks@vt.edu
References: <20060320151433.GE16108@kvack.org> <84144f020603200815o66cb689cv239cbe190f9e6f30@mail.gmail.com>
            <Pine.LNX.4.62.0603201043060.17740@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143006045_5111P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Mar 2006 00:40:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143006045_5111P
Content-Type: text/plain; charset=us-ascii

On Mon, 20 Mar 2006 10:44:00 PST, David Lang said:
> On Mon, 20 Mar 2006, Pekka Enberg wrote:

> > On Mon, Mar 20, 2006 at 03:45:23PM +0100, Oliver Neukum wrote:
> >>>  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)

> > On 3/20/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
> >> This function shouldn't be inlined.  We have no need to optimize the
> >> unlikely case like this.
> >
> > IIRC, I made it static inline in the first place because that actually
> > reduced kernel text size. (And I think it was Adrian who made me do it
> > :-).
> 
> I wonder if this is still needed with the new inline changes that were 
> made to allow GCC to make the decision (for recent GCC's)

One non-obvious reason to inline it (at least in -mm kernels) is because the
slab leak detector stuff wants to find where it was called from - and if you
don't inline kcalloc(), you end up with the kzalloc() call it makes showing
kcalloc() as the caller.  If you inline it, you end up showing the caller
of kcalloc() instead, which is far more useful.....

--==_Exmh_1143006045_5111P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEIONdcC3lWbTT17ARAmO9AKCGmH02nimVlmNYbnOE0qtDPDsGIACgnITi
YNk2sZBMeSVXaAsfAGotFjU=
=xGgC
-----END PGP SIGNATURE-----

--==_Exmh_1143006045_5111P--
