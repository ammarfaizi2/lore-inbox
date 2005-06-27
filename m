Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVF0RAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVF0RAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVF0Q6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:58:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35011 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261399AbVF0Qy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:54:29 -0400
Message-Id: <200506271653.j5RGrHUL019484@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Hubert Chan <hubert@uhoreg.ca>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Mon, 27 Jun 2005 02:07:46 CDT."
             <42BFA5C2.1010807@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <87y88webpo.fsf@evinrude.uhoreg.ca> <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu> <42BF9489.9080202@slaphack.com> <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
            <42BFA5C2.1010807@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119891196_6336P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 12:53:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119891196_6336P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Jun 2005 02:07:46 CDT, David Masover said:
> > Exactly the same sort of thing - traditionally it's been more or less ignored
> > in the system accounting, because A would usually average out to causing as
> > many I/Os as B did, and they were roughly equal in cost so it was a wash.
> 
> Even if A is doing A/V work and B is programming?

I said "traditionally" - it's been a "oh well, we can't do much about it"
problem for a *long* time (for instance, time spent in an interrupt handler
has usually been charged off against whoever's timeslide the interrupt handler
took a chunk out of).  It's only been tolerated so far because (a) the costs
for both users are about equal and (b) you rarely have a heavy I/O DB and a
number cruncher on the same box, or a user doing A/V work and a user doing
programming - if it's not a single-use machine, there's *multiple* number
crunchers, DBs, or programmers, and they tend to balance out.

Said tendency can dissapear quite easily here....

> How do we get over quota errors, btw?  Can we get them from write()
> calls?  If so, I don't see a Problem(TM), just an annoyance.

One gotcha here is that it means that you can't do delayed allocation on
writes - you *have* to allocate disk space at each write and then update
the quotas. (And yes, I know that 'man 2 close' says that bad stuff can
happen to your data even after your program exits - that doesn't mean we
should go out of our way to make things worse.. ;)

--==_Exmh_1119891196_6336P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwC78cC3lWbTT17ARApC0AKCBGqN04tsNIu6Wvpq1MYJyhtt7PQCcDGZG
ka34Pp0d87Y1cWn7kDpHU64=
=Yb7G
-----END PGP SIGNATURE-----

--==_Exmh_1119891196_6336P--
