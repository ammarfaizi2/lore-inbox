Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGUWsu>; Sun, 21 Jul 2002 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSGUWst>; Sun, 21 Jul 2002 18:48:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53515 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314546AbSGUWst>; Sun, 21 Jul 2002 18:48:49 -0400
Date: Sun, 21 Jul 2002 23:51:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Alan says this needs fixing... (timer/cpu_relax)
Message-ID: <20020721235154.M26376@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at some stuff, I noticed the following.  Alan confirmed
that this patch is probably a good idea...

--- orig/kernel/timer.c	Sun Jul  7 23:21:28 2002
+++ linux/kernel/timer.c	Sun Jul 21 23:50:17 2002
@@ -176,7 +176,7 @@
 #define timer_enter(t) do { running_timer = t; mb(); } while (0)
 #define timer_exit() do { running_timer = NULL; } while (0)
 #define timer_is_running(t) (running_timer == t)
-#define timer_synchronize(t) while (timer_is_running(t)) barrier()
+#define timer_synchronize(t) while (timer_is_running(t)) cpu_relax()
 #else
 #define timer_enter(t)		do { } while (0)
 #define timer_exit()		do { } while (0)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

