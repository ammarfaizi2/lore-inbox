Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289466AbSAKDj3>; Thu, 10 Jan 2002 22:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289470AbSAKDjQ>; Thu, 10 Jan 2002 22:39:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:30477 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289466AbSAKDjF>;
	Thu, 10 Jan 2002 22:39:05 -0500
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Ed Tomlinson <tomlins@cam.org>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201101910260.1493-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201101910260.1493-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 22:41:36 -0500
Message-Id: <1010720496.814.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 22:11, Davide Libenzi wrote:

> Move init_idle() before the first call to kernel_thread().
> This should fix it.

On 2.4.17-pre3, UP, with -H5, the following patch failed to fix the
problem -- still hardlock on "Starting kswapd".  I still suspect the
problem is with the init_idle changes, though ...

--- linux-2.4.18-pre3-ingo/init/main.c	Thu Jan 10 21:13:12 2002
+++ linux/init/main.c	Thu Jan 10 22:33:46 2002
@@ -590,14 +590,14 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
+	smp_init();
+	init_idle();
 	kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	/* 
 	 *	We count on the initial thread going ok 
 	 *	Like idlers init is an unlocked kernel thread, which will
 	 *	make syscalls (and thus be locked).
 	 */
-	smp_init();
-	init_idle();
 	unlock_kernel();
 	printk("All processors have done init_idle\n");

	Robert Love

