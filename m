Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWG1PyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWG1PyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWG1PyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:54:09 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54690 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752018AbWG1PyI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:54:08 -0400
Message-Id: <200607281553.k6SFrpqr022504@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.18-rc2-mm1 i386 add_memory_region undefined
In-Reply-To: Your message of "Thu, 27 Jul 2006 01:56:39 PDT."
             <20060727015639.9c89db57.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060727015639.9c89db57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154102031_3484P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 11:53:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154102031_3484P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jul 2006 01:56:39 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/

Building with -Werror-implicit-function-declaration fails:

  CC      arch/i386/pci/mmconfig.o
arch/i386/pci/mmconfig.c: In function 'pci_mmcfg_force':
arch/i386/pci/mmconfig.c:232: error: implicit declaration of function 'add_memory_region'

Problem is a missing #include, patch attached.  Problem was introduced by
add-force-of-use-mmconfig.patch. This is a bug even without the -Werror, as the
implicit declaration doesn't match the real one.

Patch attached.

Signed-Off-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- linux-2.6.18-rc2-mm1/arch/i386/pci/mmconfig.c.broken	2006-07-28 10:21:59.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/i386/pci/mmconfig.c	2006-07-28 11:45:30.000000000 -0400
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <asm/e820.h>
+#include <asm/setup.h>
 #include "pci.h"
 
 /* aperture is up to 256MB but BIOS may reserve less */





--==_Exmh_1154102031_3484P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyjMPcC3lWbTT17ARAmaNAKD7vlqg0BvfRqDqYjlmaF4FiQQg9QCglFjl
dITYL7NUv0wO2yxTauoWhC0=
=+nwb
-----END PGP SIGNATURE-----

--==_Exmh_1154102031_3484P--
