Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWBXKFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWBXKFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 05:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWBXKFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 05:05:50 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:62215 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932173AbWBXKFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 05:05:50 -0500
Message-ID: <43FEDA79.3010505@imap.cc>
Date: Fri, 24 Feb 2006 11:05:45 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
CC: hjlipp@web.de
Subject: [PATCH] add macros notice(), dev_notice()
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8AA1E99671EC421D64BA22DE"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AA1E99671EC421D64BA22DE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Both usb.h and device.h have collections of convenience macros for
printk() with the KERN_ERR, KERN_WARNING, and KERN_NOTICE severity
levels. This patch adds macros for the KERN_NOTICE level which was
so far uncatered for.

These macros already exist privately in drivers/isdn/gigaset/gigaset.h
(currently in the process of being submitted for the kernel tree)
but they really belong with their brothers and sisters in
include/linux/{device,usb}.h.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 device.h |    2 ++
 usb.h    |    2 ++
 2 files changed, 4 insertions(+)

diff -ru linux-2.6.16-rc4-patch-splitpoint/include/linux/device.h linux-2.6.16-rc4/include/linux/device.h
--- linux-2.6.16-rc4-patch-splitpoint/include/linux/device.h	2006-02-24 10:36:10.000000000 +0100
+++ linux-2.6.16-rc4/include/linux/device.h	2006-02-23 23:28:00.000000000 +0100
@@ -424,6 +424,8 @@
 	dev_printk(KERN_INFO , dev , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
 	dev_printk(KERN_WARNING , dev , format , ## arg)
+#define dev_notice(dev, format, arg...)		\
+	dev_printk(KERN_NOTICE , dev , format , ## arg)

 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
diff -ru linux-2.6.16-rc4-patch-splitpoint/include/linux/usb.h linux-2.6.16-rc4/include/linux/usb.h
--- linux-2.6.16-rc4-patch-splitpoint/include/linux/usb.h	2006-02-24 10:37:53.000000000 +0100
+++ linux-2.6.16-rc4/include/linux/usb.h	2006-02-23 23:30:35.000000000 +0100
@@ -1216,6 +1216,8 @@
 	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , \
 	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)
+#define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n" , \
+	THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)


 #endif  /* __KERNEL__ */

--
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)




--------------enig8AA1E99671EC421D64BA22DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/tp5MdB4Whm86/kRAn8PAJ9U1JartaKNkav3psP65kygFACfNwCfVFjj
IMN8SlFikCgRK1AS/RFrJKQ=
=sQqQ
-----END PGP SIGNATURE-----

--------------enig8AA1E99671EC421D64BA22DE--
