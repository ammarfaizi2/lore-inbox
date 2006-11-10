Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424458AbWKJWj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424458AbWKJWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424459AbWKJWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:39:59 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56498 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1424458AbWKJWj6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:39:58 -0500
Message-Id: <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-kernel@vger.kernel.org, madduck@madduck.net
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
In-Reply-To: Your message of "Fri, 10 Nov 2006 16:12:10 +0100."
             <455496CA.5040405@wpkg.org>
From: Valdis.Kletnieks@vt.edu
References: <455496CA.5040405@wpkg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163198390_4028P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 17:39:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163198390_4028P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Nov 2006 16:12:10 +0100, Tomasz Chmielewski said:

> >   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >   ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)

> I saw similar when using smartctl / smartd with wrong options (without 
> -d ata; in short, smartd tried to talk "IDE language" to SATA device...).

(Foo on me for not chasing this earlier - I've been seeing it ever since I
started using the libata stuff several months ago - Alan Cox got things fixed
so I had the ata_piix driver at UDMA/100, and I never followed up on this part)

[   21.734165] ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA
[   21.734171] ata1.00: ata1: dev 0 multi count 8
[   21.884789] ata1.01: ATAPI, max UDMA/33
[   21.889464] ata1.00: configured for UDMA/100
[   22.041527] ata1.01: configured for UDMA/33
[   22.041536] scsi1 : ata_piix 
[   22.192756] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2060A 0000 PQ: 0 ANSI:5

(ata1.01 is a CD)

when smartd starts up:
[   92.567000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   92.568000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   92.569000] ata1: soft resetting port
[   92.879000] ata1.00: configured for UDMA/100
[   93.031000] ata1.01: configured for UDMA/33
[   93.031000] ata1: EH complete
(set of 6 messages repeated 5 more times)
[   95.346000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   95.348000] sda: Write Protect is off
[   95.349000] sda: Mode Sense: 00 3a 00 00
[   95.349000] SCSI device sda: drive cache: write back
[   95.350000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   95.351000] sda: Write Protect is off
[   95.352000] sda: Mode Sense: 00 3a 00 00
[   95.353000] SCSI device sda: drive cache: write back

and then the entire set repeats again (6 sets of 6 msgs, then final 8).

And I *am* passing '-d ata' - /etc/smartd.conf contains:

/dev/sda -a -d ata -o on -S on -m root -l error -l selftest -s (S/../.././(00|06|12|18)|L/../.././03|O/../.././.[02468])

(Testing with removing '-d ata' results in smartd saying it can't talk to the
scsi device at /dev/sda).

Any ideas/suggestions?

--==_Exmh_1163198390_4028P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFVP+2cC3lWbTT17ARAjroAKC0tKXur3YCj29xVlUPvY5r2HLOJgCgxHHI
E6vG8ZZm3rGCQjJZUklTOi8=
=ycIV
-----END PGP SIGNATURE-----

--==_Exmh_1163198390_4028P--
