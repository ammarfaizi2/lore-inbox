Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268185AbTBNFjY>; Fri, 14 Feb 2003 00:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268186AbTBNFjY>; Fri, 14 Feb 2003 00:39:24 -0500
Received: from [196.41.29.142] ([196.41.29.142]:17159 "EHLO
	andromeda.cpt.sahara.co.za") by vger.kernel.org with ESMTP
	id <S268185AbTBNFjV>; Fri, 14 Feb 2003 00:39:21 -0500
Subject: Problems with 2.5.*'s SCSI headers and cdrtools
From: Sahara Workshop <workshop@cpt.saharapc.co.za>
To: KML <linux-kernel@vger.kernel.org>
X-scanner: scanned by Sistech VirusWall 2.3/cpt
Content-Type: multipart/mixed; boundary="=-3mUfH5a9Kn/voAL8ONmj"
Organization: 
Message-Id: <1045201685.5971.78.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 14 Feb 2003 07:48:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3mUfH5a9Kn/voAL8ONmj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Kernel 2.5.5x (have not tried earlier) and 2.5.60 's scsi/scsi.h do
not have like in 2.4 the 'include <features.h>', or as it may seem
to need an 'include <types.h>', and thus cdrtools for one do not
compile.

The take I get on this from Jorg is that he feels its a problem
kernel side.  Comments ?

Attached is a patch that get cdrtools-2.01a2 to compile.


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa



-  PLEASE NOTE -

This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager. Please note that any views or opinions presented
in this email are solely those of the author and do not necessarily
represent those of Sahara Distribution (Pty) Ltd. Finally, while Sahara
Distribution attempts to ensure that all email is virus-free, Sahara
Distribution accepts no liability for any damage caused by any virus
transmitted by this email.

Sahara Distribution (PTY) Ltd
Unit G5-G12, Centurion Business Park, Milnerton, Cape Town, South Africa
Private Bag X180, Halfway House, 1685, South Africa

Scanned and protected by Sistech Viruswall 2.3

--=-3mUfH5a9Kn/voAL8ONmj
Content-Disposition: attachment; filename=cdrtools-2.01-kernel25-support.patch
Content-Type: text/plain; name=cdrtools-2.01-kernel25-support.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- cdrtools-2.01/libscg/scsi-linux-sg.c.orig	2003-02-05 21:01:31.000000000 +0200
+++ cdrtools-2.01/libscg/scsi-linux-sg.c	2003-02-05 21:16:33.000000000 +0200
@@ -66,6 +66,11 @@
 #if LINUX_VERSION_CODE >= 0x01031a /* <linux/scsi.h> introduced in 1.3.26 */
 #if LINUX_VERSION_CODE >= 0x020000 /* <scsi/scsi.h> introduced somewhere. */
 /* Need to fine tune the ifdef so we get the transition point right. */
+#if LINUX_VERSION_CODE >= 0x020500 /* 2.5.x breaks things again */
+#define __KERNEL__
+#include <asm/types.h>
+#undef __KERNEL__
+#endif
 #include <scsi/scsi.h>
 #else
 #include <linux/scsi.h>

--=-3mUfH5a9Kn/voAL8ONmj--

