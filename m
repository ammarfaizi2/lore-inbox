Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbUL0Upp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUL0Upp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUL0Upp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:45:45 -0500
Received: from h80ad26af.async.vt.edu ([128.173.38.175]:1510 "EHLO
	h80ad26af.async.vt.edu") by vger.kernel.org with ESMTP
	id S261984AbUL0Upf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:45:35 -0500
Message-Id: <200412272045.iBRKjPFb030253@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pid randomness 
In-Reply-To: Your message of "Mon, 27 Dec 2004 19:39:01 GMT."
             <41D064D5.1030900@rnl.ist.utl.pt> 
From: Valdis.Kletnieks@vt.edu
References: <41D064D5.1030900@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1767933060P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Dec 2004 15:45:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1767933060P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Dec 2004 19:39:01 GMT, =22Pedro Venda (SYSADM)=22 said:

> I don't know if this has been discussed before... but I'd like to ask=20
> why isn't the pids randomized by default?

It's a pretty easy thing to do, actually.  There's a patch for that
in Grsecurity, and I did one up myself a while ago...

One big problem that remains beyond my technical skill to fix - for the
32 bit machines, there's some funkiness in the /proc filesystem code
where it invents inode numbers based in the process ID that restrict the
effective value of max_pid to 64K.  Unfortunately, if you're in the camp =
that
believes that randomizing the PID is useful at *all*, you probably want a=

bigger space for the random number.  So you can either fix that issue (an=
d
whatever *OTHER* issues lurk after that one) or only deploy on 64 bit box=
en...

A secondary issue that I've never been able to test is whether over time,=

a =22randomized=22 PID ends up sparsely dirtying the list of pidmap pages=
 (so
you have enough pages to hold 4M PID bits, but only 1 or 2 bits per page
are actually set), or do the occasional long-lived processes end up essen=
tially
leaving at least one process on each page anyhow?  Any operational experi=
ence
on that one from the big-system guys?

At worst, 4M pids will take 128 4K pages (or equivalent for other page si=
zes) -
is that considered =22unacceptable=22 on 64-bit boxes that want to do thi=
s?


--==_Exmh_-1767933060P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0HRkcC3lWbTT17ARArmBAKCRJlyWRdd/ToBfPNZssj0BeJechwCaA8RT
fy2KvtSWcN02+1wvpTj8uns=
=VzbT
-----END PGP SIGNATURE-----

--==_Exmh_-1767933060P--
