Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbTJFNYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJFNYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:24:47 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:32731 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262054AbTJFNYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:24:46 -0400
Message-ID: <3F816DE5.8060009@terra.com.br>
Date: Mon, 06 Oct 2003 10:28:05 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cciss-discuss@lists.sourceforge.net
Subject: [PATCH] release_region in cciss block driver
Content-Type: multipart/mixed;
 boundary="------------090809000708010909050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090809000708010909050602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

	Patch against 2.6.0-test6.

	Release a previous requested region if we're about the fail the board 
initialization. Found by smatch.

	Please review and consider applying,

	Thanks.

Felipe

--------------090809000708010909050602
Content-Type: text/plain;
 name="cciss-region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss-region.patch"

--- linux-2.6.0-test6/drivers/block/cciss.c.orig	2003-10-06 10:18:01.000000000 -0300
+++ linux-2.6.0-test6/drivers/block/cciss.c	2003-10-06 10:25:04.000000000 -0300
@@ -2185,6 +2185,7 @@
 		schedule_timeout(HZ / 10); /* wait 100ms */
 	}
 	if (scratchpad != CCISS_FIRMWARE_READY) {
+		release_io_mem (c);
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
 		return -1;
 	}

--------------090809000708010909050602--

