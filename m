Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDVQws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDVQws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 12:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWDVQws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 12:52:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:11406 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750708AbWDVQwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 12:52:47 -0400
Date: Sat, 22 Apr 2006 12:01:09 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Valdis.Kletnieks@vt.edu,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-Id: <20060422100108.GA7292@thorium.jmh.mhn.de>
Mail-Followup-To: Dave Neuer <mr.fred.smoothie@pobox.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, Valdis.Kletnieks@vt.edu,
	Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>,
	Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <200604212006.k3LK6LtH015500@turing-police.cc.vt.edu> <1145651704.21749.305.camel@moss-spartans.epoch.ncsc.mil> <161717d50604211438h2f6f768fgf1e8466065802b5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <161717d50604211438h2f6f768fgf1e8466065802b5e@mail.gmail.com>
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.12-10-386 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dave Neuer <mr.fred.smoothie@pobox.com> [2006-04-21 23:41]:
> On 4/21/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > IIUC, AppArmor does impose such constraints, but only from the
> > perspective of an individual program's profile.  Upon link(2), they
> > check that the program had link permission to the old link name and that
> > both the old link name and new link name have consistent permissions in
> > the profile, and they prohibit or limit by capability the ability to
> > manipulate the namespace by confined programs.  But this doesn't mean
> > that another program running under a different profile can't create such
> > a link (if allowed to do so by its profile, of course), or that an
> > unconfined process cannot do so.  There is no real "system policy" or
> > system-wide security properties with AppArmor; you can only look at it
> > in terms of individual programs (which themselves are identified by path
> > too).
> >
> > > However, I'll say up front that such an argument would only suffice to
> > > move it from "broken" to "very brittle in face of changes" (for insta=
nce,
> > > would such a hardlink restriction cause collateral damage that an att=
acker
> > > could exploit?  How badly does it fail in the face of a misdesigned p=
olicy?)
> >
> > Indeed.  I think Thomas Bleher made a good assessment of it in:
> > https://lists.ubuntu.com/archives/ubuntu-hardened/2006-March/000143.html
>=20
> But what about Dr. Cowan's response at:
> https://lists.ubuntu.com/archives/ubuntu-hardened/2006-March/000144.html

I didn't have time to answer his mail then, but I will try to do so now.

Mr. Cowan asserts that today Linux is used mainly as a single-user
machine or a dedicated network servers and that AppArmor is designed to
secure these.
For me, this is not enough, because I also need to secure multi-user
computers and I don't want to learn a new security mechanism for these
machines. (I worked several years as a system administrator for a
university where this was my main job).

But the more important point is that, IMO, AppArmor also fails to secure
e.g. dedicated network servers. Consider for example an Apache server
where users are allowed to install CGIs. How do you prevent an attacker
=66rom subverting a buggy CGI and using the host to send spam?=20
(Hint: It's really easy using standard SELinux policy).

> In particular, if you don't trust your users, why do you give them the
> ability to create links?

Well, let's have a look at how Linux is used at e.g. university (that's
where I have the most experience). Lot's of untrusted students, doing
lots of weird things. They need to be allowed to run all sorts of
software, experiment with Linux, share files locally and so on. It's not
easy to confine such users.

On those machines, you don't care very much about individual users (if a
user is stupid enough to get his account hacked you just wipe his
homedir and restore from backup), but you do care about system integrity
and secrecy of things like /etc/shadow.
It is possible to confine such a system using SELinux (I've done it). Is
it possible using AppArmor? As far as I understood it is not. For me,
that's a severe limit in functionality.

Thomas


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFESf7kD9qpeVMU938RAmpUAJ9CIjMikLJ23tGtiMhQHFWTkAU4+QCfSJnj
MH2zsBCH5lhhBuK7p9WwkFY=
=xg0B
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
