Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262893AbTCKKyX>; Tue, 11 Mar 2003 05:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbTCKKyX>; Tue, 11 Mar 2003 05:54:23 -0500
Received: from pop.gmx.net ([213.165.64.20]:12691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262893AbTCKKyW> convert rfc822-to-8bit;
	Tue, 11 Mar 2003 05:54:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vsscanf do not convert hex numbers starting with a non-digit
Date: Tue, 11 Mar 2003 12:02:16 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303111202.19984.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I found the following little bug in 2.4.19. I did not try newer kernels.

vsscanf refuses to convert a hex number starting with a nondecimal digit like:

char *buf="ff";
unsigned ff=0;
sscanf( buf, "%x", &ff );      /* fails: nothing is converted */

Here is a patch that corrects that behaviour:

- --- linux/lib/vsprintf.c        2001-10-11 20:17:22.000000000 +0200
+++ linux.patched/lib/vsprintf.c        2003-03-11 11:52:08.000000000 +0100
@@ -637,7 +637,7 @@
                while (isspace(*str))
                        str++;
 
- -               if (!*str || !isdigit(*str))
+               if (!*str || !(isdigit(*str) || (base==16 && isxdigit(*str))))
                        break;
 
                switch(qualifier) {


Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bcI7wicyCTir8T4RAgsPAKCZtX+R9tljalegoC4z7xbTo3p38ACfUIYv
5xgo+tQqj8TZmQOM4W0MqqY=
=D9hc
-----END PGP SIGNATURE-----
