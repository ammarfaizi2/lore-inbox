Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVASWIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVASWIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVASWIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:08:00 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45330 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261927AbVASWDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:03:22 -0500
Message-Id: <200501192202.j0JM2mGZ008933@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Splitting up grsecurity and PAX (was Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Wed, 19 Jan 2005 16:03:06 EST."
             <41EECB0A.9060403@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org> <41EEABEF.5000503@comcast.net> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41EEBF15.9050700@comcast.net> <200501192042.j0JKgPTW024711@turing-police.cc.vt.edu>
            <41EECB0A.9060403@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106172167_1885P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 17:02:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106172167_1885P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jan 2005 16:03:06 EST, John Richard Moser said:

(New Subject: line to split this thread out...)

> > Even better would be a 30-40 patch train for PaX, a 10-15 patch train
> > for the other randomization stuff in grsecurity (pid, port number, all
> > the rest of those), a 50-60 patch train for the RBAC stuff, and so on.
> > 
> 
> RBAC first.  Some of the other stuff relies on the RBAC system, I'm
> told.  Not sure what.

Well, there's 3 classes of stuff:

1) Stuff that's basically independent of RBAC (a lot of randomization stuff,
for instance). These can go as a separate stream.

2) Stuff that is mostly independent of RBAC, but can use it for configuration
and control.  So for instance, the PAX stuff (which by itself is close to half
the whole thing) could go in, and possibly with a "stub" patch that adds
control via /proc/kernel/something or a /sys entry.  And it's *OK* if your
code has a "shim" in it to make patch 3 work until the new infrastructure
that patch 27 adds shows up, meaning that patch 26 removes a big chunk of
patch 3 (especially if your /sys shim stands on its own even without patch 27).

3) The stuff that literally makes *no* sense if you don't have RBAC.

It may very well make sense to attack the stuff in group (1) *first*, because
then (a) all the kernel users get the benefits (similar to the "non-exec-stack"
patch from execshield - everybody wins from that piece even though it's not all
of the package), and (b) it's an easy way to pile up street creds by demonstrating
with small patches that you are with the program - when some of the later, more
contentious patches show up, it helps if you're recognized as the guy who
already sent in 10-15 patches...

> I think GrSecurity's RBAC is a bit bigger than LSM can accomodate.

Well - what parts of RBAC *can* be done inside the LSM framework?

What parts could be done inside LSM if LSM gained another hook or two (there
*is* precedent for adding a hook for things that can reasonably use it)?

What parts can't be done inside LSM, and why?

> Anyway, I wasn't originally trying to get PaX into mainline in this
> discussion; I think this started out with me trying to point out why
> things like PaX have to be all-or-nothing.

I agree that the sum set of features eventually included needs to cover
all the bases - the big hurdle is factoring it down into patches that stand
a chance.



--==_Exmh_1106172167_1885P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7tkHcC3lWbTT17ARAiO5AKC+9bxgHlFLUDr8zwXpRmbbEa3S4QCeIh4Y
Pc76/zx4Hkrgoz8MD3mwu5w=
=ojCU
-----END PGP SIGNATURE-----

--==_Exmh_1106172167_1885P--
