Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWBXJvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWBXJvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBXJvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:51:00 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:45322 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932090AbWBXJvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:51:00 -0500
Message-ID: <43FED6FC.3090604@imap.cc>
Date: Fri, 24 Feb 2006 10:50:52 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: [PATCH] reduce syslog clutter
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3EE843C1635C773B5C9F180"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3EE843C1635C773B5C9F180
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

The current versions of the err() / info() / warn() syslog macros
insert __FILE__ at the beginning of the message, which expands to
the complete path name of the source file within the kernel tree.

With the following patch, when used in a module, they'll insert the
module name instead, which is significantly shorter and also tends to
be more useful to users trying to make sense of a particular message.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 usb.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -ru linux-2.6.16-rc4-mm1-orig/include/linux/usb.h linux-2.6.16-rc4-patch-splitpoint/include/linux/usb.h
--- linux-2.6.16-rc4-mm1-orig/include/linux/usb.h	2006-02-22 12:04:07.000000000 +0100
+++ linux-2.6.16-rc4-patch-splitpoint/include/linux/usb.h	2006-02-24 10:37:53.000000000 +0100
@@ -1211,11 +1211,11 @@
 #endif

 #define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)


 #endif  /* __KERNEL__ */

--
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)




--------------enigD3EE843C1635C773B5C9F180
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/tb8MdB4Whm86/kRAmWxAJ48MxcmiWQTLP/R1RhDualEYv4feACePghm
m+QEtyjj8I262nIB5a0L8yI=
=vYdJ
-----END PGP SIGNATURE-----

--------------enigD3EE843C1635C773B5C9F180--
