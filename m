Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTBUUDF>; Fri, 21 Feb 2003 15:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBUUDF>; Fri, 21 Feb 2003 15:03:05 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33679 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267675AbTBUUDD>; Fri, 21 Feb 2003 15:03:03 -0500
Message-Id: <200302212013.h1LKD6Cu014437@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1242778299P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Feb 2003 15:13:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1242778299P
Content-Type: text/plain; charset=us-ascii

RFC3168 section 6.1.1.1 says this:

   A host that receives no reply to an ECN-setup SYN within the normal
   SYN retransmission timeout interval MAY resend the SYN and any
   subsequent SYN retransmissions with CWR and ECE cleared.  To overcome
   normal packet loss that results in the original SYN being lost, the
   originating host may retransmit one or more ECN-setup SYN packets
   before giving up and retransmitting the SYN with the CWR and ECE bits
   cleared.

Supporting this would make using ECN a lot less painful - currently, if
I want to use ECN by default, I get to turn it off anytime I find an ECN-hostile
site that I'd like to communicate with.

Looking at the 2.5.56 version of net/ipv4/tcp_output.c, it doesn't look like
the tcp_connect() function has a good way to connect a special callback to clear
the ECN bits on a retransmit.  Similarly, net/ipv4/netfilter/* doesn't seem
to have a good way to flag a *retransmitted* SYN for packet mangling.

It would be nice, but not required, if the solution included a printk() so
I could grep the logs and find sites to send a nastygram to if they are in
fact ECN-hostile..

Any pointers/suggestions/etc?

/Valdis (who has hit 5 ECN-hostile servers already today... argh)

--==_Exmh_1242778299P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+VohRcC3lWbTT17ARAud1AKD2SGRVYY/cVOXBskUkpGiNbPws7QCfXLoh
kOtSKjC26hU8AH4uHxT2o48=
=K6t/
-----END PGP SIGNATURE-----

--==_Exmh_1242778299P--
