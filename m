Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270267AbTGMQZG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270269AbTGMQZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:25:06 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:51981 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S270267AbTGMQZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:25:02 -0400
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Input layer demand loading
Date: Sun, 13 Jul 2003 18:39:49 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DA2ZQ7K0FMZ5QXS24FC9"
Message-Id: <200307131839.49112.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DA2ZQ7K0FMZ5QXS24FC9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Why does the input layer still not have on-demand module loading? How abo=
ut=20
applying this?

Fredrik Tolf

--------------Boundary-00=_DA2ZQ7K0FMZ5QXS24FC9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="input.c.patch"
Content-Transfer-Encoding: 7bit
Content-Description: Patch for 2.5.75
Content-Disposition: inline; filename="input.c.patch"

cd /usr/src/linux-2.5.75/drivers/input/
diff -up /usr/src/linux-2.5.75/drivers/input/input.c\~ /usr/src/linux-2.5.75/drivers/input/input.c
--- /usr/src/linux-2.5.75/drivers/input/input.c~	2003-07-13 18:34:09.000000000 +0200
+++ /usr/src/linux-2.5.75/drivers/input/input.c	2003-07-13 18:34:18.000000000 +0200
@@ -531,7 +531,13 @@ static int input_open_file(struct inode 
 	struct file_operations *old_fops, *new_fops = NULL;
 	int err;
 
-	/* No load-on-demand here? */
+	if(!handler)
+	{
+		char name[20];
+		sprintf(name, "input-dev-%i", minor(inode->i_rdev) >> 5);
+		request_module(name);
+		handler = input_table[minor(inode->i_rdev) >> 5];
+	}
 	if (!handler || !(new_fops = fops_get(handler->fops)))
 		return -ENODEV;

--------------Boundary-00=_DA2ZQ7K0FMZ5QXS24FC9--

