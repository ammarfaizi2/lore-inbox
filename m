Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTLWDKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTLWDKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:10:49 -0500
Received: from smtp.everyone.net ([216.200.145.17]:29007 "EHLO
	rmta01.mta.everyone.net") by vger.kernel.org with ESMTP
	id S264905AbTLWDKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:10:47 -0500
Date: Mon, 22 Dec 2003 22:09:59 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb_maven module OOPS on insmod
Message-ID: <20031223030959.GA3038@arizona.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When running the following commands:

/sbin/modprobe i2c-algo-bit
/sbin/modprobe i2c-matroxfb
/sbin/modprobe matroxfb_maven

the 2.6.0 kernel will reliably oops.  The problem is a result of calling
device_add with uninitialized data.  The following patch allows the module
to be inserted.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=matrox_diff

--- gold-2.6/drivers/video/matrox/matroxfb_maven.c	2003-10-25 14:42:44.000000000 -0400
+++ linux-2.6.0/drivers/video/matrox/matroxfb_maven.c	2003-12-22 21:55:04.082725504 -0500
@@ -1249,6 +1249,7 @@
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
 	data = (struct maven_data*)(new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;

--Q68bSM7Ycu6FN28Q--
