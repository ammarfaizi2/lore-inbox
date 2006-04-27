Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWD0G4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWD0G4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWD0G4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:56:53 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:62889 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id S1750896AbWD0G4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:56:52 -0400
Date: Thu, 27 Apr 2006 08:56:49 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Olivier Galibert <galibert@pobox.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-Id: <20060427065649.GA7361@thorium.jmh.mhn.de>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org> <20060424140831.GA94722@dspnet.fr.eu.org> <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil> <20060425222642.GA4921@dspnet.fr.eu.org> <1146053671.28745.48.camel@moss-spartans.epoch.ncsc.mil> <20060426160323.GA29492@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20060426160323.GA29492@dspnet.fr.eu.org>
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.12-10-386 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Olivier Galibert <galibert@pobox.com> [2006-04-26 18:03]:
> On Wed, Apr 26, 2006 at 08:14:31AM -0400, Stephen Smalley wrote:
> > On Wed, 2006-04-26 at 00:26 +0200, Olivier Galibert wrote:
> > > On Tue, Apr 25, 2006 at 12:29:26PM -0400, Stephen Smalley wrote:
> > > > This generally indicates a problem in policy or the application that
> > > > needs to be fixed.  It doesn't mean that object labeling is itself
> > > > problematic, anymore than the existing owner and mode information i=
n the
> > > > inode is inherently problematic.
> > >=20
> > > Default owner and mode are handled by the kernel because otherwise it
> > > would indeed be inherently problematic.  Don't expect normal
> > > applications, editors or xml libraries to change from the normal
> > > open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666).  SELinux is not, and will
> > > not, ever, be their problem.
> >=20
> > First, default labeling is also handled by the kernel, as with default
> > owner and mode.  Files will be labeled in accordance with the policy
> > based on the label of the creating process, the label of a related
> > object (parent directory, to support inheritance properties when
> > appropriate), and policy rules.  But this is not always sufficient, any
> > more than default owner and mode is always sufficient for file creation.
>=20
> And how do you plan to get correct default label without taking
> paths/names into account but only the parent directory, for these
> files created by the exact same text editor:
> - $HOME/.slrnrc
> - $HOME/.fetchmailrc
> - $HOME/.procmailrc
> - $HOME/todo.txt

How do you get correct mode and ownership? The kernel doesn't handle
that either. If you need something special, you use the tools to set it
(chmod, chgrp, ...). Ditto for SELinux.
Users already have to deal with that: fetchmail will fail to run if
~/.fetchmailrc has more permissions than 0600.

SELinux can make it even easier for you if you want:=20
It has a database which stores the default labels for files. You can use
"restorecon $file" to set the default label for any file. You can also
change your editor so it queries this database and sets the right label
when saving a new file.
Fedora also just added restorecond, a small daemon which uses inotify to
watch certain paths and set the right label when the file or directory
is created. Reportedly it works very well, so you can do a
	mkdir public_html; ls -lZd public_html
and already see the right label on the file.

> > Second, the entire point of SELinux is to get MAC into the mainstream,
> > and it is enabled by default in Fedora.  Unless that changes, it should
> > gradually affect a change in the applications to adapt to the presence
> > of SELinux, just as they have gradually adapted to other changes in the
> > kernel.  Such change is always painful, but MAC is necessary as a
> > fundamental building block if we are going to ever have improved
> > security.  And not all applications have to change; many can just use
> > the default behaviors.
>=20
> Something will have to tell the system that certain file names/paths
> are a-priori special, whether they exist or not.  And I *mean* file
> names, not objects.  And that won't happen reliably in userspace.

Well, then I don't understand your threat model. When I move files to
another place I certainly don't want the label to change. Imagine Linux
did this on file permissions and suddenly everyone could read your
passwords out of your .fetchmailrc.old which you saved there for backup.

> > Um, perhaps you could be more concrete?  Difficult to have a rational
> > discussion otherwise.  This division of "protecting application
> > behavior" vs. "protecting files" is arbitrary and meaningless.  =20
>=20
> Well, take the example of .procmailrc.  It is a file that is taken
> into account if it exists, but doesn't have to exist.  It is a file
> which can be used to copy all the mail of one user to somewhere else,
> so it is very data-security sensitive.  So this is a file that may or
> may not exist, which should not be created by anybody else than the
> user itself (after all, you're into protecting from root too), and
> needs to be able to be created by a mac-unaware, user-preferred text
> editor and just work.  How do you expect to handle that reliably
> without path-based mechanisms in the kernel?

Users already set modes themselves (see .fetchmailrc, .ssh,
public_html), so I don't see a problem with them calling restorecon
(see above).

> You need path-based mechanisms to at least:
> - prevent/allow some specific names from being created in specific
>   conditions.=20

I don't think that fits the Unix model. If you want that you should use
separate directories.
Giving untrusted programs write access to your homedir is a bad idea,
but even if you need to do that, SELinux can protect you. In this
specific example, procmail would simply not be allowed to read files
created by untrusted programs (e.g. your IRC client).

> - give correct default labels to new files
>=20
> Object labelling won't help here simply because all of that happens on
> file creation.  And you need path-based mechanisms if you want to have
> any kind of decent problem tolerance.  Because at that point, SELinux
> having prevented me twice to log into my own system on the console
> with two different distributions for similar causes (labels lost), I
> won't trust it for any system I want to be able to access remotely
> with a decent chance of success in case of problems.

Certainly there are things which could be made better - both
documentation and userspace-tools. But I don't think it requires
changing the kernel mechanism.

Thomas


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEUGsxD9qpeVMU938RAuNdAJ9mYIeEct/ZlRo9yRseom3DMHQ/VgCfURPZ
WpnmHM+4zA1rvL8R18cA4xE=
=8bIb
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
