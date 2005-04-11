Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVDKIep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVDKIep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDKIeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:34:13 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:9889 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261730AbVDKI2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:28:12 -0400
Date: Mon, 11 Apr 2005 03:28:06 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: question about execve()
Message-Id: <20050411032806.276493ce.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <425A1F32.4020809@haha.com>
References: <425A1F32.4020809@haha.com>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.4; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__11_Apr_2005_03_28_06_-0500_y67nYa8BGqaDTZ/R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__11_Apr_2005_03_28_06_-0500_y67nYa8BGqaDTZ/R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Tomko <tomko@haha.com>, spake thus:

> I would like to ask when a userprogram called in user space called=20
> execve("/bin/abc"....   will  this system call finally copy the code of=20
> /bin/abc into kernel space before kernel runs it or just leave the code=20
> in the userspace and run directly ?=20

None of these.  All "execve" really does is to discard the current VM
setup, tell the VM system to attach this process to the new
executable image, and then transfer control to the starting
instruction of the program.  Since nothing is really in memory, aside
from maybe some caching/readahead, page faults do all the work of
loading application code, page by page, on demand.

HTH

--Signature=_Mon__11_Apr_2005_03_28_06_-0500_y67nYa8BGqaDTZ/R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCWjUa/0ydqkQDlQERAvYsAJ9p9WwtOYxz8X46PhvOll6ON4SW/ACgium6
eo+KX7w4e4wu/EbiAZvF774=
=Zwlp
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Apr_2005_03_28_06_-0500_y67nYa8BGqaDTZ/R--
