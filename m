Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTFYQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTFYQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:40:37 -0400
Received: from h80ad2736.async.vt.edu ([128.173.39.54]:57998 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264650AbTFYQkg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:40:36 -0400
Message-Id: <200306251654.h5PGsUdA022467@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephen Hemminger <shemminger@osdl.org>
Cc: kde@myrealbox.com, linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1 
In-Reply-To: Your message of "Wed, 25 Jun 2003 09:10:13 PDT."
             <20030625091013.573f2e7b.shemminger@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200306242102.49356.kde@myrealbox.com> <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu> <200306250418.h5P4IWdA001565@turing-police.cc.vt.edu>
            <20030625091013.573f2e7b.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1017959470P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jun 2003 12:54:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1017959470P
Content-Type: text/plain; charset=us-ascii

On Wed, 25 Jun 2003 09:10:13 PDT, Stephen Hemminger said:

> How far along did pppd get before it hung up?  Was the ppp0 netdevice still
> around (ifconfig -a)?  I'll try a dedicated serial line and see if I can reproduce

For me, it didn't even finish negotiating the connection:

Jun 24 22:37:48 turing-police pppd[1144]: Using interface ppp0
Jun 24 22:37:48 turing-police pppd[1144]: Connect: ppp0 <--> /dev/ttyS14
Jun 24 22:37:49 turing-police pppd[1144]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x9ed88e38> <pcomp> <accomp>]
Jun 24 22:37:49 turing-police pppd[1144]: Modem hangup
Jun 24 22:37:49 turing-police pppd[1144]: Connection terminated.

I'm assuming the netdevice was there when it said 'Using interface'.  It was
certainly gone by the time I was able to do ifconfig or 'ip link show' or
anything like that.  ismail reports "several  minutes" - I'm wondering it the
bug is in pskb_may_pull()  being handed an oodd packet-of-death that I receive
during startup but ismail gets later on.  There's comments in the patch about
making sure the decompressor is linear, but in my case the LCP stuff isn't even
negotiating compression.  Uninitialized variable?


--==_Exmh_-1017959470P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++dPFcC3lWbTT17ARAsaZAKDVMfKhgmGnUmC/45XT41KacxmQQQCeMUpQ
ldffRTrVNPN1meSaeg+QWLQ=
=1E9e
-----END PGP SIGNATURE-----

--==_Exmh_-1017959470P--
