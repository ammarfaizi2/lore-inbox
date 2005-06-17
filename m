Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVFQNxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVFQNxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVFQNxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:53:12 -0400
Received: from h80ad262c.async.vt.edu ([128.173.38.44]:6159 "EHLO
	h80ad262c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261974AbVFQNxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:53:08 -0400
Message-Id: <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: abonilla@linuxwireless.org
Cc: "'Lars Roland'" <lroland@gmail.com>, "'Christian Kujau'" <evil@g-house.de>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup 
In-Reply-To: Your message of "Fri, 17 Jun 2005 07:33:05 MDT."
             <001f01c57341$1802c3b0$600cc60a@amer.sykes.com> 
From: Valdis.Kletnieks@vt.edu
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119016370_11929P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 09:52:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119016370_11929P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Jun 2005 07:33:05 MDT, Alejandro Bonilla said:

> 	So what do we really have here? Problem with Cisco or a problem in the
> driver? Both?

The Cisco PIX is gratuitously clearing the TCP window scaling bits.  So if you
have tcp_adv_win_scale set to (for example) 6, you'll send a window advertisement
of (say) 4096, represented as 64 and a "shift left 6 bits".  The PIX whacks the
"6 bits" part, and the other end thinks the window is 64 bytes and wedges when
a response is over 64 bytes long.

There was quite a discussion of this on lkml back last July.

--==_Exmh_1119016370_11929P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCstWycC3lWbTT17ARAua3AKDjJg5H50mT3NGxU1U6re2N0T9OKQCgrtmM
OW5gIHPYHHNxQwDyXnFz0p8=
=+Fgx
-----END PGP SIGNATURE-----

--==_Exmh_1119016370_11929P--
