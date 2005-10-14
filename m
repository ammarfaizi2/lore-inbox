Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVJNPxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJNPxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJNPxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 11:53:13 -0400
Received: from quark.didntduck.org ([69.55.226.66]:5318 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750768AbVJNPxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 11:53:13 -0400
Message-ID: <434FD4BE.8050200@didntduck.org>
Date: Fri, 14 Oct 2005 11:54:38 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Remove orphaned TIOCGDEV compat ioctl
Content-Type: multipart/mixed;
 boundary="------------010400060500040606090301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400060500040606090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This ioctl doesn't exist for native i386.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------010400060500040606090301
Content-Type: text/plain;
 name="Remove-orphaned-TIOCGDEV-compat-ioctl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Remove-orphaned-TIOCGDEV-compat-ioctl.txt"

Subject: [PATCH] Remove orphaned TIOCGDEV compat ioctl

This ioctl doesn't exist for native i386.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 arch/x86_64/ia32/ia32_ioctl.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

applies-to: 91114da2c11350d20a5c5818138f5e0392e13a9f
c79d50d0f19ceae97dfbe56021fd0413ec72e8fe
diff --git a/arch/x86_64/ia32/ia32_ioctl.c b/arch/x86_64/ia32/ia32_ioctl.c
index 0ad5cc3..4ba0e29 100644
--- a/arch/x86_64/ia32/ia32_ioctl.c
+++ b/arch/x86_64/ia32/ia32_ioctl.c
@@ -17,34 +17,6 @@
 #define CODE
 #include "compat_ioctl.c"
   
-#ifndef TIOCGDEV
-#define TIOCGDEV       _IOR('T',0x32, unsigned int)
-#endif
-static int tiocgdev(unsigned fd, unsigned cmd,  unsigned int __user *ptr) 
-{ 
-
-	struct file *file;
-	struct tty_struct *real_tty;
-	int fput_needed, ret;
-
-	file = fget_light(fd, &fput_needed);
-	if (!file)
-		return -EBADF;
-
-	ret = -EINVAL;
-	if (file->f_op->ioctl != tty_ioctl)
-		goto out;
-	real_tty = (struct tty_struct *)file->private_data;
-	if (!real_tty) 	
-		goto out;
-
-	ret = put_user(new_encode_dev(tty_devnum(real_tty)), ptr); 
-
-out:
-	fput_light(file, fput_needed);
-	return ret;
-} 
-
 #define RTC_IRQP_READ32	_IOR('p', 0x0b, unsigned int)	 /* Read IRQ rate   */
 #define RTC_IRQP_SET32	_IOW('p', 0x0c, unsigned int)	 /* Set IRQ rate    */
 #define RTC_EPOCH_READ32	_IOR('p', 0x0d, unsigned)	 /* Read epoch      */
@@ -100,7 +72,6 @@ COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK -
 COMPATIBLE_IOCTL(FIOQSIZE)
 
 /* And these ioctls need translation */
-HANDLE_IOCTL(TIOCGDEV, tiocgdev)
 /* realtime device */
 HANDLE_IOCTL(RTC_IRQP_READ,  rtc32_ioctl)
 HANDLE_IOCTL(RTC_IRQP_READ32,rtc32_ioctl)
---
0.99.8.GIT

--------------010400060500040606090301--
