Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272619AbTHKHjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHKHjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:39:42 -0400
Received: from coruscant.franken.de ([193.174.159.226]:63121 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272619AbTHKHji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:39:38 -0400
Date: Mon, 11 Aug 2003 09:34:43 +0200
From: Harald Welte <laforge@gnumonks.org>
To: sal@agora.pl
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.18/2.4.20 filemap.c pmd bug (was Re: Problem with mm in 2.4.19 and 2.4.20)
Message-ID: <20030811073443.GA8953@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20030208121633.GB17017@virgin.gazeta.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Przemys?aw Maciuszko wrote:

>I have a problem with one news server (feeder) box running INN.
>Under heavy load i get the following error on the console:
>
>filemap.c:2084: bad pmd 2bc001e3
>
>This showed few times during last few days and few times server 'hanged up'
>after this.

I can confirm this problem.  It happens on one of my newsservers as well,
currently at least once per day.  It is a dual PIII 650MHz, 1GB RAM,
200GB spool (scsi hardware raid array attached to adaptec aic7xxx), six
seperate SCSI disks attached to a seperate aic7xxx controller for
overview, running inn-2.3.2.

We've tried  RedHat kernels 2.4.18-3, 2.4.18-17.7, 2.4.20-19.7 and=20
2.4.20-19.7bigmem as well as a kernel.org 2.4.20 - all with the same=20
problem.

After the filemap.c / pmd_ERROR() printk, the box either hangs (no=20
further printout, not that often) or has a stack overflow (most of the=20
time):

filemap.c:2258: bad pmd c0003000(00000000000001e3).
do_IRQ: stack overflow: -864
c0252845 fffffca0 206d6564 c2426000 00000000 c0117b20 c0101018 c024bd2c
c2426000 00000018 00000018 00000000 c0117b20 c0101018 c2426470 6f6e0018
40320018 ffffff00 c0117b43 00000010 00000202 7369636e 3e65642e 613c200a
Call Trace:   [<c0117b20>] do_page_fault [kernel] 0x0 (0xc242634c))
[<c0117b20>] do_page_fault [kernel] 0x0 (0xc2426368))
[<c0117b43>] do_page_fault [kernel] 0x23 (0xc2426380))
[<c0117b20>] do_page_fault [kernel] 0x0 (0xc242645c))
[<c0108cc4>] error_code [kernel] 0x34 (0xc2426464))
[<c0117fc5>] do_page_fault [kernel] 0x4a5 (0xc2426498))
[<c0117b20>] do_page_fault [kernel] 0x0 (0xc2426574))
[<c0108cc4>] error_code [kernel] 0x34 (0xc242657c))
[<c0117fc5>] do_page_fault [kernel] 0x4a5 (0xc24265b0))
[<c0117b20>] do_page_fault [kernel] 0x0 (0xc242668c))
[<c0108cc4>] error_code [kernel] 0x34 (0xc2426694))
[<c0117fc5>] do_page_fault [kernel] 0x4a5 (0xc24266c8))
[<c0117b20>] do_page_fault [kernel] 0x0 (0xc24267a4))
[<c0108cc4>] error_code [kernel] 0x34 (0xc24267ac))

The messages are always preceded by a '(scsi0:A:0:0): Locking max tag=20
count at 64' message. The scsi device number is changing, so it cannot=20
be a single device

>Anyone has an idea what can cause it?

Unfortunately I'm not very familiar with the linux MM subsystem.  But=20
since I consider this now as a confirmed bug, maybe some of the other=20
lkml folks have an idea what might be going on.

>I'm using Linux Debian on dual PIII 1.1Ghz, 1GB RAM, LVM version 1.0.6
>Qlogic FC 2200F driver version 6.01

We don't use lvm, so the similarities seem to be:  Dual PIII,=20
SCSI, INN

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/N0cTXaXGVTD0i/8RAnf4AJ92AeB1ShWiRMODpeCOp+KotiZ3tQCdGv84
dq5naxemgbWR6tBVxfkjRC0=
=RnJH
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
