Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVBLB5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVBLB5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVBLB5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:57:53 -0500
Received: from smtp08.auna.com ([62.81.186.18]:37312 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261951AbVBLB5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:57:49 -0500
Date: Sat, 12 Feb 2005 01:57:48 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] fixes for cdsymlinks.c
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>
X-Mailer: Balsa 2.3.0
Message-Id: <1108173468l.5587l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-MeOzrHHSN0x2itkeSH1S"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-MeOzrHHSN0x2itkeSH1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi...

I needed this patch to get this working, I think they are obvious
corrections:

--- cdsymlinks.c.orig	2005-02-12 02:51:15.000000000 +0100
+++ cdsymlinks.c	2005-02-12 02:48:35.000000000 +0100
@@ -218,7 +218,7 @@
 list_assign_split (struct list_t *list, char *text)
 {
   char *token =3D strchr (text, ':');
-  token =3D strtok (token ? token + 1 : text, " \t");
+  token =3D strtok (token ? token + 1 : text, " \t\n");
   while (token)
   {
     list_prepend (list, token);
@@ -267,8 +267,8 @@
             list_delete (&allowed_output);
             list_assign_split (&allowed_output, p.we_wordv[0] + 7);
           }
-          else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=3D", 14))
-            numbered_links =3D atoi (p.we_wordv[0] + 14);
+          else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=3D", 15))
+            numbered_links =3D atoi (p.we_wordv[0] + 15);
           break;
 	}
 	/* fall through */
@@ -325,9 +325,9 @@
       list_assign_split (&cap_CDRW, text);
     else if (!strncasecmp (text, "Can write CD-R", 14))
       list_assign_split (&cap_CDR, text);
-    else if (!strncasecmp (text, "Can read MRW", 14))
+    else if (!strncasecmp (text, "Can read MRW", 12))
       list_assign_split (&cap_CDMRW, text);
-    else if (!strncasecmp (text, "Can write MRW", 14))
+    else if (!strncasecmp (text, "Can write MRW", 13))
       list_assign_split (&cap_CDWMRW, text);
   }
   if (!feof (info))

Hope this is correct and will be included in udev-054 ;)

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam9 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-MeOzrHHSN0x2itkeSH1S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDWKcRlIHNEGnKMMRApaCAJ9Q2AdlhT4fAEkm4I85Gbc1m+z9bQCggRiT
2dqwZpqxWKX0pwyYcMXFS40=
=U1cM
-----END PGP SIGNATURE-----

--=-MeOzrHHSN0x2itkeSH1S--

