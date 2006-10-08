Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWJHMlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWJHMlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 08:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWJHMlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 08:41:51 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:39121 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1751125AbWJHMlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 08:41:50 -0400
Date: Sun, 8 Oct 2006 08:41:46 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: "raise.sail@gmail.com" <raise.sail@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
Message-ID: <20061008124146.GA4710@aehallh.com>
Mail-Followup-To: "raise.sail@gmail.com" <raise.sail@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, greg <greg@kroah.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
References: <200609291624123283320@gmail.com> <20060929095913.f1b6f79d.rdunlap@xenotime.net> <d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com> <45286B85.90402@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sosn/fv6aiTyEgxl"
Content-Disposition: inline
In-Reply-To: <45286B85.90402@gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sosn/fv6aiTyEgxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 08, 2006 at 11:07:49AM +0800, raise.sail@gmail.com wrote:
> Dmitry Torokhov wrote:
> > I re-read these patches again and the main problem with the current
> > implementation is that it alters input devices's properties after
> > device has been registered and presented to userspace. That means that
> > hotplug users that presently can inspect device's capabilities and
> > decide if they are "interested" in device will not be able to do so
> > anymore. For example I think X event interface drivers examine input
> > devices and decide if it should be handled by as keyboard or pointing
> > device so it is possible for them to not notice that touchpad
> > capabilities were added to a keyboard later. For now the only thing
> > that is allowed to change after device has been registered is keymap.
> >
> > Then there is issue with automatic loading of these sub-drivers. How
> > do they get loaded? Or we force everything to be built-in making HID
> > module very fat (like psmouse got pretty fat, but with HID prtential
> > for it to get very fat is much bigger).
> >
> > The better way would be to split hid-input into a library module that
> > parses hid usages and reports and is shared between device-specific
> > modules that are "real" drivers (usb-drivers, not hid-sub-drivers).
> >

> I am sorry this reply so late, because of I had holiday for the National
> Day.
> 
> Well, however, I don't think this is problem. ~_~

I'm afraid that it really is a problem.

Existing user space, some of which I have written myself, is going to
respond very poorly to being told that an input device does X and Y, and
then abruptly having the device start doing Z on us.  No matter it's a
new few buttons, a new few keys, or a touch-pad added to the keyboard,
it's just not going to be happy, and it is most definitely not going to
actually support the new events.

This is a real killer.  You can remove the input device and reregister
it with new capabilities[0], you can wait to register until you know them
all, but you can't change those of an existing device without breaking
userspace.

0: If you keep all the ID identical, userspace may have the capabilities
cached.  This may also cause problems, but if Dmitry or Greg calls that
a userspace bug I'll believe them and find a workaround.  But existing
user space _may_ break in roughly the same ways as if you just change
capabilities on an existing input device, that said, remove and readd
would be greatly preferred just because it does give us a chance to see
that something changed.


Zephaniah E. Hull.
xf86-input-evdev maintainer.


-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I could imagine that there might be some GPL project out there that
_deserves_ getting sued(*) and it has nothing to do with Linux.

                Linus

(*) "GNU Emacs, the defendent, did inefariously conspire to play
towers-of-hanoy, while under the guise of a harmless editor".

--Sosn/fv6aiTyEgxl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKPIKRFMAi+ZaeAERAlTUAJsE9iAcHkQcCYqXom4IO7bBltfVwACfdnBW
FmiPGJCyL2bFlry7v92saqQ=
=YGoi
-----END PGP SIGNATURE-----

--Sosn/fv6aiTyEgxl--
