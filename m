Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTIVPwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTIVPwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:52:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36240 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263205AbTIVPwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:52:00 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 2/6: Drop extra table ref-count
Date: Mon, 22 Sep 2003 10:51:46 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221051.46661.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple load ioctls are issued the reference count on older
'new_tables' wasn't being dropped.  [Christophe Saout]

--- diff/drivers/md/dm-ioctl-v4.c	2003-09-17 12:28:06.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-09-17 13:08:53.000000000 +0100
@@ -817,6 +817,8 @@
 		return -ENXIO;
 	}
 
+	if (hc->new_map)
+		dm_table_put(hc->new_map);
 	hc->new_map = t;
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
 

