Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSHBUkS>; Fri, 2 Aug 2002 16:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSHBUkR>; Fri, 2 Aug 2002 16:40:17 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:28894 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316912AbSHBUkR>; Fri, 2 Aug 2002 16:40:17 -0400
Date: Fri, 2 Aug 2002 16:45:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30-dj1 (sort of)
Message-ID: <20020802204546.GA21575@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Schmielau posted this bit.  2.5.30-dj1 wants it.

--- linux-2.5.25-dj2/include/linux/times.h      Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-dj2-jfix/include/linux/times.h Sat Jul 13 09:06:05 2002
@@ -2,7 +2,22 @@
 #define _LINUX_TIMES_H

 #ifdef __KERNEL__
+#include <asm/div64.h>
+#include <asm/types.h>
+
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+/*
+ * returning a different type than the function name says is
+ * ugly as hell, and only intended to stay until I know what type
+ * should replace clock_t
+ */
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+       do_div(x, HZ / USER_HZ);
+       return x;
+}
 #endif

 struct tms {

> Chances are this won't even boot for many people (if any at all).
> There's something nasty in my tree right now which makes it
> fail to find init(1).  

Maybe someone will post a patch for that while you are on holiday :)

VFS: Cannot open root device "1602" or 16:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 16:02

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

