Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbTGLOfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbTGLOfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:35:31 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:2038 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265804AbTGLOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:35:29 -0400
Subject: [PATCH] nbd.c compile warning
From: Shane Shrybman <shrybman@sympatico.ca>
To: Paul.Clements@steeleye.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-01UwrnkujYbdcuipc4nm"
Organization: 
Message-Id: <1058021412.10870.13.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2003 10:50:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-01UwrnkujYbdcuipc4nm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch to fix a compile warning from nbd.c. It has been compile
tested, ( I don't actually use nbd, yet). I have included the patch as
an attachment in case it gets mangled.

--- linux-2.5.75-mm1/drivers/block/nbd.c.orig   Sat Jul 12 09:23:45 2003
+++ linux-2.5.75-mm1/drivers/block/nbd.c        Sat Jul 12 09:45:06 2003
@@ -261,7 +261,7 @@
        dprintk(DBG_TX, "%s: request %p: sending control
(%s@%llu,%luB)\n",
                        lo->disk->disk_name, req,
                        nbdcmd_to_ascii(nbd_cmd(req)),
-                       req->sector << 9, req->nr_sectors << 9);
+                       (unsigned long long)req->sector << 9,
req->nr_sectors << 9);
        result = sock_xmit(sock, 1, &request, sizeof(request),
                        (nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
        if (result <= 0) {


Regards,

shane

--=-01UwrnkujYbdcuipc4nm
Content-Disposition: attachment; filename=nbd.compile.warning.diff
Content-Type: text/x-diff; name=nbd.compile.warning.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.75-mm1/drivers/block/nbd.c.orig	Sat Jul 12 09:23:45 2003
+++ linux-2.5.75-mm1/drivers/block/nbd.c	Sat Jul 12 09:45:06 2003
@@ -261,7 +261,7 @@
 	dprintk(DBG_TX, "%s: request %p: sending control (%s@%llu,%luB)\n",
 			lo->disk->disk_name, req,
 			nbdcmd_to_ascii(nbd_cmd(req)),
-			req->sector << 9, req->nr_sectors << 9);
+			(unsigned long long)req->sector << 9, req->nr_sectors << 9);
 	result = sock_xmit(sock, 1, &request, sizeof(request),
 			(nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
 	if (result <= 0) {

--=-01UwrnkujYbdcuipc4nm--

