Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265660AbRFWHYE>; Sat, 23 Jun 2001 03:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbRFWHXy>; Sat, 23 Jun 2001 03:23:54 -0400
Received: from [12.36.4.15] ([12.36.4.15]:43507 "EHLO lydia")
	by vger.kernel.org with ESMTP id <S265660AbRFWHXn>;
	Sat, 23 Jun 2001 03:23:43 -0400
To: linux-kernel@vger.kernel.org
Subject: osst & ide-2.2.19 conflict?
From: soma@cs.unm.edu (Anil B. Somayaji)
Date: 23 Jun 2001 01:23:42 -0600
Message-ID: <ut2lmmjek1t.fsf@lydia.adaptive.net>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In the ide.2.2.19.05042001 patch, there is the following bit of code
in ide-scsi.c, which prevents the ide-scsi driver from allowing access
to an OnStream DI-30 tape drive.  This is strange, since this same
drive can be used with the included ide-scsi + osst drivers in the
stock 2.2.19 kernel.  If you delete this bit, however, ide-scsi
recognizes the drive, and the osst driver seems to work fine.

Here's the offending code:

  #ifndef CONFIG_BLK_DEV_IDETAPE
   /*
    * The Onstream DI-30 does not handle clean emulation, yet.
    */
   if (strstr(drive->id->model, "OnStream DI-30")) {
           printk("ide-tape: ide-scsi emulation is not supported for %s.\n", drive->id->model);
           continue;
   }
  #endif /* CONFIG_BLK_DEV_IDETAPE */

Any reason for this to stay in the ide patch, or is it now obsolete?

  --Anil

- -- 
Anil Somayaji (soma@cs.unm.edu)
http://www.cs.unm.edu/~soma
+1 505 872 3150
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjs0Q/UACgkQXOpXEmNZ3SfrogCfbNzSB7zOjkItzYTOoplxaJJt
5AYAnRrB+KGTYj7wf3/GeV92TLvpKGqi
=1TVG
-----END PGP SIGNATURE-----
