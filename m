Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSBRWZS>; Mon, 18 Feb 2002 17:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSBRWZI>; Mon, 18 Feb 2002 17:25:08 -0500
Received: from main.braxis.co.uk ([213.77.40.29]:34572 "EHLO main.braxis.co.uk")
	by vger.kernel.org with ESMTP id <S288325AbSBRWYv>;
	Mon, 18 Feb 2002 17:24:51 -0500
Date: Mon, 18 Feb 2002 23:24:51 +0100
From: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make IP-Config work without ip= supplied
Message-ID: <20020218222451.GA23899@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-PGP-Key-URL: http://braxis.co.uk/~kszysiu/kszysiu.pgp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline


Hi,

Just noticed that IP-Config behavior when no ip= parm is used has changed in
2.2.18.

Up to 2.2.17 IP-Config was enabled even when ip= was omitted. I think that
it's good for use in i.e. diskless nodes.

Since 2.2.18, IP-Config does nothing at all until ip= is passed to the
kernel, however Documentation/nfsroot.txt still says that IP-Config is
enabled by default. Was that intentional change?

Such behavior remains in both 2.2.20 and 2.4.18-rc1. Following patches
(against these two kernel trees) make IP-Config enabled by default.

Cheers,
Krzysztof

PS
please CC, not a subscriber.

PS2
this was also sent to linux-net but got spamfiltered, i suppose
(checked on marc.theaimsgroup.com)

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="ipconfig.c.diff-2.4.18-rc1"

--- linux/net/ipv4/ipconfig.c~	Sun Feb 17 20:29:00 2002
+++ linux/net/ipv4/ipconfig.c	Sun Feb 17 20:35:27 2002
@@ -102,7 +102,7 @@
  */
 int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
 
-int ic_enable __initdata = 0;			/* IP config enabled? */
+int ic_enable __initdata = 1;			/* IP config enabled? */
 
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="ipconfig.c.diff-2.2.20"

--- linux/net/ipv4/ipconfig.c.orig	Sun Mar 25 18:31:12 2001
+++ linux/net/ipv4/ipconfig.c	Sun Feb 17 20:42:32 2002
@@ -87,7 +87,7 @@
  * Public IP configuration
  */
 
-int ic_enable __initdata = 0;			/* IP config enabled? */
+int ic_enable __initdata = 1;			/* IP config enabled? */
 
 /* Protocol choice */
 static int ic_proto_enabled __initdata = 0

--ibTvN161/egqYuK8--
