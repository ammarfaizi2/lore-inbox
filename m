Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBOM17>; Thu, 15 Feb 2001 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBOM1t>; Thu, 15 Feb 2001 07:27:49 -0500
Received: from saraksh.alkar.net ([195.248.191.65]:31243 "EHLO smtp3.alkar.net")
	by vger.kernel.org with ESMTP id <S129080AbRBOM1h>;
	Thu, 15 Feb 2001 07:27:37 -0500
Message-ID: <3A8BCA93.A578E20@namesys.botik.ru>
Date: Thu, 15 Feb 2001 15:24:51 +0300
From: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: typo in 2.4.1/fs/dquot.c
Content-Type: multipart/mixed;
 boundary="------------E658EBB7E1C22F070581AF97"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E658EBB7E1C22F070581AF97
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Hi

The attached is a fix for typo in 2.4.1/fs/dquot.c. It is not fixed yet
in 2.4.2pre3.
This typo causes quotactl (Q_GETQUOTA & GRPQUOTA, ..) to return EPERM.

Jan Kara (jack@suse.cz) confirmed that this is really a typo and that
the fix is a right one.

Thanks,
vs


--------------E658EBB7E1C22F070581AF97
Content-Type: text/plain; charset=koi8-r;
 name="dquot.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dquot.c.patch"

--- dquot.c.orig	Wed Feb 14 04:08:26 2001
+++ dquot.c	Wed Feb 14 04:09:00 2001
@@ -1536,7 +1536,7 @@
 			break;
 		case Q_GETQUOTA:
 			if (((type == USRQUOTA && current->euid != id) ||
-			     (type == GRPQUOTA && in_egroup_p(id))) &&
+			     (type == GRPQUOTA && !in_egroup_p(id))) &&
 			    !capable(CAP_SYS_RESOURCE))
 				goto out;
 			break;

--------------E658EBB7E1C22F070581AF97--

