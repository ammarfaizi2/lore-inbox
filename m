Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWJQRlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJQRlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWJQRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:41:37 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:62166 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751360AbWJQRlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:41:36 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Date: Tue, 17 Oct 2006 20:41:41 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Me@fokus.fraunhofer.de
References: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
In-Reply-To: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WXRNFqXKZ2zloMJ"
Message-Id: <200610172041.42873.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WXRNFqXKZ2zloMJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

17 Eki 2006 Sal 17:45 tarihinde, Joerg Schilling =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> Hi,
>
> while working on better ISO-9660 support for the Solaris Kernel,
> I recently enhanced mkisofs to support the Rock Ridge Standard version 1.=
12
> from 1994.
>
> The difference bewteen version 1.12 and 1.10 (this is what previous
> mkisofs versions did implement) is that the "PX" field is now 8 Byte
> bigger than before (44 instead of 36 bytes).

Is there a test iso file somewhere? I think the attached *untested* patch w=
ill=20
fix it.

Regards,
ismail

--Boundary-00=_WXRNFqXKZ2zloMJ
Content-Type: text/x-diff;
  charset="utf-8";
  name="rock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rock.patch"

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index f3a1db3..061a633 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -349,6 +349,7 @@ #endif
 			inode->i_nlink = isonum_733(rr->u.PX.n_links);
 			inode->i_uid = isonum_733(rr->u.PX.uid);
 			inode->i_gid = isonum_733(rr->u.PX.gid);
+                       inode->i_ino = isonum_733(rr->u.PX.ino);
 			break;
 		case SIG('P', 'N'):
 			{
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ed09e2b..faf92c6 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -33,6 +33,7 @@ struct RR_PX_s {
 	char n_links[8];
 	char uid[8];
 	char gid[8];
+       char ino[8];
 };
 
 struct RR_PN_s {

--Boundary-00=_WXRNFqXKZ2zloMJ--
