Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVGGRGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVGGRGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVGGRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:06:54 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:55987 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S261375AbVGGRGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:06:54 -0400
Message-Id: <6.2.3.4.2.20050707115455.02e7a530@ipostoffice.worldnet.att.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Thu, 07 Jul 2005 12:06:48 -0500
To: linux-kernel@vger.kernel.org
From: "Larry W. Finger" <Larry.Finger@lwfinger.net>
Subject: Compiler warning when building 2.6.13-rc2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This report describes a trivial warning that arises when compiling 
kernel 2.6.13-rc2. In routine yenta_allocate_res of yenta_socket.c, 
the void function tries to return a 0. The following patch removes the problem:

--- linux-2.6.13-rc2/drivers/pcmcia/yenta_socket.c_old	2005-07-06 
15:41:41.000000000 -0500
+++ linux-2.6.13-rc2/drivers/pcmcia/yenta_socket.c	2005-07-06 
15:42:04.000000000 -0500
@@ -552,7 +552,7 @@
  	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
  	/* Already allocated? */
  	if (res->parent)
-		return 0;
+		return;

  	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
  	mask = ~0xfff;

Thanks, Larry

