Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUHXVAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUHXVAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUHXVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:00:14 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:34755 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S268322AbUHXU6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:58:41 -0400
Message-ID: <011901c48a1d$22404ae0$1225a8c0@kittycat>
From: "jdow" <jdow@earthlink.net>
To: <linux-kernel@vger.kernel.org>
References: <200408241218.OAA09873@cleopatra.math.tu-berlin.de>
Subject: Re: Amiga partition reading patch
Date: Tue, 24 Aug 2004 13:58:40 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0116_01C489E2.75B42150"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0116_01C489E2.75B42150
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Something stripped it off. I had it called "amiga_partition_patch.dat".
That seems to be a magic suffix for too many things these days. Here it
is again.
{^_^}

----- Original Message ----- 
From: "Thomas Richter" <thor@math.TU-Berlin.DE>
To: "jdow" <jdow@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, 2004 August, 24 05:18
Subject: Re: Amiga partition reading patch


>
> Hi Joanne,
>
> > This is a patch known good against Mandrake 2.6.3-7mdk. I suspect it
will
> > apply to later versions equally well since the file affected appears to
> > be unchanged as late as 2.6.9-rc1.
>
> Sorry, I don't have a patch attached here. Forgot to include?
>
> > This partitioning information is known correct. I wrote the low level
> > portion of the hard disk partitioning code for AmigaDOS 3.5 and 3.9. I
> > am also responsible for one of the more frequently used partitioning
> > tools, RDPrepX, before that.
>
> I can confirm this (as "just another guy" who wrote on AmigaOs 3.9).
>
> So long,
> Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_0116_01C489E2.75B42150
Content-Type: application/octet-stream;
	name="amiga_partition_patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="amiga_partition_patch"

--- amiga.c	2004-08-09 08:52:07.268123677 -0700=0A=
+++ amiga.c.orig	2004-08-09 08:51:31.527104456 -0700=0A=
@@ -31,7 +31,6 @@ amiga_partition(struct parsed_partitions=0A=
 	struct RigidDiskBlock *rdb;=0A=
 	struct PartitionBlock *pb;=0A=
 	int start_sect, nr_sects, blk, part, res =3D 0;=0A=
-	int blksize =3D 1;	/* Multiplier for disk block size */=0A=
 	int slot =3D 1;=0A=
 	char b[BDEVNAME_SIZE];=0A=
 =0A=
@@ -66,14 +65,10 @@ amiga_partition(struct parsed_partitions=0A=
 			       bdevname(bdev, b), blk);=0A=
 	}=0A=
 =0A=
-        /* blksize is blocks per 512 byte standard block */=0A=
-        blksize =3D be32_to_cpu( rdb->rdb_BlockBytes ) / 512;=0A=
-=0A=
-	printk(" RDSK (%d)", blksize * 512);	/* Be more informative */=0A=
+	printk(" RDSK");=0A=
 	blk =3D be32_to_cpu(rdb->rdb_PartitionList);=0A=
 	put_dev_sector(sect);=0A=
 	for (part =3D 1; blk>0 && part<=3D16; part++, put_dev_sector(sect)) {=0A=
-		blk *=3D blksize;	/* Read in terms partition table understands */=0A=
 		data =3D read_dev_sector(bdev, blk, &sect);=0A=
 		if (!data) {=0A=
 			if (warn_no_part)=0A=
@@ -93,32 +88,13 @@ amiga_partition(struct parsed_partitions=0A=
 		nr_sects =3D (be32_to_cpu(pb->pb_Environment[10]) + 1 -=0A=
 			    be32_to_cpu(pb->pb_Environment[9])) *=0A=
 			   be32_to_cpu(pb->pb_Environment[3]) *=0A=
-			   be32_to_cpu(pb->pb_Environment[5]) *=0A=
-			   blksize;=0A=
+			   be32_to_cpu(pb->pb_Environment[5]);=0A=
 		if (!nr_sects)=0A=
 			continue;=0A=
 		start_sect =3D be32_to_cpu(pb->pb_Environment[9]) *=0A=
 			     be32_to_cpu(pb->pb_Environment[3]) *=0A=
-			     be32_to_cpu(pb->pb_Environment[5]) *=0A=
-			     blksize;=0A=
+			     be32_to_cpu(pb->pb_Environment[5]);=0A=
 		put_partition(state,slot++,start_sect,nr_sects);=0A=
-		{=0A=
-			/* Be even more informative to aid mounting */=0A=
-			char dostype[ 4 ];=0A=
-			u32 *dt =3D (u32*) dostype;=0A=
-			*dt =3D pb->pb_Environment[ 16 ];=0A=
-			if ( dostype[ 3 ] < ' ')=0A=
-				printk( " (%c%c%c^%c)",=0A=
-					dostype[ 0 ], dostype[ 1 ],=0A=
-					dostype[ 2 ], dostype[ 3 ] + '@' );=0A=
-			else=0A=
-				printk( " (%c%c%c%c)",=0A=
-					dostype[ 0 ], dostype[ 1 ],=0A=
-					dostype[ 2 ], dostype[ 3 ]);=0A=
-			printk( "(res %d spb %d)",=0A=
-				be32_to_cpu( pb->pb_Environment[ 6 ]),=0A=
-				be32_to_cpu( pb->pb_Environment[ 4 ]));=0A=
-		}=0A=
 		res =3D 1;=0A=
 	}=0A=
 	printk("\n");=0A=

------=_NextPart_000_0116_01C489E2.75B42150--


