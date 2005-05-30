Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVE3TvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVE3TvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVE3TvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:51:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261721AbVE3Tum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:50:42 -0400
Date: Mon, 30 May 2005 21:50:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/message/i2o/device.c: i2o_parm_issue has to be global
Message-ID: <20050530195037.GM10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:49:33PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc4-mm2:
>...
> +i2o-first-code-cleanup-of-spare-warnings-and-unused.patch
>...
>  i2o driver updates
>...


This patch makes i2o_parm_issue static resulting in the following 
compile error in the static case (the modular case doesn't give a 
compile error, but EXPORT_SYMBOL'ing a static functions is equally 
wrong):

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x691d55): In function `i2o_cfg_parms':
: undefined reference to `i2o_parm_issue'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


This patch turns i2o_parm_issue back into a global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc5-mm1-full/drivers/message/i2o/device.c.old	2005-05-30 21:17:10.000000000 +0200
+++ linux-2.6.12-rc5-mm1-full/drivers/message/i2o/device.c	2005-05-30 21:17:21.000000000 +0200
@@ -443,8 +443,8 @@
  *	Note that the minimum sized reslist is 8 bytes and contains
  *	ResultCount, ErrorInfoSize, BlockStatus and BlockSize.
  */
-static int i2o_parm_issue(struct i2o_device *i2o_dev, int cmd, void *oplist,
-			  int oplen, void *reslist, int reslen)
+int i2o_parm_issue(struct i2o_device *i2o_dev, int cmd, void *oplist,
+		   int oplen, void *reslist, int reslen)
 {
 	struct i2o_message __iomem *msg;
 	u32 m;

