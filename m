Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUBIBtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbUBIBtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:49:17 -0500
Received: from puffbird.pelicanmanufacturing.com.au ([203.59.220.18]:49295
	"EHLO pelicanmanufacturing.com.au") by vger.kernel.org with ESMTP
	id S264547AbUBIBtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:49:09 -0500
Date: Mon, 9 Feb 2004 09:10:40 +0800
From: James Bromberger <james@rcpt.to>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 && md raid1 && reiserfs panic
Message-ID: <20040209011040.GB27378@phobe.internal.pelicanmanufacturing.com.au>
References: <20040207112302.GA2401@phobe.internal.pelicanmanufacturing.com.au> <200402081722.i18HMBFT074505@car.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <200402081722.i18HMBFT074505@car.linuxhacker.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oleg Drokin (green@linuxhacker.ru) wrote:
> James Bromberger <james@rcpt.to> wrote:
>=20
> JB> The symptoms: rm a file from a working RAID1 md reiserfs filesystem,=
=20
> JB> and I get a panic, rm(1) segfaults, and all further I/O to any intera=
ctive=20
> JB> shells stop. The entire system is rednered incapable; reboot (via=20
> JB> ctrl-alt-del) doesnt shutdown and the only action is to hard reset th=
e box.
>=20
> What if you run reiserfsck over the volume that seems to be corrupted,
> then fix the errors and then retry the operation?

Yes! That was it. Attached is the output I captured from reiserfsck.=20
It identified the very file I was attempting to remove that was causing
the segfault in rm(1).

So I guess this is a reiserfs specific issue when it kills all disk I/O
when this correcption happens. Hmm.

Thanks Oleg for your help.

  James
--=20
 James Bromberger <james_AT_rcpt.to> www.james.rcpt.to
 Remainder moved to http://www.james.rcpt.to/james/sig.html

I am in London on UK mobile +44 7952 042920.

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error-reiserfsck.txt"

bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (904) to the block (616563974)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (905) to the block (2538674917)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (906) to the block (1226131222)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (907) to the block (2721249827)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (908) to the block (15941101)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (909) to the block (74275561)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (910) to the block (3897627755)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (911) to the block (2212879009)
bad_indirect_item: block 1449156: The item [9 24 0x1458e2001 IND (1)] has the bad pointer (912) to the block (1076949926)             /167 (of 167)/126 (of 127)bad_indirect_item: block 1361383: The item (76625 76647 0xfa001 IND (1), len 4048, location 48 entry count 0, fsck need 0, format new) has the bad pointer (995) to the block (6306403), which is in tree already     finished
Comparing bitmaps..vpf-10640: The on-disk and the correct bitmaps differs.
/share/2004-01-30-fileshare-backup.tbzvpf-10670: The file [9 24] has the wrong size in the StatData (2295013376), should be (5466054656)
vpf-10680: The file [9 24] has the wrong block count in the StatData (0), should be (10675888)                            finished 16 found corruptions can be fixed when running with --fix-fixable


Comparing bitmaps..vpf-10630: The on-disk and the correct bitmaps differs. Will be fixed later.
Checking Semantic tree:
/fileshare/Documents/pics/standup block pics/standing for block.tifvpf-10680: The file [76625 76647] has the wrong block count in the StatData (12192) - correct/share/2004-01-30-fileshare-backup.tbzvpf-10670: The file [9 24] has the wrong size in the StatData (2295013376) - corrected to (5466054656)
vpf-10680: The file [9 24] has the wrong block count in the StatData (0) - corrected to (10675800)                        finished No corruptions found
There are on the filesystem:
        Leaves 24533
        Internal nodes 168
        Directories 2483
        Other files 62601
        Data block pointers 8767338 (143 of them are zero)
        Safe links 0
###########
reiserfsck finished at Mon Feb  9 08:55:00 2004
###########


--82I3+IH0IqGh5yIs--

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJt4QpfJwKAkXqeQRArPxAJ95PIp++Y8dEskOEr2Jo5vF6MpPzgCdGlTv
nnscO+ds1/rfJ+wgGLPi+7Q=
=3PBN
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
