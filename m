Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVBDJfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVBDJfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVBDJch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:32:37 -0500
Received: from port49.ds1-van.adsl.cybercity.dk ([212.242.141.114]:56373 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262930AbVBDJcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:32:19 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: parse noexec=[on|off]
Message-Id: <20050204093214.9DBB81EBF6@trider-g7.fabbione.net>
Date: Fri,  4 Feb 2005 10:32:14 +0100 (CET)
From: fabbione@fabbione.net (Fabio Massimo Di Nitto)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
  the patch fixes the noexec= boot option on x86_64 to actually work when other
options come after it.

Credits (if any ;)) should go to Matt Zimmerman and Colin Watson for spotting
the problem and providing/testing the fix.

Best Regards,
Fabio

diff -urNad linux-source-2.6.10-2.6.10/arch/x86_64/kernel/setup64.c /usr/src/dpatchtemp/dpep.fC5FuB/linux-source-2.6.10-2.6.10/arch/x86_64/kernel/setup64.c
- --- linux-source-2.6.10-2.6.10/arch/x86_64/kernel/setup64.c	2005-02-04 09:16:07.000000000 +0100
+++ /usr/src/dpatchtemp/dpep.fC5FuB/linux-source-2.6.10-2.6.10/arch/x86_64/kernel/setup64.c	2005-02-04 09:17:29.832897272 +0100
@@ -52,10 +52,10 @@
 */ 
 void __init nonx_setup(const char *str)
 {
- -	if (!strcmp(str, "on")) {
+	if (!strncmp(str, "on", 2)) {
                 __supported_pte_mask |= _PAGE_NX; 
  		do_not_nx = 0; 
- -	} else if (!strcmp(str, "off")) {
+	} else if (!strncmp(str, "off", 3)) {
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         } 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCA0CVhCzbekR3nhgRAhwqAKCZTa/CefbSGX/1SsCzr3CJBf61gQCdGqac
lAVVeWjAxi+KZFiiu1Ukqkw=
=ARdl
-----END PGP SIGNATURE-----
