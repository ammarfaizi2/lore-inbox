Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSBDNW0>; Mon, 4 Feb 2002 08:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBDNWP>; Mon, 4 Feb 2002 08:22:15 -0500
Received: from fysh.org ([212.47.68.126]:56333 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S288969AbSBDNWC>;
	Mon, 4 Feb 2002 08:22:02 -0500
Date: Mon, 4 Feb 2002 13:21:46 +0000
From: Athanasius <Athanasius@gurus.tf>
To: Burj?n G?bor <buga+dated+1013036430.1fd862@elte.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 NFS hangup
Message-ID: <20020204132146.GB18430@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>,
	Burj?n G?bor <buga+dated+1013036430.1fd862@elte.hu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu> <shsbsf61di3.fsf@charged.uio.no> <20020203213422.GA703@csoma.elte.hu> <15453.48475.123973.610574@charged.uio.no> <20020203230030.GA14478@csoma.elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20020203230030.GA14478@csoma.elte.hu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2002 at 12:00:30AM +0100, Burj?n G?bor wrote:
> On Sun, Feb 03, Trond Myklebust wrote:
>=20
> > Are you seeing any kernel log messages about 'Tx FIFO error!' that
> > might indicate that particular code is getting triggered?
>=20
> No, nothing logged except the NFS related messages.  However, after NFS
> hangup I cannot scp from the host, but ssh works...   I am beginning to
> think that this is not an NFS issue.  Then what could it be?

   I'm seeing something like this as well.  Two machines using
BNC/thinwire (yes, I know, waiting on finances to make this better), 2
other machines on the same segment.  I use an NFS mount from the server
(jimblewix) on the workstation (emelia) for amongst other things playing
mp3s.
   Machine specs:

	SERVER
	PII-400 @400MHz
	384MB PC100 SDRAM
	eth0: NE2000 (ISA) <--- internal interface
	eth1: 3com509b     <--- external interface, NFS traffic NOT on this
	Linux jimblewix 2.4.17 #7 Sat Jan 5 16:15:44 GMT 2002 i686 unknown

	WORKSTATION
	AMD Athlon XP 1600+ 1.4GHz, not overclocked
	512MB PC2100 DDR
	eth0: NE2000 (PCI eth0: NetVin NV5000SC found at 0xdc00, IRQ 11,
	00:40:95:45:91:38.)
	Linux emelia 2.4.18-pre7 #3 Thu Jan 31 07:07:48 GMT 2002 i686 unknown
	ALSO on 2.4.17

Repeatedly I'll have xmms stop playing an mp3 mid-file due to NFS
timeouts.  I have the same problem cp'ing large files over the NFS
mounts as well.  Currently these are soft mounts.  IF I change them to
hard mounts rather than an i/o error on that file and control coming
back the app will just lock hard in D state until a reboot.

/etc/fstab on the WORKSTATION:

192.168.0.162:/home/users on /home/users type nfs (rw,nosuid,nodev,nolock,r=
size=3D8192,wsize=3D8192,soft,intr,addr=3D192.168.0.162)
192.168.0.162:/usr/local on /export/miggy-1/usr-local type nfs (rw,nosuid,n=
odev,rsize=3D8192,wsize=3D8192,soft,intr,addr=3D192.168.0.162)
192.168.0.162:/other on /other type nfs (rw,nosuid,nodev,rsize=3D8192,wsize=
=3D8192,soft,intr,addr=3D192.168.0.162)

That last one is usually where I'm doing the big cp'ing to/from.

I've just had the problem twice whilst typing this email:

Feb  4 13:07:31 emelia kernel: nfs: server 192.168.0.162 not responding, ti=
med o
ut
Feb  4 13:07:52 emelia last message repeated 2 times
Feb  4 13:12:17 emelia kernel: nfs: server 192.168.0.162 not responding, ti=
med o
ut
Feb  4 13:12:38 emelia last message repeated 2 times

<NOTHING in /var/log/kern.log on jimblewix>

I haven't had any of the following since this line:

kern.log.2.gz:1649:Jan 18 07:39:28 emelia kernel: nfs: task 13016 can't
get a request slot

   Whilst I appreciate that thinnet/BNC isn't the best technology to be
using this segment isn't THAT busy most of the time, certainly not the
majority of times mp3s cut out (ones that WILL play fine end to end at
other times so it's not corruption in them). =20

  If there any patches/options (other than hard mounts without other
changes) I should be trying please let me know.

thanks,

-Ath
--=20
- Athanasius =3D Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAjxeiuoACgkQzbc+I5XfxKf8wACXXa6OLHDJkLaik3CLGjdHKKLX
OwCgieX3892ZRSGFoIYg5kR7vC/AYbs=
=SUYz
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
