Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbUKRTNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUKRTNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUKRTLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:11:30 -0500
Received: from siaar1aa.compuserve.com ([149.174.40.9]:36721 "EHLO
	siaar1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262906AbUKRTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:09:59 -0500
Message-ID: <419CF37C.7050000@compuserve.com>
Date: Thu, 18 Nov 2004 11:09:48 -0800
From: Bryan Batten <BryanBatten@compuserve.com>
Reply-To: BryanBatten@compuserve.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Rich Liu <richliu@poorman.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH]-2.6.10-rc2: Fix Compiler Warning parport_pc.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After patching up to 2.6.10-rc2, I get the following compiler warning
when building the kernel with gcc 2.95:

drivers/parport/parport_pc.c:3317: warning: initialization from incompatible pointer type

The warning occurs because parport_init_mode_setup() wants 'char *'
instead of 'const char *'.

The fix is to just remove the 'const' from the declaration.

Here's the patch to drivers/parport/parport_pc.c:
--------------------------------snip-snip-----------------------------
# diff -up *orig/drivers/parport/parport_pc.c *6x/drivers/parport
--- linux-2.6.9orig/drivers/parport/parport_pc.c        Mon Nov 15 22:44:11 2004
+++ linux-2.6x/drivers/parport/parport_pc.c     Wed Nov 17 22:35:37 2004
@@ -3154,7 +3154,7 @@ static int __init parport_parse_dma(cons
                                      PARPORT_DMA_NONE, PARPORT_DMA_NOFIFO);
  }

-static int __init parport_init_mode_setup(const char *str) {
+static int __init parport_init_mode_setup(char *str) {

         printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);

------------------------------end-snip-snip---------------------------

(Signed-off-by: Bryan Batten <BryanBatten@compuserve.com>)






