Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWCHWxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWCHWxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCHWxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:53:45 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53464 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932607AbWCHWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:53:44 -0500
X-Sasl-enc: 6vEqCeyK9LgH+M9GBRT9SxRN5tkQHoBxDPtp8cAHA4b9 1141858421
Message-ID: <440F6078.9050004@imap.cc>
Date: Wed, 08 Mar 2006 23:53:44 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: hjlipp@web.de, Greg KH <gregkh@suse.de>
Subject: [PATCH] add macros notice(), dev_notice() (take 2)
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig288B3A557DCEEE083A545EEB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig288B3A557DCEEE083A545EEB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Both usb.h and device.h have collections of convenience macros for
printk() with the KERN_ERR, KERN_WARNING, and KERN_NOTICE severity
levels. This patch adds macros for the KERN_NOTICE level which was
so far uncatered for.

These macros already exist privately in drivers/isdn/gigaset/gigaset.h
(currently in the process of being submitted for the kernel tree)
but they really belong with their brothers and sisters in
include/linux/{device,usb}.h.

This patch applies to kernel 2.6.16-rc5. It replaces the one posted
on 24 Feb 2006 11:05:45 +0100 which might cause compile errors in
non-modular drivers.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 device.h |    2 ++
 usb.h    |    2 ++
 2 files changed, 4 insertions(+)

diff -ru linux-2.6.16-rc5/include/linux/device.h linux-2.6.16-rc5-patch-s=
plitpoint/include/linux/device.h
--- linux-2.6.16-rc5/include/linux/device.h	2006-02-27 06:09:35.000000000=
 +0100
+++ linux-2.6.16-rc5-patch-splitpoint/include/linux/device.h	2006-03-08 1=
2:31:51.000000000 +0100
@@ -424,6 +424,8 @@
 	dev_printk(KERN_INFO , dev , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
 	dev_printk(KERN_WARNING , dev , format , ## arg)
+#define dev_notice(dev, format, arg...)		\
+	dev_printk(KERN_NOTICE , dev , format , ## arg)

 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
diff -ru linux-2.6.16-rc5/include/linux/usb.h linux-2.6.16-rc5-patch-spli=
tpoint/include/linux/usb.h
--- linux-2.6.16-rc5/include/linux/usb.h	2006-02-27 06:09:35.000000000 +0=
100
+++ linux-2.6.16-rc5-patch-splitpoint/include/linux/usb.h	2006-03-08 12:3=
6:03.000000000 +0100
@@ -1205,6 +1205,8 @@
 	__FILE__ , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , \
 	__FILE__ , ## arg)
+#define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n" , \=

+	__FILE__ , ## arg)


 #endif  /* __KERNEL__ */

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig288B3A557DCEEE083A545EEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFED2CCMdB4Whm86/kRAvh/AJ9xE/mWmstVGWWqm7A2wr0rtqj/3gCbBtDg
UkWzTFzexYtwqRC2TKl7Cyg=
=4HQg
-----END PGP SIGNATURE-----

--------------enig288B3A557DCEEE083A545EEB--
