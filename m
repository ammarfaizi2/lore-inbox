Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTFYDN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 23:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTFYDN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 23:13:58 -0400
Received: from h80ad268f.async.vt.edu ([128.173.38.143]:26240 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263705AbTFYDN4 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 23:13:56 -0400
Message-Id: <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1 
In-Reply-To: Your message of "Tue, 24 Jun 2003 21:02:49 +0300."
             <200306242102.49356.kde@myrealbox.com> 
From: Valdis.Kletnieks@vt.edu
References: <200306242102.49356.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1055858223P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jun 2003 23:27:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1055858223P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <1564.1056511669.1@turing-police.cc.vt.edu>

On Tue, 24 Jun 2003 21:02:49 +0300, "ismail (cartman) donmez" <kde@myrealbox.com>  said:
> Hi All,
> 
> First I did not tried 2.5.73 vanilla so this can be a bug in 2.5.73 itself . 
> When I use my 56k modem to connect to internet it always hang up 5-6 minutes 
> ( sometimes like 1-2 minutes ) later. I checked with 2.5.72-mm1 and I got not
 
> hang-up whatsoever. I checked system logs and it just says :
> 
> [pppd] Modem Hang Up

2.5.72-mm3 is fine for modem usage for me.

2.5.73-mm1 threw this all 3 times I tried starting PPPD:

Jun 24 22:37:48 turing-police pppd[1144]: Using interface ppp0
Jun 24 22:37:48 turing-police pppd[1144]: Connect: ppp0 <--> /dev/ttyS14
Jun 24 22:37:49 turing-police pppd[1144]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x9ed88e38> <pcomp> <accomp>]
Jun 24 22:37:49 turing-police pppd[1144]: Modem hangup
Jun 24 22:37:49 turing-police pppd[1144]: Connection terminated.

i.e. it died a quick and horrid death.  I've not checked a plain 2.5.73 yet,
but I suspect this is the most likely culprit:

#	           ChangeSet	1.1348.1.42 -> 1.1348.1.43
#	 drivers/net/pppoe.c	1.31    -> 1.32   
#	drivers/net/ppp_generic.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/23	shemminger@osdl.org	1.1348.1.43
# [NET]: Convert PPPoE to new style protocol.
# --------------------------------------------

(if only because it's the only changeset that hits ppp_generic.c between
the known good and known bad versions).  If a clean 2.5.73 works, then
reverting this cset is probably the best place to start looking...


--==_Exmh_1055858223P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++Ra9cC3lWbTT17ARApVGAJ4+NSJuG5nEMJf9g436U8NGaa2TcQCghUOY
yO3N71e7t1as2quT4mSzYcg=
=2vmp
-----END PGP SIGNATURE-----

--==_Exmh_1055858223P--
