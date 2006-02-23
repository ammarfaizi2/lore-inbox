Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWBWXKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWBWXKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWBWXKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:10:10 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56544 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751774AbWBWXKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:10:07 -0500
X-Sasl-enc: XLvolVr2+ChkzkWyp1OLAe3yuC3IEstNEh39s2J7ES6R 1140736203
Message-ID: <43FE40CD.3060803@imap.cc>
Date: Fri, 24 Feb 2006 00:10:05 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hjlipp@web.de
Subject: [PATCH] reduce syslog clutter
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA6F18988AA94CF6540891378"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6F18988AA94CF6540891378
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The current versions of the err() / info() / warn() syslog macros
insert __FILE__ at the beginning of the message, which expands to
the complete path name of the source file within the kernel tree.

With the following patch, when used in a module, they'll insert the
module name instead, which is significantly shorter and also tends to
be more useful to users trying to make sense of a particular message.

The patch also adds macros for the KERN_NOTICE severity level which
was so far uncatered for.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 include/linux/device.h |    2 ++
 include/linux/usb.h    |    8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff -ru linux-2.6.16-rc4/include/linux/device.h linux-2.6.16-rc4-new/inc=
lude/linux/device.h
--- linux-2.6.16-rc4/include/linux/device.h	2006-02-13 01:27:25.000000000=
 +0100
+++ linux-2.6.16-rc4-new/include/linux/device.h	2006-02-23 23:28:00.00000=
0000 +0100
@@ -424,6 +424,8 @@
 	dev_printk(KERN_INFO , dev , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
 	dev_printk(KERN_WARNING , dev , format , ## arg)
+#define dev_notice(dev, format, arg...)		\
+	dev_printk(KERN_NOTICE , dev , format , ## arg)

 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
diff -ru linux-2.6.16-rc4/include/linux/usb.h linux-2.6.16-rc4-new/includ=
e/linux/usb.h
--- linux-2.6.16-rc4/include/linux/usb.h	2006-02-22 12:04:07.000000000 +0=
100
+++ linux-2.6.16-rc4-new/include/linux/usb.h	2006-02-23 23:30:35.00000000=
0 +0100
@@ -1211,11 +1211,13 @@
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
+#define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n", \
+	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)


 #endif  /* __KERNEL__ */

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA6F18988AA94CF6540891378
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/kDWMdB4Whm86/kRAipGAJ9ZkIgw7wu6pxdUR63j7tPwYdAykwCfaff1
kZnp2+xH1Kge6DG+zWRHFbI=
=bB2E
-----END PGP SIGNATURE-----

--------------enigA6F18988AA94CF6540891378--
