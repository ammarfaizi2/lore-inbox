Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTJBCn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbTJBCn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:43:28 -0400
Received: from h80ad2560.async.vt.edu ([128.173.37.96]:24704 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263209AbTJBCn0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:43:26 -0400
Message-Id: <200310020242.h922ggqd007637@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Radu Filip <socrate@infoiasi.ro>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Makan Pourzandi <Makan.Pourzandi@ericsson.ca>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries 
In-Reply-To: Your message of "Thu, 02 Oct 2003 00:55:41 +0300."
             <Pine.LNX.4.44.0310020043550.16234-100000@shrek.tuiasi.ro> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310020043550.16234-100000@shrek.tuiasi.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1461179249P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Oct 2003 22:42:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1461179249P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Oct 2003 00:55:41 +0300, Radu Filip said:

> Especially to your point, should I mention that there are patches that
> avoid buffer-overflows? Or that there are patches for gcc that add bound
> check to arrays in C?

Hmm.. patches to avoid buffer overflows.. hold that thought.

Also, note that those gcc patches are in general inadequate, in that they
can't do much for the most common case of a bounds-check issue
in C - where a pointer to a char array is passed to another function
which uses it as the target of a strcpy() or such...

(Not to say that the patches are useless - but they're a lot less utility than
sounds at first, precisely because most C code relies so heavily on the
interplay of "array" and "pointer", especially when calling another function)

> These peoples are trying to solve a problem. If you have some expertise in
> the area of the problem, it might be much useful to come with positive
> ideas about how the encountered problems can be solved, instead of
> dismissing with so much ease the effort done to solve a real problem.

(Note that I'm writing this as somebody who is himself running the
exec-shield patches *and* the SELinux stuff and a few other things as
well... so I don't consider this stuff *totally* useless....)

The problem here is that "positive ideas" in this case *DOES* include the
observation that the only thing the patch does is raise the bar on a purely
temporary basis, and that it provides little long-term benefit as soon as the
rootkits start working around it.  As has been pointed out, DigSig only
secures one tiny part of the way that executable code gets into memory.

Yes, it probably does a *very* good job of making sure that the binary
loaded by an exec() call hasn't been tampered with.  On the other hand,
it does *NOTHING* to tamper-proof shared libraries - so if the attacker
had a nice trojan to put into /usr/sbin/pppd and you install DigSig,
all they have to do is wrap a 'if (!strcmp("pppd",argv[0]) {....'
around their code and stick it in /lib/libutil.so instead.  Or drop it into
the PAM directories.  If the attacker could otherwise have modified pppd,
they almost certainly had the ability to modify libutil.so or the PAM stuff
as well.

You're spending a lot of effort solving the problem of making sure that
you can't exec an untrusted binary, when the problem you (presumably)
actually want to solve is making sure that you can't run untrusted code.

Note that Microsoft's literature on their Trusted Computing initiative
seems to indicate that they made this same mistake - they fail to account
for the fact that if you install a Palladium-aware IIS (or whatever), and
then manage to buffer-overflow it, that code will then execute in whatever
context the IIS program has.  As such, it's more about DRM than
about actual security.

--==_Exmh_-1461179249P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/e5ChcC3lWbTT17ARApm7AKD9yzejKkFOmUogYi/Wj5nQBEMedwCdFvwW
EIvjqTMdFhxI5dVF1AccSOA=
=OYeG
-----END PGP SIGNATURE-----

--==_Exmh_-1461179249P--
