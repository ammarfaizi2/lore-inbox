Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTEODYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTEODW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:59 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:20972 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263806AbTEODSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:25 -0400
Date: Thu, 15 May 2003 04:31:12 +0100
Message-Id: <200305150331.h4F3VCSB000695@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: copy_to_user check for sgiserial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/sgi/char/sgiserial.c linux-2.5/drivers/sgi/char/sgiserial.c
--- bk-linus/drivers/sgi/char/sgiserial.c	2003-05-08 13:46:22.000000000 +0100
+++ linux-2.5/drivers/sgi/char/sgiserial.c	2003-05-08 14:26:46.000000000 +0100
@@ -1232,7 +1233,7 @@ static int get_serial_info(struct sgi_se
 	tmp.close_delay = info->close_delay;
 	tmp.closing_wait = info->closing_wait;
 	tmp.custom_divisor = info->custom_divisor;
-	return copy_to_user(retinfo,&tmp,sizeof(*retinfo));
+	return copy_to_user(retinfo,&tmp,sizeof(*retinfo)) ? -EFAULT : 0;
 }
 
 static int set_serial_info(struct sgi_serial * info,
