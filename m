Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270829AbTGVOJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTGVOJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:09:33 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:32402 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S270829AbTGVOJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:09:29 -0400
Date: Tue, 22 Jul 2003 16:24:31 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
Message-Id: <20030722162431.083c4ad1.us15@os.inf.tu-dresden.de>
In-Reply-To: <1058878505.2232.122.camel@mtross2.csintern.de>
References: <0001F474@gwia.compu-shack.com>
	<1058878505.2232.122.camel@mtross2.csintern.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.4/X7sH(bE5CGF0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.4/X7sH(bE5CGF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22 Jul 2003 14:55:05 +0200 Michael Tro=DF (MT) wrote:

MT> As you might know, the Compu-Shack fddi products reached end-of-life
MT> last year.

Yes. Just thought I'd let you know that we aren't using the same
patch as on the website, but one that has been rediffed for 2.4.21 and
has an additional fix from you in it.

MT> As I can't locate the code sequence in my driver module, please check it
MT> with your compiled kernel:
MT>   objdump -d vmlinux | grep -A 20 "7e f5" | grep csfddi

c01f8334:       7e f5                   jle    c01f832b <.text.lock.csfddi>
c01f8336:       e9 87 d1 ff ff          jmp    c01f54c2 <csfddi_transmit+0x=
22>
c01f8344:       7e f5                   jle    c01f833b <.text.lock.csfddi+=
0x10>
c01f8346:       e9 b2 d2 ff ff          jmp    c01f55fd <csfddi_transmit_ti=
meout+0x1d>
c01f8354:       7e f5                   jle    c01f834b <.text.lock.csfddi+=
0x20>
c01f8356:       e9 02 d7 ff ff          jmp    c01f5a5d <csfddi_interrupt+0=
xd>
c01f8364:       7e f5                   jle    c01f835b <.text.lock.csfddi+=
0x30>
c01f8366:       e9 e8 d9 ff ff          jmp    c01f5d53 <csfddi_timer_work+=
0x33>
c01f8374:       7e f5                   jle    c01f836b <.text.lock.csfddi+=
0x40>
c01f8376:       e9 db da ff ff          jmp    c01f5e56 <csfddi_timer+0x56>

MT> Do you get a result like the code line from your oops, which eip is
MT> referring to?

It's referring to EIP c01f8364. Here is the disassembly of the code fragmen=
t.

c01f832b <.text.lock.csfddi>:
c01f832b:       80 bb 94 00 00 00 00    cmpb   $0x0,0x94(%ebx)
c01f8332:       f3 90                   repz nop=20
c01f8334:       7e f5                   jle    c01f832b <.text.lock.csfddi>
c01f8336:       e9 87 d1 ff ff          jmp    c01f54c2 <csfddi_transmit+0x=
22>
c01f833b:       80 be 94 00 00 00 00    cmpb   $0x0,0x94(%esi)             =
 =20
c01f8342:       f3 90                   repz nop=20
c01f8344:       7e f5                   jle    c01f833b <.text.lock.csfddi+=
0x10>
c01f8346:       e9 b2 d2 ff ff          jmp    c01f55fd <csfddi_transmit_ti=
meout+0x1d>
c01f834b:       80 be 94 00 00 00 00    cmpb   $0x0,0x94(%esi)
c01f8352:       f3 90                   repz nop=20
c01f8354:       7e f5                   jle    c01f834b <.text.lock.csfddi+=
0x20>
c01f8356:       e9 02 d7 ff ff          jmp    c01f5a5d <csfddi_interrupt+0=
xd>
c01f835b:       80 be 94 00 00 00 00    cmpb   $0x0,0x94(%esi)=20
c01f8362:       f3 90                   repz nop=20
c01f8364:       7e f5                   jle    c01f835b <.text.lock.csfddi+=
0x30>
c01f8366:       e9 e8 d9 ff ff          jmp    c01f5d53 <csfddi_timer_work+=
0x33>
c01f836b:       80 3d 40 be 2e c0 00    cmpb   $0x0,0xc02ebe40
c01f8372:       f3 90                   repz nop
c01f8374:       7e f5                   jle    c01f836b <.text.lock.csfddi+=
0x40>
c01f8376:       e9 db da ff ff          jmp    c01f5e56 <csfddi_timer+0x56>
c01f837b:       90                      nop
c01f837c:       90                      nop   =20
c01f837d:       90                      nop   =20
c01f837e:       90                      nop   =20
c01f837f:       90                      nop   =20

I've also put up the vmlinux image at the URL I've posted in my previous
post, if it's of any help.

MT> But you got two different decoding results, didn't you ?!

The first posting which was only sent to LKML and not to you had the
lockup output misdecoded, because I used a wrong System.map.
The second posting (the one I cc'd to you) and the decoded lockup output
(lockup.txt) on the website are the correct ones.

Regards,
-Udo.

--=.4/X7sH(bE5CGF0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/HUkfnhRzXSM7nSkRAmrTAJ9tfBidviRaA3+Kbsv3YfGu1SQMcQCbBl+D
nCiTysFqH3MDqYMybhi6HOU=
=+gvi
-----END PGP SIGNATURE-----

--=.4/X7sH(bE5CGF0--
