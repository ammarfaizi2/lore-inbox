Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUBQChs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBQChs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:37:48 -0500
Received: from h80ad2696.async.vt.edu ([128.173.38.150]:54716 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265835AbUBQChq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:37:46 -0500
Message-Id: <200402170237.i1H2bb3r008280@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity 
In-Reply-To: Your message of "Mon, 16 Feb 2004 18:15:46 PST."
             <20040216181546.A22989@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
            <20040216181546.A22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1623177976P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Feb 2004 21:37:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1623177976P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Feb 2004 18:15:46 PST, Chris Wright said:
> * Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> > Here's the patch, versioned against 2.6.3-rc3-mm1. Comments?
> 
> Aside of the dubious security value...the typical no #ifdefs apply here.

Agreed - the only one that seems at all a *big* win is randomizing PID's
(and even there it probably should default a higher value for pid_max to
increase the search space).  But as long as I was looking at it anyhow.. :)

> 
> > +#ifdef CONFIG_SECURITY_RANDID
> > +	if (security_enable_randid)
> > +		id = ip_randomid();
> > +	else
> > +#endif
> 
> e.g. move the ifdef to header and move the if(enable) bit to ip_randomid().
> ditto for all similar cases below.  it's not clear to me these are
> particularly useful features though.

OK.. I can do that easily enough - only reason I didn't was because that would
force the inclusion of ip_randomid() and the corresponding call even when the
feature wasn't selected, making it more intrusive (the 'else' clause is also the
"when not configured at all" code - moving the whole if/then/else to another
function was more intrusive, to my thinking..)

> 
> > + * 3. All advertising materials mentioning features or use of this softwar
e
> > + *    must display the following acknowledgement:
> > + *    This product includes software developed by Niels Provos.
> 
> Advertsing clause...this is not GPL compatible.

Thanks for spotting that.  It's the same way in grsecurity's patch - do they
have an issue as well?  Or they OK because they're only doing a separately
distributed patch?

--==_Exmh_-1623177976P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMX5wcC3lWbTT17ARApi2AJ93dIwMzev++hMX0Q0VgSCIBFLU4ACffv0e
xk4rw2vtbH7fb6KKKzMEzXY=
=14gO
-----END PGP SIGNATURE-----

--==_Exmh_-1623177976P--
