Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJBRuR>; Wed, 2 Oct 2002 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbSJBRuR>; Wed, 2 Oct 2002 13:50:17 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:662 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261627AbSJBRuP>; Wed, 2 Oct 2002 13:50:15 -0400
Message-Id: <200210021755.g92HtGLw010852@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38 
In-Reply-To: Your message of "Tue, 01 Oct 2002 17:55:00 BST."
             <20021001175500.A26635@infradead.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu> <20020927195919.A4635@infradead.org> <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
            <20021001175500.A26635@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1105514360P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Oct 2002 13:55:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1105514360P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Oct 2002 17:55:00 BST, Christoph Hellwig said:

> For gods sake, what interface do you want to /bin/mv?  network device don't have
> associated special files in Linux (or BSD).  I'm talking about SIOCSIFNAME.

Well, I figured that you must have meant something else, since ioctl() is
hooked, so an attacker couldn't use THAT method if the security module didn't
want him to.

Of course, that means we probably should pull that ioctl() hook too, since
obviously there's ways to bypass it.  And at that point, we may as well
pull the OTHER hooks too.  Hmm..  I'm starting to see a pattern here. ;)

So we shouldn't deploy a check on module parameters to prevent renaming
an interface, and we shouldn't bother having OTHER checks to stop it
because they could always load a module and bypass it - if you feel THAT
strongly that the whole concept of a security framework is that pointless,
you're free not to use it. ;)

> How does the lsm author know what the option x=y means for my module?  In my

Umm.. the same way that *I* noticed that 'eth=0' has a security implication.

It seems to me that you're arguing both sides here - first you say that
a full code audit is needed so you know 'WTF is going on', and then you're
saying that it's impossible to know.

Either that, or you're saying "yes you can do a code audit, but having identified
module parameters that are *KNOWN* to be a problem, you're not allowed to stop
them".

> From my reading of the LSM lists a hgook usually got added because author A
> of the unaudited module B though that it might help him in imlpementing what
> he and only he thinks his module should do if it worked properly.

OK - so to summarize:  You're saying that somebody conceives of a reasonable
security model, finds a set of 10 or 15 hooks that implement 95% of what
he needs, but there's a code path that a hook doesn't catch that lets a user
subvert the model - and then it's a *BAD THING* that the kernel be modified
to *actually solve a problem*?

Somehow, this goes against the whole spirit of the Linux kernel - I wonder
what miniscule percent of the current kernel wasn't done to solve a problem...
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1105514360P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9mzMCcC3lWbTT17ARAvgaAJ4s/i7BwbAWv0FkA1QAMM+4IGE+9wCguAl2
1dD7jhBQgbmF66wAGAhmuN4=
=HGQB
-----END PGP SIGNATURE-----

--==_Exmh_-1105514360P--
