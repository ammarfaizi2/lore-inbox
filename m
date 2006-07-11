Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWGKMp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWGKMp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWGKMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:45:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:38059 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751258AbWGKMpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:45:12 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Tue, 11 Jul 2006 22:45:07 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607082131.47832.ncunningham@linuxmail.org> <200607082052.02557.rjw@sisk.pl>
In-Reply-To: <200607082052.02557.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6406672.ZOg1H7I0sH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607112245.11462.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6406672.ZOg1H7I0sH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 04:52, Rafael J. Wysocki wrote:
> Well, I tried really hard to justify the patch that allowed swsusp to
> create bigger images and 10% was the greatest speedup I could get out of =
it
> and, let me repeat, _with_ compression and async I/O.  I tried to simulate
> different workloads etc., but I couldn't get more than 10% speedup (the
> biggest image I got was as big as 80% of RAM) - counting the time from
> issuing the suspend command to getting back _responsive_ system after
> resume.

Was that 10% speedup on suspend or resume, or both? With LZF, I see=20
approximately double the speed with both reading and writing:

nigel@nigel:/usr/src$ sudo cat /sys/power/suspend2/debug_info
Suspend2 debugging info:
=2D SUSPEND core   : 2.2.7.2
=2D Kernel Version : 2.6.18-rc1
=2D Compiler vers. : 4.0
=2D Attempt number : 4
=2D Parameters     : 0 25 0 0 0 0
=2D Overall expected compression percentage: 0.
=2D Compressor is 'lzf'.
  Compressed 733736960 bytes into 349517344 (52 percent compression).
=2D Swapwriter active.
  Swap available for image: 244981 pages.
=2D Filewriter inactive.
=2D I/O speed: Write 79 MB/s, Read 77 MB/s.
=2D Extra pages    : -53 used/4000.

Without compression:

nigel@nigel:/usr/src$ sudo cat /sys/power/suspend2/debug_info
Suspend2 debugging info:
=2D SUSPEND core   : 2.2.7.2
=2D Kernel Version : 2.6.18-rc1
=2D Compiler vers. : 4.0
=2D Attempt number : 5
=2D Parameters     : 0 25 0 0 0 0
=2D Overall expected compression percentage: 0.
=2D Swapwriter active.
  Swap available for image: 244981 pages.
=2D Filewriter inactive.
=2D I/O speed: Write 39 MB/s, Read 38 MB/s.
=2D Extra pages    : -72 used/4000.

On resume, how are managing to keep the speed up? I implemented readahead o=
f=20
up to 2000 pages, only waiting on a page if we actually manage to submit th=
e=20
next 2000 pages for I/O and the page we're waiting on isn't yet complete. I=
f=20
you do something like that, how do you know when I/O is complete on the pag=
e=20
you want?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart6406672.ZOg1H7I0sH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEs51XN0y+n1M3mo0RAu3NAJ9CHbhby80GPXbeQVWPqMSmqjpKJACfUkIy
J90Inrr5QXfa/d9O92u7N+Y=
=ZI57
-----END PGP SIGNATURE-----

--nextPart6406672.ZOg1H7I0sH--
