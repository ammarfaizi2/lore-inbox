Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282008AbRKVCDM>; Wed, 21 Nov 2001 21:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282007AbRKVCDB>; Wed, 21 Nov 2001 21:03:01 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24785 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282008AbRKVCCs>; Wed, 21 Nov 2001 21:02:48 -0500
Subject: PATCH: gcc3.0.2 workaround for 8139too
From: Ali Akcaagac <ali.akcaagac@stud.fh-wilhelmshaven.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-u9OITEYJwFkY+ESqYTwA"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 22 Nov 2001 03:01:55 +0100
Message-Id: <1006394515.14661.0.camel@ulixys>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u9OITEYJwFkY+ESqYTwA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hello,

after 2.4.10 i've detected that using gcc 3.0.2 to compile the kernel
always fails with the 8139too realtek networkcard driver. errormessage
reports a bug in the compiler itself. 2.4.11-2.4.14 are affected by it
too. that's also the only file affected by this. i have investigated
into stuff and realized that there seems to be a little borkage with
understanding of strcpy. i can't tell how, why and what. i went to
irc.opensource.org and talked there with some people a while back, also
offered a 'temporarely solution' to get things compiled and operate
again (worksforme TM) and saw that a bunch of other people wanted to get
it working again in any circumstances.

so please allow me to post this 'temporarely workaround' here so other
people can profit of it until things with the gcc3.0.2 compiler are
solved.

thank you.

-- 
Name....: Ali Akcaagac
Status..: Student Of Computer & Economic Science
E-Mail..: mailto:ali.akcaagac@stud.fh-wilhelmshaven.de
WWW.....: http://www.fh-wilhelmshaven.de/~akcaagaa

--=-u9OITEYJwFkY+ESqYTwA
Content-Disposition: attachment; filename=8139too.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ANSI_X3.4-1968

--- linux/drivers/net/8139too.c.bak	Tue Nov 20 22:39:30 2001
+++ linux/drivers/net/8139too.c	Tue Nov 20 22:39:29 2001
@@ -2393,9 +2393,9 @@
 	case ETHTOOL_GDRVINFO:
 		{
 			struct ethtool_drvinfo info =3D { ETHTOOL_GDRVINFO };
-			strcpy (info.driver, DRV_NAME);
-			strcpy (info.version, DRV_VERSION);
-			strcpy (info.bus_info, np->pci_dev->slot_name);
+			sprintf (info.driver, DRV_NAME);
+			sprintf (info.version, DRV_VERSION);
+			sprintf (info.bus_info, np->pci_dev->slot_name);
 			if (copy_to_user (useraddr, &info, sizeof (info)))
 				return -EFAULT;
 			return 0;

--=-u9OITEYJwFkY+ESqYTwA--

