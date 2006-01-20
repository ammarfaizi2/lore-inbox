Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWATPTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWATPTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWATPTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:19:31 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43686 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750732AbWATPTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:19:30 -0500
Message-Id: <200601201519.k0KFJHh9016919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2 
In-Reply-To: Your message of "Fri, 20 Jan 2006 03:40:27 PST."
             <20060120034027.665eb101.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060120031555.7b6d65b7.akpm@osdl.org> <84144f020601200333y2d2c994av96d855e300411006@mail.gmail.com>
            <20060120034027.665eb101.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137770357_3521P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 10:19:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137770357_3521P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Jan 2006 03:40:27 PST, Andrew Morton said:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> > Hmm. This still leaves kstrdup() broken which is why I would prefer
> > the following patch to be applied:
> 
> kstrdup() doesn't get used much.
> 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113767657400334&w=2
> 
> That adds more complexity, IMO.  A bit ifdeffy too.  __do_kmalloc() should
> be __always_inline, methinks?

For what it's worth, I spent some time trying to get kstrdup() fixed as well,
but gave up because:

a) The leak I was chasing was using kzalloc() ;)

b) I got stuck in a .h dependency loop - the prototype for kzalloc is in
slab.h, and by that point in slab.h, we've seen a prototype for __kmalloc().
Unfortunately, kstrdup() comes out of string.h, and there's usages where
string.h has been #included but we've not seen __kmalloc().  Unfortunately,
just #include'ing what's needed didn't work, because of the way the code
uses #ifndef _LINUX_FOO_H_ - when I started looking at having to #undef stuff
to get a prototype of __kmalloc(), I gave up. ;)

--==_Exmh_1137770357_3521P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD0P91cC3lWbTT17ARArbkAKDSaEsvAm1wAO8vtJOH9E7Es06iCACeJVk9
j1EkdYa5gkzvsCi0FOzdfFI=
=d8IE
-----END PGP SIGNATURE-----

--==_Exmh_1137770357_3521P--
