Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTEVRHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTEVRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:07:42 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:22278 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262930AbTEVRHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:07:41 -0400
Subject: [PATCH] 2/2 Add exposure of the irq delivery mask on x86 [voyager
	piece]
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, wli@holomorphy.com
Content-Type: multipart/mixed; boundary="=-0OjIIKkTAuG3I56dEyYg"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 May 2003 13:20:45 -0400
Message-Id: <1053624045.1798.227.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0OjIIKkTAuG3I56dEyYg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This makes voyager use the mask exposed by the previous patch to reflect
the CPU's which can receive interrupts

James


--=-0OjIIKkTAuG3I56dEyYg
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1210  -> 1.1211=20
#	arch/i386/mach-voyager/voyager_cat.c	1.1     -> 1.2   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/22	jejb@oldfenric.sc.steeleye.com	1.1211
# Add voyager support for exposing interrupt delivery masks
# --------------------------------------------
#
diff -Nru a/arch/i386/mach-voyager/voyager_cat.c b/arch/i386/mach-voyager/v=
oyager_cat.c
--- a/arch/i386/mach-voyager/voyager_cat.c	Thu May 22 13:19:05 2003
+++ b/arch/i386/mach-voyager/voyager_cat.c	Thu May 22 13:19:05 2003
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <asm/io.h>
=20
 #ifdef VOYAGER_CAT_DEBUG
@@ -899,6 +900,9 @@
 	request_resource(&ioport_resource, &vic_res);
 	if(voyager_quad_processors)
 		request_resource(&ioport_resource, &qic_res);
+	/* mark the interrupt accepting cpu's in the mask */
+	for(i=3D0; i<NR_IRQS; i++)
+		irq_mask[i] =3D voyager_extended_vic_processors;
 	/* set up the front power switch */
 }
=20

--=-0OjIIKkTAuG3I56dEyYg--

