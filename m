Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTH0UBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbTH0UBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:01:07 -0400
Received: from h80ad25e9.async.vt.edu ([128.173.37.233]:24963 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262128AbTH0UBD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:01:03 -0400
Message-Id: <200308272000.h7RK0tln019656@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sum <ellenyip@netvigator.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: install problem with kernel 2.6.0 
In-Reply-To: Your message of "Thu, 28 Aug 2003 03:41:23 +0800."
             <20030827194123.LBVT10998.imsm083dat.netvigator.com@imailmta.netvigator.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030827194123.LBVT10998.imsm083dat.netvigator.com@imailmta.netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1216800962P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Aug 2003 16:00:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1216800962P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Aug 2003 03:41:23 +0800, Sum <ellenyip@netvigator.com>  said:
> Hi there. I just compile the kernel 2.6.0 version. However, there is not any 
/lib/modules/2.6.0-test4/modules.dep created. When I type "depmod -a", there is
 an error message said "depmod: QM_MODULES: Function not implemented". 

Sum:  You need a new version of module-init-tools.

See http://ww.codemonkey.org.uk/post-halloween-2.5.txt for all the OTHER info
you will probably be needing.

All:  We can put an end to this:

--- Makefile	2003-08-27 01:52:20.000000000 -0400
+++ Makefile.fixed	2003-08-27 15:59:56.768341551 -0400
@@ -594,6 +594,11 @@
 
 .PHONY: _modinst_
 _modinst_:
+	@if [ -z "`depmod -V | grep module-init-tools`" ]; then \
+		echo "Install a current version of module-init-tools"; \
+		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt"; \
+		exit 1; \
+	 fi
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)/kernel



--==_Exmh_1216800962P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/TQ32cC3lWbTT17ARAs26AKD7dS/IiuRZSGWrYT8LLWA2jZDPkgCgucap
94WfmAPIZWA4hO+4IKi27cM=
=6zKt
-----END PGP SIGNATURE-----

--==_Exmh_1216800962P--
