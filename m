Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271154AbTG1WUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTG1WUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:20:08 -0400
Received: from mx.laposte.net ([213.30.181.11]:48729 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S271154AbTG1WUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:20:02 -0400
Message-ID: <041201c35551$8af611c0$0a00a8c0@toumi>
From: "Ghozlane Toumi" <gtoumi@laposte.net>
To: <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
References: <UTC200307281315.h6SDFOY08368.aeb@smtp.cwi.nl> <030201c3550f$dec61620$0a00a8c0@toumi>
Subject: [PATCH] sgi partitionning fix (Was: 2.6.0-test1 on alpha : disk label numbering trouble)
Date: Mon, 28 Jul 2003 23:45:12 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_040F_01C35562.49CF8A80"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C'est un message de format MIME en plusieurs parties.

------=_NextPart_000_040F_01C35562.49CF8A80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> quickly checking viro's changes in this area, it seems other partitions
> schemes are touched by the same problem...

I stand corrected. after looking a little bit deeper, the sun partition
has been corrected, the other are not touched.
However, I found out that sgi partitionning had this "renumbering"
issue even before viro's patch.
I don't know if this is correct, in any case this is an untested patch
that changes this behaviour for sgi partitions.
patch is attached because of dumb mailer.

thanks, 
ghoz




------=_NextPart_000_040F_01C35562.49CF8A80
Content-Type: application/octet-stream;
	name="partition.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="partition.diff"

diff -Nr -U4 -X dontdiff linux-2.6.0-test1.orig/fs/partitions/sgi.c =
linux-2.6.0-test1/fs/partitions/sgi.c=0A=
--- linux-2.6.0-test1.orig/fs/partitions/sgi.c	Mon Jul 14 05:31:22 2003=0A=
+++ linux-2.6.0-test1/fs/partitions/sgi.c	Mon Jul 28 23:58:23 2003=0A=
@@ -29,9 +29,8 @@=0A=
 =0A=
 int sgi_partition(struct parsed_partitions *state, struct block_device =
*bdev)=0A=
 {=0A=
 	int i, csum, magic;=0A=
-	int slot =3D 1;=0A=
 	unsigned int *ui, start, blocks, cs;=0A=
 	Sector sect;=0A=
 	struct sgi_disklabel *label;=0A=
 	struct sgi_partition *p;=0A=
@@ -67,9 +66,9 @@=0A=
 	for(i =3D 0; i < 16; i++, p++) {=0A=
 		blocks =3D be32_to_cpu(p->num_blocks);=0A=
 		start  =3D be32_to_cpu(p->first_block);=0A=
 		if (blocks)=0A=
-			put_partition(state, slot++, start, blocks);=0A=
+			put_partition(state, i+1, start, blocks);=0A=
 	}=0A=
 	printk("\n");=0A=
 	put_dev_sector(sect);=0A=
 	return 1;=0A=

------=_NextPart_000_040F_01C35562.49CF8A80--

