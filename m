Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbRGABaK>; Sat, 30 Jun 2001 21:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbRGAB37>; Sat, 30 Jun 2001 21:29:59 -0400
Received: from cdsl163.ptld.uswest.net ([209.180.170.163]:15717 "HELO
	knghtbrd.dyn.dhs.org") by vger.kernel.org with SMTP
	id <S264937AbRGAB3z>; Sat, 30 Jun 2001 21:29:55 -0400
Date: Sat, 30 Jun 2001 18:08:59 -0700
From: Joseph Carter <knghtbrd@d2dc.net>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mac USB keyboards (Was: USB Keyboard errors with 2.4.5-ac)
Message-ID: <20010630180859.A5557@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20010701020758.B26841@win.tue.nl>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2001 at 02:07:58AM +0200, Guest section DW wrote:
> > If you're using it on a wintel arch machine, have you managed to get the
> > numeric keypad's =3D key or the power key to work?  Doesn't here and I'=
ve
> > tried more than one model of keyboard on more than one machine, no luck
> > even with showkey.  MacOS likes the keys just fine, naturally.
>=20
> I just borrowed a Mac keyboard and looked.
> The Numpad =3D key gave scancode 5c, the power key gave e05e.
> The command getkeycodes showed that the former was assigned to
> keycode 127, while the latter was not assigned.
> The command "setkeycodes e05e 25", where 25 is the keycode
> for the letter p, made the power key produce the letter p.

I was pretty sure this didn't work the last time I tried it, but I went
ahead and fed your example to setkeycodes in case I missed something.  The
power key still does nothing..


> You see that you can do with a USB keyboard what you can do
> with an ordinary keyboard: use setkeycodes to assign a keycode
> to scancode combinations that didnt have one yet, use loadkeys
> to assign a function to a keycode.

I suspect the problem is that the HID driver never sees these keys in the
first place.  Just a wild guess.


> To understand the details of the code, trace the steps:
> (i)  The USB code can be found e.g. on
> 	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html
> We find that Power is 102 and that Keypad-=3D is 103.

I find that KP =3D can also be 134, according to this.  I suppose I could
toss some debuggatory messages into the HID driver on receipt of a USB
code that is unknown to tell me which one it is so it will be known in
that case.  =3D)  It's a longshot, but it sounds like a reasonable thing to
try.

> (ii) In usbkbd.c:usb_kbd_keycode[] these keycodes are converted
> to 116 and 117, and then input_event is called.

As noted, I'm using the HID driver, but the definitions match.  Neither
driver defines key 134.


> (iii) In keybdev.c:x86_keycodes[] these codes are converted
> to 350 and 92. The former is 256+94 and becomes e05e, the latter 5c.
> This is fed further to the usual keyboard processing.

Right, that makes perfect sense.  Unfortunately, as I said, it isn't
working.  The keys do the right thing on a mac.  I can only assume that
the keyboard is being convinced somehow that these keys should be "dead"
(or the motherboard is deciding that for me..)  The other thought I have
is that perhaps the =3D key (the important one) is in fact key 134 on this
thing and that the power key is something else entirely.

This is, of course, just wild speculation at the moment.  I actually have
no idea if I am on the right path or going the wrong way down a one way
street.  I can assume then that if you see me running back this way fast
as I can go, the one way street has it..  ;)

Thanks for the reference.  Very nifty.

--=20
Joseph Carter <knghtbrd@d2dc.net>                   Free software developer

<dhd> is there a special christmas pack for quake
<dhd> where you get to be like the santa robot on futurama?
<dunham> dhd: that would be a rather unbalanced game...
<Knghtbrd> dunham: that's the idea.  ;>


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjs+eCsACgkQj/fXo9z52rODSgCdF65iQRMqiqI+XFrrykJkaDps
GnsAn0sum4EPpgVAjb/EJDq9juuHgAFx
=WXmi
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
