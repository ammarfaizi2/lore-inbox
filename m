Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbULCOJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbULCOJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULCOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:09:48 -0500
Received: from procert.cert.dfn.de ([193.174.13.1]:30927 "EHLO
	procert.cert.dfn.de") by vger.kernel.org with ESMTP id S262215AbULCOJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:09:43 -0500
Date: Fri, 3 Dec 2004 15:07:39 +0100
From: Friedrich Delgado Friedrichs <delgado@dfn-cert.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       delgado@dfn-cert.de
Subject: Re: Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell Optiplex SX280
Message-ID: <20041203140739.GB13010@kermit.dfn-cert.de>
References: <20041130160717.GA13106@kermit.dfn-cert.de> <1101839437.25617.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <1101839437.25617.87.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Organization: DFN-CERT Services GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!


Alan Cox schrieb:
> Are you running some kind of sniffer tool on these machines. That
> message itself is the last sniffer type application exiting. If you are
> running such a tool then it tells you that the shutdown got that far
> into the shutdown scripts which may help the search.

Yes, it's arpwatch.

In fact there are 5 init scripts which could trigger the bug. One of
them (powersaved) runs fuser directly. I've traced the other shutdown
scripts via "sh -x -v" and none of them appears to call fuser.

The line from /etc/init.d/powersaved is

for X in $(fuser /proc/acpi/event);do

> something newer might help. 10rc2 has a fairly number of the problems
> fixed and  a few new ones (eg it won't boot on some boxes) but might be
> useful to at least see if you are chaasing a fixed bug

This, together with your comment about USB + SCSI bug fixes below
sounds as if we really want to use 2.6.10rc2 (if it boots), because
having a machine crash during normal work is a lot worse than on
shutdown.

> > nnpfs 213484 1 - Live 0xe02ad000
> > subfs 12288 1 - Live 0xe01c4000
>
> This is ARLA stuff ?

nnpfs is the kernel-side portion of the AFS Client, subfs is from the
submount package (km_submount) from SuSE 9.1. It allows users to
insert cds and change to /media/cdrecorder to access them and also
allows the user to eject the cd as soon as there's no process in
/media/cdrecorder any more. See http://submount.sourceforge.net/

Thanks for your help!

I already mentioned to Andrew Morton that right now it seems prudent
to continue with 2.6.10rc2 (to get rid of the USB and scsi problems)
and try to convince __d_path to give a conclusive hint about the
culprit.

Kind regards
     FDF
--
Friedrich Delgado Friedrichs (IT-Services), DFN-CERT Services GmbH
https://www.dfn-cert.de, +49 40 808077-555 (Hotline)
12. DFN-CERT Workshop und Tutorien, CCH Hamburg, 2-3. Maerz 2005

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQbBzKvqefzmUpgR/AQGIowf/e5kbCnnihKaaQvoa1Ay9xf+5iNR9yXz2
M96kTzlZ7jRyicx7iBCQMdvkCFMEUGoFSfZ70HEzkyR+sLYwRc+5MAyC5uT1OXmq
I423vvfh17bHymHUj1vorne6cP8JOGiBaUDgRpoXbauYyk22vQVgmGN7xGby6M1m
8nkkC2G5VSmMm11tU6gGrrHlGuuToDWtzz0Awgx3Eh06cVBZJeAIrPF3FiKyRHtm
+KKmqIpqsQRIwHHOByz+jShGGy8lgDQzejwmYLYemfysJYLyWmZMUREgMYI0a1pp
SdKo0Lsh0dsTkDFhAaptaEcQBYsmoRZjvCItzwwyx/t90B25+uP/JQ==
=02n3
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
