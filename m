Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTDBU0p>; Wed, 2 Apr 2003 15:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbTDBU0p>; Wed, 2 Apr 2003 15:26:45 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:1945 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262428AbTDBU0k>; Wed, 2 Apr 2003 15:26:40 -0500
Message-ID: <3E8B4A1F.2060903@redhat.com>
Date: Wed, 02 Apr 2003 12:37:51 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Signal invalid ipc operation with ENOSYS
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46D57CABB89B8FB617B97E7F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46D57CABB89B8FB617B97E7F
Content-Type: multipart/mixed;
 boundary="------------040900040503080504070607"

This is a multi-part message in MIME format.
--------------040900040503080504070607
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The ipc multiplexer syscall on x86 currently returns EINVAL for a
non-existing sub-opcode.  This logical but is a problem with the
introduction of new operations (like semtimedop).  Now EINVAL can mean
"no such operation" and "invalid parameter".  To avoid such problems in
future, could you apply the attached patch?

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------040900040503080504070607
Content-Type: text/plain;
 name="d-semtimedop"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-semtimedop"

--- arch/i386/kernel/sys_i386.c	2003-04-02 12:30:51.000000000 -0800
+++ arch/i386/kernel/sys_i386.c.ud	2003-04-02 12:31:12.000000000 -0800
@@ -204,7 +204,7 @@
 		return sys_shmctl (first, second,
 				   (struct shmid_ds *) ptr);
 	default:
-		return -EINVAL;
+		return -ENOSYS;
 	}
 }
 

--------------040900040503080504070607--

--------------enig46D57CABB89B8FB617B97E7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+i0of2ijCOnn/RHQRAnACAJ0U7YNtOTJTKdP/7I8lGO24FxjRzgCgk4L+
UeGOGfZf5k7gDdCxy9CO/oo=
=9/Va
-----END PGP SIGNATURE-----

--------------enig46D57CABB89B8FB617B97E7F--

