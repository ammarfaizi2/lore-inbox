Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUFIQ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUFIQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUFIQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:28:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265828AbUFIQ2l (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:28:41 -0400
Message-Id: <200406091628.i59GSj5q019193@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm 
In-Reply-To: Your message of "Wed, 09 Jun 2004 13:46:15 +0200."
             <20040609114615.GK601@schottelius.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net> <20040609090346.GG601@schottelius.org> <20040609112235.GA1088@pooh>
            <20040609114615.GK601@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_677664529P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Jun 2004 12:28:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_677664529P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Jun 2004 13:46:15 +0200, Nico Schottelius said:

> I heard about that, but I wanted to know whether this statement is still
> true. I think with grsecurity you get a great security enhanced kernel.

grsecurity is also an incredibly intrusive patch, and as of last week Brad
Spendler was dropping continuing support due to time/financial issues.

The Grsecurity stuff breaks down into several pieces:

1) The PaX stuff, which is more intrusive than the RedHat exec-shield patch
and doesn't buy us an obviously higher level of security - the major thing that
PaX does that exec-shield doesn't is prevent calling mprotect() on a previously
writable page to make it executable.  Note that mprotect() can be handled via
an LSM exit as well, so that's an alternate route to take.  Note that the PaX
stuff requires a patch to binutils and recompiling/relinking everything to take
full advantage of it (OK, exec-shield does as well, but has the advantage that
the GNU_PT_STACK stuff has already been pushed upstream).  Either way,
we still have the Wine problem... ;)

2) For better or worse, SELinux and LSM are already in the base kernel, so
Brad's ACL stuff is a duplication of effort.  Feel free to drag that along
yourself, but any percieved benefit of Brad's ACL system is outweighted (in
my book at least) by the fact that SELinux is being actively worked into
things like Fedora, Suse, and Debian.

3) A bunch of things like hardening /tmp symlinks and chroot jails, which
are just as doable via an LSM module - I posted a "first cut" a while back,
and I'll probably put out another one very shortly that incorporates all the
helpful feedback I got over on the SELinux and LSM lists (Thanks, guys! ;)

4) When I looked at it, the remainder was basically just PID randomization
and some network randomization tweaks (again, I posted a first-cut, and will
probably post another shortly incorporating suggestions I got).

That's my take on it, for what it's worth...

--==_Exmh_677664529P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAxzq9cC3lWbTT17ARApGcAJ91L7dg99eIy0I4m2B/cQhVn7aFdQCgq2cD
rCTiZIrh8qYab7Hn0qqjMvA=
=nVXu
-----END PGP SIGNATURE-----

--==_Exmh_677664529P--
