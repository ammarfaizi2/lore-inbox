Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTLJDTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTLJDTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:19:24 -0500
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:26775 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S262789AbTLJDTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:19:22 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: hanasaki <hanasaki@hanaden.com>
Subject: Re: VT82C686  - no sound
Keywords: sound,run,modules,mixer,loaded,alsactl
References: <3FD54817.9050402@hanaden.com>
	<20031209101808.GA18309@stud.fit.vutbr.cz>
	<200312091651.27677.kiza@gmx.net> <3FD67ECE.4010707@hanaden.com>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, hanasaki
 <hanasaki@hanaden.com>
Date: Wed, 10 Dec 2003 13:19:12 +1000
In-Reply-To: <3FD67ECE.4010707@hanaden.com> (hanasaki@hanaden.com's message
 of "Tue, 09 Dec 2003 20:02:54 -0600")
Message-ID: <microsoft-free.87iskpuzpr.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

|--==> "h" == hanasaki  <hanasaki@hanaden.com> writes:

  h> Hmmm I think you are saying I have all the right things loaded?
  h> So why does esd run but not make startup beeps and gnome makes no
  h> sounds and alsa play makes no sounds?

Load your sound modules, then run `alsamixer' and check the volume
levels.  If they are sitting on zero (which is what I suspect) boost
them up to what you want and quit out of the mixer.

Then run `alsactl store'.  That will store your mixer setting to
`/etc/asound.state'.  Next, check `/etc/modprobe.conf' for a line
similar to...

install snd /sbin/modprobe --ignore-install snd && /usr/sbin/alsactl restore

...which will ensure that your mixer settings are restored whenever
your sound modules are loaded.

Some sound cards, when they initialise, have all their levels set to
zero.  You have to reset them every time the card initialises
(whenever the modules are loaded), which is what `alsactl' does.

HTH

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/WkLUACgkQHSfbS6lLMAM2SQCgl0ie8ABIjBEGSeEI0bXoMcpD
4R4An1nGgKW4Xt7QEIe1LZSTIgm3PL2K
=qEqn
-----END PGP SIGNATURE-----
--=-=-=--
