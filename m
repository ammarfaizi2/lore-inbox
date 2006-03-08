Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWCHWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWCHWyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWCHWyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:54:12 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:14041 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030241AbWCHWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:54:09 -0500
X-Sasl-enc: dsygJ6SitJi3FfQC36z8jB6/k/aM2RTkE2eQ0rNtAsH5 1141858447
Message-ID: <440F609F.8090604@imap.cc>
Date: Wed, 08 Mar 2006 23:54:23 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: hjlipp@web.de, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: [PATCH] reduce syslog clutter (take 2)
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9185B0CB9709A5AFE76CC4B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9185B0CB9709A5AFE76CC4B8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The current versions of the err() / info() / warn() syslog macros
insert __FILE__ at the beginning of the message, which expands to
the complete path name of the source file within the kernel tree.

With the following patch, when used in a module, they'll insert the
module name instead, which is significantly shorter and also tends to
be more useful to users trying to make sense of a particular message.

This patch replaces the one posted on 24 Feb 2006 10:50:52 +0100
which caused compile errors in non-modular drivers. It applies to
kernel 2.6.16-rc5 after the patch labeled
"add macros notice(), dev_notice() (take 2)".

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 usb.h |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc5-patch-splitpoint/include/linux/usb.h	2006-03-08 12:3=
6:03.000000000 +0100
+++ linux-2.6.16-rc5-patch-splitpoint2/include/linux/usb.h	2006-03-08 12:=
43:07.000000000 +0100
@@ -1199,14 +1199,20 @@
 #define dbg(format, arg...) do {} while (0)
 #endif

+#if defined(CONFIG_MODULES) && defined(THIS_MODULE)
+#define KMSG_LOCATION_PREFIX THIS_MODULE ? THIS_MODULE->name : __FILE__
+#else
+#define KMSG_LOCATION_PREFIX __FILE__
+#endif
+
 #define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	KMSG_LOCATION_PREFIX , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	KMSG_LOCATION_PREFIX , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , \
-	__FILE__ , ## arg)
+	KMSG_LOCATION_PREFIX , ## arg)
 #define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n" , \=

-	__FILE__ , ## arg)
+	KMSG_LOCATION_PREFIX , ## arg)


 #endif  /* __KERNEL__ */

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig9185B0CB9709A5AFE76CC4B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFED2CfMdB4Whm86/kRArhEAJ9QRS9bIA/oSCoDgnQfoo6jImXUNQCfXh7j
3gDR4aT7L+ss7PqgrBYF0vc=
=UYoY
-----END PGP SIGNATURE-----

--------------enig9185B0CB9709A5AFE76CC4B8--
