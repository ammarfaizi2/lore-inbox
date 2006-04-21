Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWDUTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWDUTwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWDUTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:52:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29096 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751267AbWDUTwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:52:10 -0400
Message-Id: <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ken Brush <kbrush@gmail.com>
Cc: Crispin Cowan <crispin@novell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Fri, 21 Apr 2006 08:23:51 PDT."
             <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu> <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
            <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145649063_14107P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2006 15:51:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145649063_14107P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 Apr 2006 08:23:51 PDT, Ken Brush said:
> On 4/20/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > On Wed, 19 Apr 2006 17:19:04 PDT, Crispin Cowan said:
> > > Valdis.Kletnieks@vt.edu wrote:
> > The threat model is that you can take a buggy application, and constrain its
> > access to priv A in a way that causes a code failure that allows you to abuse
> > an unconstrained priv B.
> 
> So you are talking about a 2 prong attack. One in where you somehow
> trick program A to do something that it's allowed to. That then would
> cause an error in program B ? Or cause program B to do something
> wonky.

No, it's a two prong attack against *one* program.  For instance, the Sendmail
bug - the attack A was to cripple its ability to drop privs, which then exposed
it to abuse B of running at a higher priv than it should have.

The crucial point here is that the attacker is trying to gain access to
(for instance) the ability to write to any file, but gets there by crippling
some *other* priv.

Another (totally made up theoretical, hopefully) Sendmail-ish example would be
to artificially constrain it's ability to open port 25 for listening, and then
using a symlink attack to redirect its complaint "I can't open 25" to trash
some file you can't read/write yourself....

The reason that this is such a can-of-worms security wise is that the vast majority
of programs have *not* had sufficient auditing of their error-handling code.
As a result, blindly applying a privilege constraint to clip off some priv A
that the policy writer doesn't think is needed can "load a round in the chamber"
for a clever attacker to abuse.

(Note that this concern applies equally to AppArmor and SELinux and almost any
other constraint-based system.  It's merely more *likely* to bite AppArmor
based systems, because it's marketing itself as "user/sysadmin friendly" - and
thus more likely to attract people trying to secure their system without real
understanding.  You don't get many problems with SELinux down this path,
because most SELinux people already have a mindset that "Even with proper
tools, writing a policy is hard and requires some careful thought/analysis"...)




--==_Exmh_1145649063_14107P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFESTencC3lWbTT17ARAuJfAJwLkiLZiWeFDiA5RiJLkeUpso/8tQCfT9Gy
upCw4vXe8tuFNDYJsKg8x6c=
=doaM
-----END PGP SIGNATURE-----

--==_Exmh_1145649063_14107P--
