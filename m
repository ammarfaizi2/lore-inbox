Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUKSAIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUKSAIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbUKSAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:05:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261172AbUKSAEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:04:48 -0500
Date: Fri, 19 Nov 2004 01:04:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kai Makisara <kai.makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [patch] 2.6.10-rc2-mm2: `ST_partstat' multiple definition
Message-ID: <20041119000443.GK4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error is still present:

<--  snip  -->

...
  LD      drivers/scsi/built-in.o
drivers/scsi/osst.o(.bss+0x0): multiple definition of `ST_partstat'
drivers/scsi/st.o(.bss+0x0): first defined here
make[2]: *** [drivers/scsi/built-in.o] Error 1

<--  snip  -->


The patch below fixes this issue.


It is also present in 2.6.10-rc2. Please put it therefore on your 
must-go-to-linus-before-2.6.10-or-the-world-will-stop-turning list.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm2-full/drivers/scsi/st.h.old	2004-11-18 22:49:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/st.h	2004-11-18 22:49:48.000000000 +0100
@@ -67,7 +67,7 @@
 	u32 last_block_visited;
 	int drv_block;		/* The block where the drive head is */
 	int drv_file;
-} ST_partstat;
+};
 
 #define ST_NBR_PARTITIONS 4
 

