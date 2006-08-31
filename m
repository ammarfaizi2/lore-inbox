Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWHaNaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWHaNaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHaNaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:30:06 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:39886 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932274AbWHaNaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:30:05 -0400
Message-ID: <44F6E45B.4070708@comcast.net>
Date: Thu, 31 Aug 2006 07:30:03 -0600
From: "Ian S. Nelson" <nelsonian@comcast.net>
Reply-To: nelsonis@earthlink.net
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: corbet@lwn.net, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Really stupid /sys/modules patch
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=00D3D983
Content-Type: multipart/mixed;
 boundary="------------070308080807000003090906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308080807000003090906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I've been using systemtap for some debugging and I noticed that it
can't probe a lot of modules.     Turns out it's kind of silly,  the
sections section of /sys/module is limited to 32bytes and many of the
actual sections are a a bit longer than that.  

It seems to fix systemtap.

- --
signature


*Ian S. Nelson
PGP/GPG <http://www.gnupg.org/(en)/documentation/faqs.html#q1.1> email
preferred.
Public Key: 00D3D983
<http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x00D3D983>
Fingerprint: 3EFD7B86B888D7E229B69E97576F1B9700D3D983 *

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9uRUV28blwDT2YMRAuGiAJsHzufM8g865+19gecHpIAt57c6SACbBilu
e6o2ByDqZT/xnQgBJeGa0DI=
=32cp
-----END PGP SIGNATURE-----


--------------070308080807000003090906
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="module_sections.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module_sections.patch"

diff -urP linux-2.6.17.11/CREDITS linux-2.6.17.11.fixed/CREDITS
--- linux-2.6.17.11/CREDITS	2006-08-23 15:16:33.000000000 -0600
+++ linux-2.6.17.11.fixed/CREDITS	2006-08-31 07:00:42.194781826 -0600
@@ -2469,7 +2469,8 @@
 S: United Kingdom
 
 N: Ian S. Nelson
-E: ian.nelson@echostar.com
+E: nelsonis@earthlink.net
+P: 1024D/00D3D983 3EFD 7B86 B888 D7E2 29B6  9E97 576F 1B97 00D3 D983
 D: Minor mmap and ide hacks
 S: 1370 Atlantis Ave.
 S: Lafayette CO, 80026
diff -urP linux-2.6.17.11/include/linux/module.h linux-2.6.17.11.fixed/include/linux/module.h
--- linux-2.6.17.11/include/linux/module.h	2006-08-23 15:16:33.000000000 -0600
+++ linux-2.6.17.11.fixed/include/linux/module.h	2006-08-30 20:32:14.974645595 -0600
@@ -217,7 +217,7 @@
 };
 
 /* Similar stuff for section attributes. */
-#define MODULE_SECT_NAME_LEN 32
+#define MODULE_SECT_NAME_LEN 96
 struct module_sect_attr
 {
 	struct module_attribute mattr;

--------------070308080807000003090906--
