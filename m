Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753249AbVHHCOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbVHHCOU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 22:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbVHHCOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 22:14:20 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:57357 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1753249AbVHHCOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 22:14:20 -0400
Message-ID: <42F6BFAB.4010807@tuxrocks.com>
Date: Sun, 07 Aug 2005 20:12:59 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch] i386: build.c: Write out larger system size to bootsector
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch allows build.c to write out the full system size to the bootsector for system sizes larger than about 1 MB (1048560 bytes) by using another byte (a 4th byte would allow system sizes larger than 268 MB).

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

- --- a/arch/i386/boot/tools/build.c	2005-08-07 18:08:29.000000000 -0600
+++ b/arch/i386/boot/tools/build.c	2005-08-07 18:09:51.000000000 -0600
@@ -177,7 +177,8 @@
 		die("Output: seek failed");
 	buf[0] = (sys_size & 0xff);
 	buf[1] = ((sys_size >> 8) & 0xff);
- -	if (write(1, buf, 2) != 2)
+	buf[2] = ((sys_size >> 16) & 0xff);
+	if (write(1, buf, 3) != 3)
 		die("Write of image length failed");
 
 	return 0;					    /* Everything is OK */



Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC9r+raI0dwg4A47wRAtXCAKCm3f2Afx/SC5H+6HJz2JzM9cA1ZQCgjMbg
qt7Rmo23aWfG1cvsZrcsQvA=
=0iHd
-----END PGP SIGNATURE-----
