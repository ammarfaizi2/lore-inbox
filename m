Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282181AbRK1Xnd>; Wed, 28 Nov 2001 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282199AbRK1XnG>; Wed, 28 Nov 2001 18:43:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11205 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282181AbRK1Xm5>;
	Wed, 28 Nov 2001 18:42:57 -0500
Message-ID: <3C05767F.7050304@us.ibm.com>
Date: Wed, 28 Nov 2001 15:42:55 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <200111282305.fASN5ap02626@localhost.localdomain> <3C057358.95C181A5@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"David C. Hansen" wrote:
>
>>+static spinlock_t              user_list_lock;
>>= SPIN_LOCK_UNLOCKED;
>>
Whoops.   Here's another patch to throw on top of the first one.

--- linux-2.5.1-pre2-dirty/arch/i386/kernel/apm.c    Wed Nov 28 15:37:59 
2001
+++ linux/arch/i386/kernelapm.c    Wed Nov 28 15:37:41 2001
@@ -387,7 +387,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *    user_list;
+static spinlock_t        user_list_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t        user_list_lock;
 
 static char            driver_version[] = "1.15";    /* no spaces */
 


