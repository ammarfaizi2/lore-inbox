Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310454AbSCBVJG>; Sat, 2 Mar 2002 16:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310456AbSCBVIq>; Sat, 2 Mar 2002 16:08:46 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:43449 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S310454AbSCBVI2>; Sat, 2 Mar 2002 16:08:28 -0500
Date: Sat, 2 Mar 2002 16:08:23 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
Message-ID: <20020302210823.GB4958@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org> <3C7BD91C.3B758704@zip.com.au> <20020226185907.GG803@ufies.org> <20020226230010.GI803@ufies.org> <3C7C1B07.92F9B8E0@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <3C7C1B07.92F9B8E0@zip.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: multipart/mixed; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 03:32:23PM -0800, Andrew Morton wrote:
> christophe barb=E9 wrote:
> >=20
> > Now that the forget_option bug is solved I have the following :
> >=20
> > Each time I suspend, the card resume in a bad state but return in a good
> > state after that :
> >=20
> > NETDEV WATCHDOG: eth0: transmit timed out
>=20
> The transceiver didn't power up, or came up in silly
> mode.  I'll see if I can reproduce any of this.
> What NIC are you using?

I have played a little with mii-diag and vortex-diag without success.=20
'mii-diag' didn't show differences between good and bad states.
'vortex-diag' show a difference with the -aa option, I attach the
output.

I have tried some modifications in the driver, basically to do what
tx_timeout does in the resume function without success.
After that I have realized that the timeout, which occurs most of the
time 1 minute after the resume, is not the reason why the card returns
in the correct state (watchdog is set to 1000) otherwise it would occurs
earlier.

Andrew, will you send a patch to marcello for the 'always bigger card
id' bug or do you want me to do it ?

Christophe

>=20
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

In a cat's eye, all things belong to cats.
--English proverb

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="vdiag-aa.output.ok"

vortex-diag.c:v2.05 5/15/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3CCFE575CT CardBus adapter at 0x4000.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0002 0000 0808 06ff ffff 0000.
  Window 1: 0000 0000 0000 0000 0000 0000 0000 2000.
  Window 2: 0100 d302 1ede 0000 0000 0000 4102 4000.
  Window 3: 0000 0060 05ea 0000 0040 1000 0800 6000.
  Window 4: 0000 0000 0000 0ce0 0003 8800 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0000 0000 0000 0000 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0x4000
  0x4010: 00000000 00000000 00000016 00000000
  0x4020: 00000020 00000000 00080000 00000004
  0x4030: 00000000 75718a8f 00c2e030 00080004
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  MII.
Transceiver type in use:  MII.
 MAC settings: half-duplex.
 Station address set to 00:01:02:d3:de:1e.
 Configuration options 4102.

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="vdiag-aa.output.pb"

vortex-diag.c:v2.05 5/15/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3CCFE575CT CardBus adapter at 0x4000.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0000 0000 5555 06ff ffff 0000.
  Window 1: 0000 0000 0000 0000 0000 0000 0000 2000.
  Window 2: 0100 d302 1ede 0000 0000 0000 4102 4000.
  Window 3: 0000 0060 05ea 0000 0040 1000 0800 6000.
  Window 4: 0000 0000 0000 0ce0 0003 8800 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0000 0000 0000 0000 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0x4000
  0x4010: 00000000 00000000 00000000 00000000
  0x4020: 00000020 00000000 00080000 00000004
  0x4030: 00000000 2c01d3ff 00c2e000 00080004
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  MII.
Transceiver type in use:  MII.
 MAC settings: half-duplex.
 Station address set to 00:01:02:d3:de:1e.
 Configuration options 4102.

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="mii-diag.output"

Basic registers of MII PHY #0:  3100 782d 0300 e54b 01e1 0000 0000 0000.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner does not do autonegotiation, and this transceiver type
  does not report the sensed link speed.
   End of basic transceiver information.


--gj572EiMnwbLXET9--

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8gT9Hj0UvHtcstB4RAqztAJ91wYd53IC75AHFOY1yc+nrjZjx+ACeJXMa
lVsDTFV72Yg/DWwtbKhUToQ=
=NxMv
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
