Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266780AbUFYPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUFYPmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266776AbUFYPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:41:33 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:35304 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S264821AbUFYPlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:41:25 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF3532151078@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Date: Fri, 25 Jun 2004 10:41:13 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C45ACA.D8836161"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C45ACA.D8836161
Content-Type: text/plain;
	charset="iso-8859-1"

I see that shm_tot (the total number of pages in shm segments) in
ipc/shm.c is defined as int, even though its max value (shmall) is size_t.

Admittedly, it only matters for systems with >8TB memory, but shouldn't
shm_tot also be size_t?  The attached patch makes it so.


------_=_NextPart_000_01C45ACA.D8836161
Content-Type: application/octet-stream;
	name="shmtot64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="shmtot64.patch"

diff -ruN linux-2.6.7-orig/ipc/shm.c linux-2.6.7/ipc/shm.c=0A=
--- linux-2.6.7-orig/ipc/shm.c	2004-06-16 01:19:23.000000000 -0400=0A=
+++ linux-2.6.7/ipc/shm.c	2004-06-25 11:25:29.223483880 -0400=0A=
@@ -54,7 +54,7 @@=0A=
 size_t 	shm_ctlall =3D SHMALL;=0A=
 int 	shm_ctlmni =3D SHMMNI;=0A=
 =0A=
-static int shm_tot; /* total number of shared memory pages */=0A=
+static size_t shm_tot; /* total number of shared memory pages */=0A=
 =0A=
 void __init shm_init (void)=0A=
 {=0A=

------_=_NextPart_000_01C45ACA.D8836161--
