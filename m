Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271837AbTGRPGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271805AbTGRPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:04:46 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:34178 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S271822AbTGROgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:36:50 -0400
Message-ID: <3F180981.8040508@comcast.net>
Date: Fri, 18 Jul 2003 07:51:45 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdcraid and weird IDE geometry
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060305000405040409090507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305000405040409090507
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just to finish this thread. In case anyone else has similar problems of
only detecting 1 drive of their array and you suspect strange geometry
is at play, here's the simple patch I used in the end which WFM :)

-Walt



--------------060305000405040409090507
Content-Type: text/plain;
 name="pdcraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21/drivers/ide/raid/pdcraid.c	2003-06-13 07:51:34.000000000 -0700
+++ pdcraid.c	2003-07-18 06:54:25.000000000 -0700
@@ -361,7 +361,8 @@
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+/*	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
 	lba = lba * (ideinfo->head*ideinfo->sect);
-	lba = lba - ideinfo->sect;
+	lba = lba - ideinfo->sect; */
+	lba = ideinfo->capacity - ideinfo->sect;
 
 	return lba;

--------------060305000405040409090507--

