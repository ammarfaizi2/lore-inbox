Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSHTWn1>; Tue, 20 Aug 2002 18:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSHTWn1>; Tue, 20 Aug 2002 18:43:27 -0400
Received: from mail2.fw-bc.sony.com ([160.33.98.69]:62983 "EHLO
	mail2.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id <S317471AbSHTWn0>; Tue, 20 Aug 2002 18:43:26 -0400
Message-ID: <3D62C6DD.9000306@itvd.sel.sony.com>
Date: Tue, 20 Aug 2002 15:46:53 -0700
From: Alex Pelts <alexp@itvd.sel.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alexp@itvd.sel.sony.com
Subject: mtdblock with gcc 2.95.4 patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After installing new debian stable with gcc 2.95.4, kernel 2.4.17 
stopped linking. The error is "undefined reference to local symbols...". 
Problem seems to appear in different parts of the kernel at some time or 
another. This is patch against 2.4.17 that I am using at this time. This 
patch should apply to 2.4.18 and 2.4.19 as well. There seems to be 
something tricky about __exit macro and 2.95.4 compiler.
For people getting error:
drivers/mtd/mtdlink.o(.text.lock+0x26c): undefined reference to `local 
symbols in discarded section .text.exit'

here is the patch that seems to fix it.
Thanks,
Alex

--- linux/drivers/mtd/mtdblock.c	Thu Oct 25 13:58:35 2001
+++ linux-2.4.17/drivers/mtd/mtdblock.c	Tue Aug 20 14:13:38 2002
@@ -641,7 +641,7 @@
  	return 0;
  }

-static void __exit cleanup_mtdblock(void)
+static void __devexit cleanup_mtdblock(void)
  {
  	leaving = 1;
  	wake_up(&thr_wq);

