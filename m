Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUADXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUADXf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:35:56 -0500
Received: from h80ad253c.async.vt.edu ([128.173.37.60]:28592 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265772AbUADXfy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:35:54 -0500
Message-Id: <200401042335.i04NZqQZ029910@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word 
In-Reply-To: Your message of "Sun, 04 Jan 2004 23:01:04 +0100."
             <20040104230104.A11439@pclin040.win.tue.nl> 
From: Valdis.Kletnieks@vt.edu
References: <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
            <20040104230104.A11439@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1595874886P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jan 2004 18:35:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1595874886P
Content-Type: text/plain; charset=us-ascii

On Sun, 04 Jan 2004 23:01:04 +0100, Andries Brouwer said:

> A common Unix idiom is testing for the identity
> of two files by comparing st_ino and st_dev.
> A broken idiom?

Comparing two of these obtained at the same time is *usually* a good
test, although racy even on current systems. (Consider the case of an
unlink()/creat() pair between the two stat() calls - there's been more than
one race condition resulting in a security hole based on THIS one).  It's
only safe if you actually have an open reference to both files before you
fstat() either one.  And yes, it has to be fstat(), as you can't guarantee
that the file referenced by path in stat() is the one you did an open() on.

Comparing the st_ino/st_dev for a file to day with one from last Friday has
NEVER been a good idea.

--==_Exmh_1595874886P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+KNXcC3lWbTT17ARAozSAKCxyrb+K/GGnyBRiU5l/1DMyv+c/wCfT97v
xiJCMXk29ahksngILoAGQxk=
=WiTR
-----END PGP SIGNATURE-----

--==_Exmh_1595874886P--
