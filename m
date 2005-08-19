Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbVHSXge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbVHSXge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbVHSXge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:36:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7955 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932750AbVHSXgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:36:33 -0400
Date: Sat, 20 Aug 2005 01:36:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [-mm patch] drivers/cdrom/sbpcd.c: fix the compilation
Message-ID: <20050819233631.GB3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
> +drivers-cdrom-fix-up-schedule_timeout-usage.patch
>...

I sell copies of gcc at reasonable prices...

<--  snip  -->

...
  CC      drivers/cdrom/sbpcd.o
...
drivers/cdrom/sbpcd.c:830: warning: implicit declaration of function 'schedule_interruptible_timeout'
...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `sbp_sleep':sbpcd.c:
(.text+0x7c4592): undefined reference to `schedule_interruptible_timeout'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/drivers/cdrom/sbpcd.c.old	2005-08-19 20:43:18.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/cdrom/sbpcd.c	2005-08-19 20:44:46.000000000 +0200
@@ -827,7 +827,7 @@
 static void sbp_sleep(u_int time)
 {
 	sti();
-	schedule_interruptible_timeout(time);
+	schedule_timeout_interruptible(time);
 	sti();
 }
 /*==========================================================================*/

