Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311741AbSCTQHo>; Wed, 20 Mar 2002 11:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSCTQHf>; Wed, 20 Mar 2002 11:07:35 -0500
Received: from ns01.passionet.de ([62.153.93.33]:38290 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S311735AbSCTQHV>; Wed, 20 Mar 2002 11:07:21 -0500
Date: Wed, 20 Mar 2002 17:06:54 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: "White, Charles" <Charles.White@COMPAQ.com>, Arrays <Arrays@COMPAQ.com>
Cc: linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
Subject: RE: Hooks for random device entropy generation missing in
 cpqarray.c 
Message-ID: <5013428.1016644014@eva.dhcp.gimlab.org>
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB01E88B79@cceexc18.americas.cpqcorp.net>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========05031019=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========05031019==========
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a quick and drity patch for 1 contorlller:

I patched as floows:



--- ./drivers/block/cpqarray.c.old      Wed Mar 20 14:53:16 2002
+++ drivers/block/cpqarray.c    Wed Mar 20 15:31:32 2002
@@ -1009,6 +1009,7 @@

 startio:
        start_io(h);
+       add_blkdev_randomness(MAJOR_NR);
 }

 /*


other Driver (handling more the 1 drive) find out the
Major driver number ...


./drivers/scsi/scsi_lib.c:      add_blkdev_randomness(MAJOR(req->rq_dev));
./drivers/ide/ide.c:            add_blkdev_randomness(MAJOR(rq->rq_dev));
./drivers/block/DAC960.c:         add_blkdev_randomness(DAC960_MAJOR +=20
Controller->ControllerNumber);

How would I do this for the cpqarray ?

--On Mittwoch, 20. M=E4rz 2002 8:25 Uhr -0600 "White, Charles"=20
<Charles.White@COMPAQ.com> wrote:

> Yes.. I was reported that it some how got dropped from our 2.4 version of
> the driver..  DON'T add add_interrupt_randomness, just add "|
> SA_SAMPLE_RANDOM" to the call to request_irq.
>
> Patch to follow.
>
>
> -----Original Message-----
> From: Manon Goo [mailto:manon@manon.de]
> Sent: Wednesday, March 20, 2002 7:34 AM
> To: Arrays
> Cc: linux-kernel@vger.kernel.org; tytso@MIT.EDU; Markus Schr=F6der
> Subject: Hooks for random device entropy generation missing in
> cpqarray.c
>
>
> Hi,
>
> All hooks for the random ganeration (add_blkdev_randomness() ) are
> ignored  in the cpqarray / ida  driver.
> 	Is a patch available ?
> 	or an other updated driver ?
> 	any hints where to put add_blkdev_randomness() in your driver ?
> 	
> 	is add_interrupt_randomness() called on an i386 SMP IO-APCI system ?
>
>
> Thanks
> Manon
>
> PS: Folks on linux-kernel please CC to manon@manon.de I am not on the =
list
>
>


--==========05031019==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mLOflp/TJR6NORURAhatAJ4irhCrRtTSYN8tLJrMgnoGu2QMrACeIt4W
bttSzNyc+9UXsN9FZeP7pFY=
=T+Hd
-----END PGP SIGNATURE-----

--==========05031019==========--

