Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTJDSxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTJDSxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:53:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:53981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262691AbTJDSxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:53:19 -0400
Date: Sat, 4 Oct 2003 11:54:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Georg Chini <georg.chini@triaton-webhosting.com>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Sparc32 - sched_clock missing
Message-Id: <20031004115455.42d8263e.akpm@osdl.org>
In-Reply-To: <3F7ED071.7080005@triaton-webhosting.com>
References: <3F7ED071.7080005@triaton-webhosting.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Chini <georg.chini@triaton-webhosting.com> wrote:
>
> Hello out there,
> 
> tried to build Kernel 2.6.0-test6-bk4 on my
> sparc32 machine and found that the function
> sched_clock is missing in time.c. Can anyone
> tell me what I have to put there? Please CC
> to me.
> 

This is the minimal version to get you going.

A better implementation would use a higer-resolution counter, if the
hardware has such a thing.


diff -puN arch/sparc/kernel/time.c~sparc32-sched_clock arch/sparc/kernel/time.c
--- 25/arch/sparc/kernel/time.c~sparc32-sched_clock	2003-10-04 11:53:19.000000000 -0700
+++ 25-akpm/arch/sparc/kernel/time.c	2003-10-04 11:53:41.000000000 -0700
@@ -617,3 +617,12 @@ static int set_rtc_mmss(unsigned long no
 		return -1;
 	}
 }
+
+/*
+ * Returns nanoseconds
+  */
+
+unsigned long long sched_clock(void)
+{
+	return (unsigned long long)jiffies * (1000000000 / HZ);
+}

_

