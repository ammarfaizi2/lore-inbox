Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRBTTQJ>; Tue, 20 Feb 2001 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130413AbRBTTQA>; Tue, 20 Feb 2001 14:16:00 -0500
Received: from [199.239.160.155] ([199.239.160.155]:8197 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130337AbRBTTPr>; Tue, 20 Feb 2001 14:15:47 -0500
Date: Tue, 20 Feb 2001 11:15:42 -0800
From: Robert Read <rread@datarithm.net>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/printk.c: increasing the buffer size to capture devfsd debug messages.
Message-ID: <20010220111542.A4106@tenchi.datarithm.net>
Mail-Followup-To: Ishikawa <ishikawa@yk.rim.or.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp>; from ishikawa@yk.rim.or.jp on Wed, Feb 21, 2001 at 02:30:08AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 02:30:08AM +0900, Ishikawa wrote:
> 
> Has anyone tried 128K buffer size in kernel/printk.c
> and still have the kernel boot (without
> hard to notice memory corruption problems  and other subtle bugs)?
> Any hints and tips will be appreciated.

I have used 128k and larger buffer sizes, and I just noticed this
fragment in the RedHat Tux Webserver patch.  It creates a 2MB buffer:

--- linux/kernel/printk.c.orig  Sun Jan 28 20:24:13 2001
+++ linux/kernel/printk.c       Wed Jan 31 23:21:25 2001
@@ -22,7 +22,11 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN    (16384)
+#if CONFIG_TUX_DEBUG
+# define LOG_BUF_LEN   (16384*128)
+#else
+# define LOG_BUF_LEN   (16384)
+#endif
 #define LOG_BUF_MASK   (LOG_BUF_LEN-1)
 
 static char buf[1024];                                                                            

