Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUDENb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDENb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:31:26 -0400
Received: from mivlgu.ru ([81.18.140.87]:57279 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S262441AbUDENbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:31:08 -0400
Date: Mon, 5 Apr 2004 17:30:53 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: documentation update
Message-Id: <20040405173053.5e47c44f.vsu@altlinux.ru>
In-Reply-To: <20040405124103.GA30293@bytesex.org>
References: <20040405124103.GA30293@bytesex.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__5_Apr_2004_17_30_53_+0400_xtVVCBGZ92gBN=yd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__5_Apr_2004_17_30_53_+0400_xtVVCBGZ92gBN=yd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 5 Apr 2004 14:41:03 +0200 Gerd Knorr wrote:

> This patch updates the documentation for the v4l drivers.
[skip]

The update to linux/Documentation/video4linux/CARDLIST.saa7134 is
buggy - I have just noticed this problem when building your drivers.
Here is the fix for your scripts which generate this file:

--- video4linux/scripts/saa7134.pl.saa7134-list-fix	2004-03-05 17:04:57 +0300
+++ video4linux/scripts/saa7134.pl	2004-04-04 23:00:18 +0400
@@ -21,11 +21,14 @@
 my %data;
 
 while (<>) {
+	if (/#define\s+(SAA7134_BOARD_\w+)\s+(\d+)/) {
+		$data{$1}->{nr} = $2;
+		next;
+	}
 	# saa7134_boards
 	if (/\[(SAA7134_BOARD_\w+)\]/) {
 		$id = $1;
 		$data{$id}->{id} = $id;
-		$data{$id}->{nr} = $nr++;
 	};
 	next unless defined($id);
 
--- video4linux/scripts/cardlist.saa7134-list-fix	2004-02-22 04:59:36 +0300
+++ video4linux/scripts/cardlist	2004-04-04 22:59:36 +0400
@@ -10,6 +10,6 @@
 	| perl -ne '/"([^"]+)"/; printf("tuner=%d - %s\n",$i++,$1)' \
 	> doc/CARDLIST.tuner
 
-scripts/saa7134.pl saa7134-cards.c \
+scripts/saa7134.pl saa7134.h saa7134-cards.c \
 	> doc/CARDLIST.saa7134
 

--Signature=_Mon__5_Apr_2004_17_30_53_+0400_xtVVCBGZ92gBN=yd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcV+QW82GfkQfsqIRAiWZAJ4lI0SYRVSzIgQq2OdQZgC8f0v8BQCdH/IZ
9xKXAd63B0Bt0EfRNTPAfh0=
=zOzP
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Apr_2004_17_30_53_+0400_xtVVCBGZ92gBN=yd--
