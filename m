Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281337AbRK0Pv7>; Tue, 27 Nov 2001 10:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281255AbRK0Pvj>; Tue, 27 Nov 2001 10:51:39 -0500
Received: from t2.redhat.com ([199.183.24.243]:757 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S281128AbRK0Pvb>; Tue, 27 Nov 2001 10:51:31 -0500
Date: Tue, 27 Nov 2001 09:51:24 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Matteo Sasso" <icemaze@tiscalinet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug (?) report
Message-Id: <20011127095124.6d5cd06d.reynolds@redhat.com>
In-Reply-To: <GAELJDOEMJGDLHEONDIOEEBOCBAA.icemaze@tiscalinet.it>
In-Reply-To: <GAELJDOEMJGDLHEONDIOEEBOCBAA.icemaze@tiscalinet.it>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.+/xj,O/EbAy,+p"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.+/xj,O/EbAy,+p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Quick to seize an opportunity, "Matteo Sasso" <icemaze@tiscalinet.it> wrote:

> I'm quite a new linux user and system administrator (my own!) and I
> encountered the following problems:
> 1) As the system starts up and the mixer settings are loaded, modprobe
> complains that 'sound-slot-0' and 'sound-service-0-0' modules are not
> present (in my kernel/drivers/sound directory I got just ac97_codec.o,
> emu10k1, sound.o and soundcore.o). I've got a Sound Blaster Live! 5.1, a
> '2.4.16-pre1' kernel and kmod usually works good, failing only with sound
> (both with 'gom' mixer and with 'mpg123' player), so I have to 'modprobe
> emu10k1' manually.

Add the following line to "/etc/modules.config":

	alias sound-slot-0 emu10k1

and then:

	# /sbin/depmod -ae

You need this because your module is named "emu10k1" but the sound system is
looking for a module named "sound-slot-0" (this is a computed module name, not
an actual name).

> 2) I tried for the first time to play a bit with kernel source and I was
> trying to lower console_loglevel in order to have all the startup printk's
> disappear. I lowered the DEFAULT_CONSOLE_LOGLEVEL constant in
> 'kernel/printk.c' from '7' to '5' (just to be sure) but that wasn't enough
> to get rid of all those annoying KERN_INFO. Why didn't it work?

You don't need to mess with that.  Just:

	# echo 5 > /proc/sys/kernel/printk

anytime you want.  Of course, since Step-1 above fixed your original problem,
you won't need to do this at all ;-)

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.+/xj,O/EbAy,+p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwDtoEACgkQWEn3bOOMcuryuACdGTYMhbGhzA17yOOGMoRKMelM
GxIAoLAUBLXv9WLcPlsgPqDjsBv1VFeW
=8on0
-----END PGP SIGNATURE-----

--=.+/xj,O/EbAy,+p--

