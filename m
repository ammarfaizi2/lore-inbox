Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVCJAT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVCJAT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCJARi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:17:38 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:25989 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S262401AbVCJAQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:16:52 -0500
Date: Thu, 10 Mar 2005 01:16:48 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [announce 7/7] fbsplash - documentation
Message-ID: <20050310001647.GA19784@spock.one.pl>
References: <20050308021706.GH26249@spock.one.pl> <200503090117.12755.arnd@arndb.de> <20050309020527.GA20294@spock.one.pl> <200503091640.10421.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <200503091640.10421.arnd@arndb.de>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 04:40:09PM +0100, Arnd Bergmann wrote:

> Ok, I now saw that you call call_usermodehelper with wait=3D=3D1. Why is =
that
> necessary? If you don't wait there, you don't need any hacks around the
> console semaphore, because the helper will simply wait for change_console
> to finish.

That could work, assuming that:
a) the helper can always finish unpacking the image before=20
   change_console releases the semaphore
b) the console is not redrawn at one point before change_console is=20
   finished (I'm sorry, I don't have time to check that right now)

If one of this assumptions is wrong, we would end up with first=20
displaying the wrong background picture and then quickly painting
the new one (I doubt this would make a good impression on the user..).
 =20
> > What are the alternatives to the ioctl? A relatively clean way of
> > feeding the data back to the kernel would be using sysfs. However, to
> > make it sane we would have to export the various components of struct
> > vc_splash in /sys/class/tty/tty<x> (otherwise, we would probabky have
> > to pass aggreaget data types through a sysfs entry -- something that is
> > IMO much worse than an ioctl). That however could be a little
> > problematic -- tty_class is currently defined as a class_simple.
> > To add entries other than the standard 'dev' we would have to define a
> > completely new class, right? That sounds like a rather intrusive
> > change..
>=20
> Right. I don't think that sysfs is the right interface for this problem.
> For a short moment I had the idea that you could write an escape sequence
> to the tty device, but that would race against the regular output.
> An ioctl on the tty device is probably the best you can do here, but
> if that's not possible, creating a misc device in order to do ioctl on it
> is a rather ugly hack.

Agreed, that might not be the nicest thing to do, but it just seems
there isn't much of a choice in this situation.

I'm going to be away for the next 10 days or so. When I get back I'll
start testing some of the proposed changes. Maybe by using things like
firmware_request it would at least be possible to make the splash
interface a little simpler.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCL5HvaQ0HSaOUe+YRAnzqAJ9bqACc3XEtkdfeXFg+UrW/LBk0XACbBojl
kc5B9zJWuw0VIf6by+UsuG4=
=X6Ka
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
