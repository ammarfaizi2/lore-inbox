Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUBKC6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 21:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUBKC6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 21:58:22 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:63965 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261909AbUBKC6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 21:58:19 -0500
Date: Wed, 11 Feb 2004 02:58:10 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: Critical problem in 2.6.2 and up
Message-ID: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings,

Somewhere between 2.6.2-rc3 and 2.6.2, more specificly between 2.6.2-rc3 and
2.6.2-rc3-mm1 appeared a patch in the bitkeeper, that was included in
linux.patch used in 2.6.2-rc3-mm1, in 2.6.2 and it's still present.

The patch follows:

diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
- --- a/drivers/block/genhd.c     Wed Feb  4 16:51:35 2004
+++ b/drivers/block/genhd.c     Wed Feb  4 16:51:35 2004
@@ -260,8 +260,10 @@
        if (&sgp->kobj.entry == block_subsys.kset.list.next)
                seq_puts(part, "major minor  #blocks  name\n\n");

- -       /* Don't show non-partitionable devices or empty devices */
- -       if (!get_capacity(sgp) || sgp->minors == 1)
+       /* Don't show non-partitionable removeable devices or empty devices */
+       if (!get_capacity(sgp) ||
+           (sgp->minors == 1 && (sgp->flags & GENHD_FL_REMOVABLE))
+               )
                return 0;

        /* show the full disk and all non-0 size partitions of it */


This patch should be -R's ASAP, since it cause major problems: as an example, I
have an Asus M3700N laptopwhere this patch causes the system to do this:


# lilo

Warning: '/proc/partitions' does not match '/dev' directory structure.
    Name change: '/dev/nbd0' -> '/tmp/dev.0'
Warning: '/dev' directory structure is incomplete; device (43, 0) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 1) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 2) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 3) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 4) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 5) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 6) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 7) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 8) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 9) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 10) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 11) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 12) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 13) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 14) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 15) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 16) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 17) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 18) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 19) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 20) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 21) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 22) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 23) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 24) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 25) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 26) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 27) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 28) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 29) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 30) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 31) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 32) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 33) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 34) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 35) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 36) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 37) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 38) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 39) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 40) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 41) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 42) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 43) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 44) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 45) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 46) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 47) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 48) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 49) is missing.
Warning: '/dev' directory structure is incomplete; device (43, 50) is missing.
Fatal: Failed to create a temporary device


If I revert the patch lilo runs normally.


Best regards,
Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFAKZpHmNlq8m+oD34RAkxDAKDNZQyB2od/YodaSfzz5/y42UtN7QCeMOXi
UmmlXpVMpnNUDEqNU/UiviE=
=hxWi
-----END PGP SIGNATURE-----

