Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280845AbRKYM0M>; Sun, 25 Nov 2001 07:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280843AbRKYM0D>; Sun, 25 Nov 2001 07:26:03 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:39387 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280845AbRKYMZw>; Sun, 25 Nov 2001 07:25:52 -0500
Subject: Re: PATCH: gcc3.0.2 workaround for 8139too
From: Ali Akcaagac <ali.akcaagac@stud.fh-wilhelmshaven.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1006394515.14661.0.camel@ulixys>
In-Reply-To: <1006394515.14661.0.camel@ulixys>
Content-Type: multipart/mixed; boundary="=-cOHSuLrd+jMfQpGe64he"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 13:25:24 +0100
Message-Id: <1006691124.320.0.camel@ulixys>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cOHSuLrd+jMfQpGe64he
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2001-11-22 at 03:01, Ali Akcaagac wrote:
> so please allow me to post this 'temporarely workaround' here so other
> people can profit of it until things with the gcc3.0.2 compiler are
> solved.

hello,

i've got quite a lot of response for this. oki, the problem is still
there and still no solution. somehow i was forced to do minor changes to
the previous *workaround*. at least to save myself from beeing bombed
again :) and save whoever uses this stuff, from getting complications,
please allow me to post this one.

reason: probably gcc3.0.2 bug
kernel: 2.4.10 -> X
result: solves some strange compile failure issues.

-- 
Name....: Ali Akcaagac
Status..: Student Of Computer & Economic Science
E-Mail..: mailto:ali.akcaagac@stud.fh-wilhelmshaven.de
WWW.....: http://www.fh-wilhelmshaven.de/~akcaagaa

--=-cOHSuLrd+jMfQpGe64he
Content-Disposition: attachment; filename=8139too.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ANSI_X3.4-1968

--- linux/drivers/net/8139too.c.bak	Tue Nov 20 22:39:30 2001
+++ linux/drivers/net/8139too.c	Sun Nov 25 11:56:49 2001
@@ -2393,9 +2393,9 @@
 	case ETHTOOL_GDRVINFO:
 		{
 			struct ethtool_drvinfo info =3D { ETHTOOL_GDRVINFO };
-			strcpy (info.driver, DRV_NAME);
-			strcpy (info.version, DRV_VERSION);
-			strcpy (info.bus_info, np->pci_dev->slot_name);
+			sprintf (info.driver, "%s", DRV_NAME);
+			sprintf (info.version, "%s", DRV_VERSION);
+			sprintf (info.bus_info, "%s", np->pci_dev->slot_name);
 			if (copy_to_user (useraddr, &info, sizeof (info)))
 				return -EFAULT;
 			return 0;

--=-cOHSuLrd+jMfQpGe64he--

