Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbTCaMCb>; Mon, 31 Mar 2003 07:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbTCaMCb>; Mon, 31 Mar 2003 07:02:31 -0500
Received: from smtpout.mac.com ([17.250.248.86]:25065 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261609AbTCaMC3>;
	Mon, 31 Mar 2003 07:02:29 -0500
Subject: Re: [2.5 patch] typo fix for compilation
From: Peter Waechtler <pwaechtler@mac.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030331100503.GD22827@fs.tum.de>
References: <20030321201012.GO6940@fs.tum.de>
	<1048443066.1936.2.camel@picklock> <20030330093048.GF10005@fs.tum.de>
	<1049068012.2798.13.camel@picklock>  <20030331100503.GD22827@fs.tum.de>
Content-Type: multipart/mixed; boundary="=-oBKG2y4ykXi7GzkBauyZ"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Mar 2003 14:14:05 +0200
Message-Id: <1049112850.1873.1.camel@picklock>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oBKG2y4ykXi7GzkBauyZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-03-31 at 12:05, Adrian Bunk wrote:
> On Mon, Mar 31, 2003 at 02:04:04AM +0200, Peter Waechtler wrote:
> > 
> > There's a problem when compiling the GUS driver into the kernel
> > instead of as a module. I renamed the global "lock" to "gus_lock"
> > and made sure that it's used (shared by gus_midi, gus_wave, ics2101)
> > 
> > [snippet of sound/oss/Makefile]
> > obj-$(CONFIG_SOUND_GUS)         += gus.o ad1848.o
> > gus-objs        := gus_card.o gus_midi.o gus_vol.o gus_wave.o ics2101.o
> > 
> > 
> > Adrian: Do you have a GUS and can test this?
> 
> Unfortunately not, I noticed this problem while doing compile-only tests 
> with a .config that has as much as possible enabled.
> 
> BTW:
> The sound/oss/mad16.c part of your patch doesn't belong to this problem?
> 

No. But there are more compile errors I've fixed while at it:



--=-oBKG2y4ykXi7GzkBauyZ
Content-Disposition: attachment; filename=c.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=c.patch; charset=ISO-8859-15

diff -Nur -X dontdiff vanilla-2.5.66/drivers/char/ipmi/ipmi_devintf.c linux=
-2.5.66/drivers/char/ipmi/ipmi_devintf.c
--- vanilla-2.5.66/drivers/char/ipmi/ipmi_devintf.c	2003-03-26 19:53:59.000=
000000 +0100
+++ linux-2.5.66/drivers/char/ipmi/ipmi_devintf.c	2003-03-30 22:26:10.00000=
0000 +0200
@@ -449,7 +449,7 @@
 	if (if_num > MAX_DEVICES)
 		return;
=20
-	snprinf(name, sizeof(name), "ipmidev/%d", if_num);
+	snprintf(name, sizeof(name), "ipmidev/%d", if_num);
=20
 	handles[if_num] =3D devfs_register(NULL, name, DEVFS_FL_NONE,
 					 ipmi_major, if_num,
diff -Nur -X dontdiff vanilla-2.5.66/drivers/net/tokenring/tms380tr.c linux=
-2.5.66/drivers/net/tokenring/tms380tr.c
--- vanilla-2.5.66/drivers/net/tokenring/tms380tr.c	2003-02-16 19:49:55.000=
000000 +0100
+++ linux-2.5.66/drivers/net/tokenring/tms380tr.c	2003-03-30 20:58:37.00000=
0000 +0200
@@ -257,7 +257,7 @@
 	int err;
 =09
 	/* init the spinlock */
-	spin_lock_init(tp->lock);
+	spin_lock_init(&tp->lock);
=20
 	/* Reset the hardware here. Don't forget to set the station address. */
=20
diff -Nur -X dontdiff vanilla-2.5.66/fs/cramfs/inode.c linux-2.5.66/fs/cram=
fs/inode.c
--- vanilla-2.5.66/fs/cramfs/inode.c	2003-03-26 19:54:05.000000000 +0100
+++ linux-2.5.66/fs/cramfs/inode.c	2003-03-30 18:31:42.000000000 +0200
@@ -51,7 +51,7 @@
 		inode->i_blocks =3D (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize =3D PAGE_CACHE_SIZE;
 		inode->i_gid =3D cramfs_inode->gid;
-		inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D 0;
+		inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D CURRENT_TIME;
 		inode->i_ino =3D CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory

--=-oBKG2y4ykXi7GzkBauyZ--

