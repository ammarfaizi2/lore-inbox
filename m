Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWDRDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWDRDQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 23:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDRDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 23:16:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39049 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751396AbWDRDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 23:16:33 -0400
Message-Id: <200604180316.k3I3GIvQ018967@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Danny.Weldon@treasury.qld.gov.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: No kernel message when filesystem full 
In-Reply-To: Your message of "Tue, 18 Apr 2006 12:26:37 +1000."
             <OFC430CAEE.2A513C3F-ON4A257154.000C8284-4A257154.000D5E15@treasury.qld.gov.au> 
From: Valdis.Kletnieks@vt.edu
References: <OFC430CAEE.2A513C3F-ON4A257154.000C8284-4A257154.000D5E15@treasury.qld.gov.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145330178_2737P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 23:16:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145330178_2737P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Apr 2006 12:26:37 +1000, Danny.Weldon@treasury.qld.gov.au said:
> I am not getting any kernel messages when a filesystem fills up.  Is this
> facility still available or is it now configurable?

> # dd if=/dev/zero of=/opt/xx
> dd: writing to `/opt/xx': No space left on device

The kernel hands the program a ENOSPC back.  The program decides what to do.
Emitting a kernel message as well just means that instead of /home being full,
in a few minutes /home *and* /var will be full... ;)

If you have an actual concern about a full file system, the *RIGHT* thing to do
is to run a userspace program that does a statfs() every once in a while and
issues a warning when the partition is at 97% or so - so that you can act
*before* it gets full.  This is a case where proactive can actually *do*
something, but being reactive really can't.

Yes, the kernel does issue printk()s for other things like I/O errors.  But you
can *see* a "disk full" coming, whereas you can't (usually) predict an I/O
error (except for at the end of a CDROM with a buggy ide-cd.c ;)


--==_Exmh_1145330178_2737P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERFoCcC3lWbTT17ARAnHaAJ0Sr1CqsZfUpSkXn5LzXFrLzNHhWACgrO29
lu0wgCXWIDmUCZInxPSkym0=
=5bYF
-----END PGP SIGNATURE-----

--==_Exmh_1145330178_2737P--
