Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269716AbTGJXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269717AbTGJXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:38:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37304 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269716AbTGJXiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:38:24 -0400
Message-ID: <3F0DFAB6.4010504@us.ibm.com>
Date: Thu, 10 Jul 2003 16:45:58 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [trivial][patch] no more warnings [2/3] pointer comparison in ide-lib.c
Content-Type: multipart/mixed;
 boundary="------------000804020701060301070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804020701060301070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There's a warning in drivers/ide/ide-lib.c for comparing pointers of 
different types.  This just casts one of the arguments to u8 to shut up 
the compiler.

Cheers!

-Matt

--------------000804020701060301070403
Content-Type: text/plain;
 name="ide_lib-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_lib-warning.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.5.74-vanilla/drivers/ide/ide-lib.c linux-2.5.74-warnings/drivers/ide/ide-lib.c
--- linux-2.5.74-vanilla/drivers/ide/ide-lib.c	Wed Jul  2 13:57:08 2003
+++ linux-2.5.74-warnings/drivers/ide/ide-lib.c	Thu Jul 10 14:44:12 2003
@@ -170,7 +170,7 @@ u8 ide_rate_filter (u8 mode, u8 speed) 
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 

--------------000804020701060301070403--

