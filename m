Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRFKNwO>; Mon, 11 Jun 2001 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbRFKNwE>; Mon, 11 Jun 2001 09:52:04 -0400
Received: from ns.suse.de ([213.95.15.193]:32008 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263089AbRFKNvr>;
	Mon, 11 Jun 2001 09:51:47 -0400
Date: Mon, 11 Jun 2001 15:51:45 +0200
From: Joerg Reuter <jreuter@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
Message-ID: <20010611155145.A12203@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Face: #DGJ)DCeau/h"w7G~n9r|/jxvQQrtU)nat27v-><7':==-=.mfnXc+8&qOj`*R|qPr14[|4
	E_BUo5T*NT\(+fE7wr3}QoN*!c7\.Z.DiA{ko;01^TCi$K}1TIV|bNO.$jm;i<A,|
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
Date: Mon, 11 Jun 2001 15:45:07 +0200 (CEST)
From: jreuter@suse.de (Joerg Reuter)


>> [BUG] (but i'm not sure whey we're missing the initial irq).
>> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/net/hamradio/scc.c:1772:scc_n=
et_ioctl: ERROR:RANGE:1762:1772: Using user length "irq"as an array index f=
or "Ivec" set by 'copy_from_user':1762 [val=3D1000]
>> 			if (!arg) return -EFAULT;
>
>Thats a real bug for other reaosns.=20

Nah, just a misconception (NB: the whole scc driver initialization is crap
anyway -- but that part was written before we even had procfs; the next=20
version will use procfs, but I'm not quite convinced that my current=20
approach for the rewrite is correct. Fact is that the driver has to support=
=20
far too many different parameters). The next version will also use
the ISR of your z85230 HDLC driver, the z8530 seems to occasionally=20
overwrite it's interrupt vector register with new status information
before the old one was read.

> the iRQ might be > 16 on APIC using hosts

They won't assign IRQs above 15 for ISA cards, will they?

I gravely hope that nobody gets the idea to design a PCI card
for the Z8530 without bus master DMA...

>or non x86

Granted. But I've no reports that anyone actually tried that,
especially as the (unmodified) driver is only useful for packet radio
purposes.

>Both fixed

How? ;-)

73,
--=20
Joerg Reuter DL1BKE                             http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air.=20
Everything is waiting quietly out there....                 (Anne Clark)


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE7JMzwXQh8bpcgulARAjlvAKCHoIvb3cV1YMR2kO79VW3n5FSiqQCdE9Ps
Qw/80bzkmpe8oYy69Q5tPhY=
=4IRu
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
