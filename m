Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVJICOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVJICOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 22:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVJICOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 22:14:30 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:52411 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S932206AbVJICO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 22:14:29 -0400
Date: Sat, 8 Oct 2005 19:14:13 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, usb-storage@lists.one-eyed-alien.net,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [usb-storage] usb: drivers/usb/storage/libusual
Message-ID: <20051009021413.GA25979@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	Greg KH <greg@kroah.com>, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20050927205559.078ba9ed.zaitcev@redhat.com> <20050928085159.GA11862@kroah.com> <20051008140132.49f9eec3.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20051008140132.49f9eec3.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2005 at 02:01:32PM -0700, Pete Zaitcev wrote:
> This patch adds a shim driver libusual, which routes devices between
> usb-storage and ub according to the common table, based on unusual_devs.h.
> The help and example syntax is in Kconfig.
>=20
> Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
>=20
> ---
>=20
> I think libusual is ready for Andrew's tree now. I realize that the use
> of request_module is an inkblot in this copybook, so maybe it's not the
> time for Linus' tree yet. Another concern I have is if we have any races
> with hotplug, udev, and HAL.
>=20
> I haven't heard from Adrian yet, but I suppose it's a good sign.
> No word from Matt Dharm either, which is not so good... But I do have
> Alan Stern's buy-in.

Well, I guess it's time for me to comment, then.   I have been watching
with great interest.

I have to say, I totally agree that this is a problem that needs solving.
The current situation is a mess....

But, I'm not sure this is much better.  It's certainly different, but I
fear that we're going to spend a lot of time explaining to end-users a new
and less-than-totally-obvious system.

Technically, this is much better than what we have.  I'm just not sure
about the "end user experience".

And I think I'm totally convinced now that request_module() needs some
serious help.  Either it needs to go away entirely, or be replaced by a
helper, such that request_module() gets a module loaded, but module
binding to a device is controlled via another mechanism.

Overall, send it to Andrew's tree.  But I'd really like to see it live
there for an extended period of time before going to Linus.  And I'd also
like to see some ideas for the final solution, which would apply to HID
devices with the same problem.

I hate solving problems twice.  It creates twice as much work for everyone,
including distro folks and end-users.  Let's figure this out as a more
generic driver-binding problem for all drivers once and for all.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

How would you like this tie wrapped around your hairy round head?
					-- Greg
User Friendly, 9/2/1998

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDSHz1HL9iwnUZqnkRAosbAJ9kN8jPntU5EoDlUxRI6mJFB39anwCeMg3J
dSHkAj4CPFuB/t4QdSYzZO8=
=a6bD
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
