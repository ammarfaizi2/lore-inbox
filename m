Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVBAJOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVBAJOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVBAJMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:12:07 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:24505 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261890AbVBAJFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:05:31 -0500
Date: Tue, 1 Feb 2005 09:02:21 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux@dominikbrodowski.de, linux-kernel@vger.kernel.org,
       cpufreq@ZenII.linux.org.uk
Subject: Re: [PATCH] cpufreq_(ondemand|conservative)
Message-ID: <20050201090220.GA3992@inskipp>
References: <88056F38E9E48644A0F562A38C64FB6003E65C4B@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003E65C4B@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morning Venki,

On Jan 31, Pallipadi, Venkatesh wrote:
>=20
> Hi Alex,
>=20
> Sorry for the late reply. Neat work splitting up all these patches.=20
>=20
Not a problem

> I don't think this patch is required as you are initializing a static
> variable. They should be zero without initialization as well.
>=20
I'll go ahead and fix the lot and then get back to you guys.  Might be a we=
ek=20
though as I have just finished moving into my new flat but there are boxes=
=20
everywhere and (<insert_sound_of_a_scream/>) no Internet access.

Cheers

Alex

> All patches except the above looks good and ready to go. Can you send
> them individually to cpufreq list, with Signed-off line.
>=20
> Thanks,
> Venki=20
> =20
>=20
> >-----Original Message-----
> >From: Alexander Clouter [mailto:alex@digriz.org.uk]=20
> >Sent: Sunday, January 23, 2005 7:00 AM
> >To: linux@dominikbrodowski.de; Pallipadi, Venkatesh
> >Cc: linux-kernel@vger.kernel.org; cpufreq@ZenII.linux.org.uk
> >Subject: [PATCH] cpufreq_(ondemand|conservative)
> >
> >Hi All,
> >
> >Well after Dominik reminded me about the updates to=20
> >cpufreq_ondemand I had
> >made some time back and also my cpufreq governor called=20
> >cpufreq_conservative,
> >I dug out my coffee and started fixing them up for another=20
> >round of peer
> >review.  My governor is pretty much a minor rewrite of the=20
> >cpufreq_ondemand
> >governor but instead gracefully increases and decreases the=20
> >cpufreq which
> >should make it much more suitable for battery power environments.
> >
> >All the patches are for 2.6.11-rc1-mm1 but also apply cleanly to
> >2.6.11-rc1-mm2.  Unfortunately 2.6.11-rc1-mm2 oops'es in key_scancode
> >(drivers/char/keyboard.c) when I presses any keys on my text=20
> >console (tty1)
> >after init has loaded so I am waiting till 2.6.11-rc2-mm1=20
> >appears before I
> >file a bug report.
> >
> >The 'improvements' I have made to cpufreq_ondemand are:
> >
> >1) cpufreq_ondemand-2.6.11-rc1-mm1-01_ignore-nice.diff
> >	this adds a new parameter in /sys called
> >	/sys/.../cpufreq/ondemand/ignore_nice which by default=20
> >is set to '0'.
> >	Any 'nice' tasks running will be considered as idle=20
> >time unless you=20
> >	set the value in ignore_nice to '1', then it will be simply=20
> >	considered as a regular cpu time sucking program.
> >
> >	Last time I did this Venki mentioned some possible corner case=20
> >	conditions[1] and so this time I make it recalculate=20
> >the idle times=20
> >	when the value of ignore_nice is flipped.  If I am=20
> >right this should=20
> >	fix any possible issues that would have arisen from this...?
> >
> >2) cpufreq_ondemand-2.6.11-rc1-mm1-02_check-rate-and-break-out.diff
> >	a very simple patch which prevents us from changing the=20
> >cpufreq from=20
> >	'x' to 'x' un-necessarily.  No-one could find any=20
> >problems with this=20
> >	so it has pretty much remained untouched.
> >
> >3) cpufreq_ondemand-2.6.11-rc1-mm1-03_sys_freq_step.diff
> >	this feature also adds a new parameter in /sys called
> >	/sys/.../cpufreq/ondemand/freq_step which by default is=20
> >set to '5'. =20
> >	You can change this to any value between '0' (why?) and=20
> >'100' to=20
> >	alter how much the cpu will change its frequency by on=20
> >the way down.
> >
> >4) cpufreq_ondemand-2.6.11-rc1-mm1-04_ignore_steal.diff
> >	I noticed a new cpustat has appeared called 'steal'[2]=20
> >which from=20
> >	what I can tell should be treated like an iowait stat. =20
> >'steal' only=20
> >	seems supported by S/390 but I think it should be=20
> >'considered'.  This=20
> >	is a minor patch and if I have gotten confused then=20
> >obviously it=20
> >	should be removed (and from cpufreq_conservative)
> >
> >5) cpufreq_ondemand-2.6.11-rc1-mm1-05_safe_down_skip.diff
> >	although I have not noticed any problems without it=20
> >being done a=20
> >	little alarm bell fires off in my head about how=20
> >down_skip really=20
> >	should be initialised (what if the cpu-freq is not at a=20
> >minimum when=20
> >	we start off or ac power is unplugged and we get=20
> >policy->min changing=20
> >	to a lower value?).  Again a minor patch, if not worth=20
> >it obviously=20
> >	it can be removed and should also be from cpufreq_conservative
> >
> >Now cpufreq_conservative started off as a copy of=20
> >cpufreq_ondemand with all
> >the above patches and then amended from there.  If you install=20
> >the patches
> >you can see with a diff (attached for _show_ and not use) that=20
> >there is not
> >much in the way of difference between them.  It works by me=20
> >creating and
> >initialising an array to each cpu's policy->cur (this could=20
> >should be nice in=20
> >an SMP environment, bug reports would be appreciated) and then=20
> >changing the=20
> >contents by freq_step each time we need to increase or=20
> >decrease the cpufreq. =20
> >This results in a smoother transition on the way up and down. =20
> >Also by the=20
> >nature of this governor it polls 100 times fewer than cpufreq_ondemand.
> >
> >Let me know what you think, the patches work for me, the=20
> >question is do they=20
> >work for you :)
> >
> >Cheers all
> >
> >Alex
> >
> >[1] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110013659005496&w=
=3D2
> >[2] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109888788719020&w=
=3D2
> >
> >--=20
> > ________________________________________=20
> >/ A foolish consistency is the hobgoblin \
> >| of little minds.                       |
> >|                                        |
> >\ -- Ralph Waldo Emerson                 /
> > ----------------------------------------=20
> >        \   ^__^
> >         \  (oo)\_______
> >            (__)\       )\/\
> >                ||----w |
> >                ||     ||
> >

--=20
 _____________________=20
< Nice guys get sick. >
 ---------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/0WcNv5Ugh/sRBYRAujnAJ98yxO16YPsnfZSXGRG/s+kkH5uxQCeNVSu
o40OIO1HmyJflTbcrAGTZmQ=
=hqc0
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
