Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbULERrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbULERrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULERrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:47:05 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:40644 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261323AbULERl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:41:59 -0500
Message-ID: <41B34863.3090007@g-house.de>
Date: Sun, 05 Dec 2004 18:41:55 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: sheutlin@gmx.de
CC: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Sven Hartge <hartge@ds9.argh.org>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
References: <41B23DF2.4010303@g-house.de> <1102207299.6778.16.camel@weizen.left.earth>
In-Reply-To: <1102207299.6778.16.camel@weizen.left.earth>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060304030807010604020208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304030807010604020208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sebastian Heutling schrieb:
> You got the powerstack booting from scsi (reading and interpreting the

yes, but now the disk is gone and i have to use nfsroot.

> bug report). I had problems booting 2.6 kernels as well (never tested
> any 2.5 kernels). It turned out that the pci slot numbering has changed
> sometime and this wasn't reflected in arch/ppc/platforms/prep_pci.c.
> After having set up the slot0...slot8 using the values of
> slot10...slot18 (except for slot1 which got value 4 so IDE is usable out
> of the box), the machine booted a 2.6 kernel (2.6.8).

boy! this *is* an early christmas present, for sure! how did you come to
this conclusion? something *must* have changed in the pci setup after
2.5.30, because the problem did not go away when i used a different NIC
driver. but i could not fiddle out the changeset to blame here, because i
failed to compile many kernels > 2.5.30.

changing one line in arch/ppc/platforms/prep_pci.c made my PReP booting a
recent 2.6-BK, patch attached.

it's booting now, "init=/bin/bash" is working, but i still can't ping to
the outside world, which is still a bit strange, but i hope i can work it out.

tausend dank (really),
Christian.
- --
BOFH excuse #304:

routing problems on the neural net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs0hj+A7rjkF8z0wRAo3RAKDF+QYA6cosLH+kWtiAmiWtRzlQkQCeKcpx
FXOiNRfl9/vOynE8d4hDJJg=
=sKOm
-----END PGP SIGNATURE-----

--------------060304030807010604020208
Content-Type: text/x-patch;
 name="prep_pci_2.6.10-rc2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prep_pci_2.6.10-rc2.patch"

--- linux-2.5-PPC-BK/arch/ppc/platforms/prep_pci.c	2004-12-05 18:20:04.000000000 +0100
+++ linux-2.5-PPC-BK/arch/ppc/platforms/prep_pci.c.edited	2004-12-05 18:21:33.000000000 +0100
@@ -61,7 +61,7 @@
         0,   /* Slot 11 - unused */
         5,   /* Slot 12 - SCSI - NCR825A */
         0,   /* Slot 13 - unused */
-        3,   /* Slot 14 - enet */
+        1,   /* Slot 14 - enet */
         0,   /* Slot 15 - unused */
         2,   /* Slot 16 - unused */
         3,   /* Slot 17 - unused */

--------------060304030807010604020208--
