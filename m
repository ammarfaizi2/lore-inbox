Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbUKXNBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUKXNBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUKXNBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:01:51 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33684 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262641AbUKXNA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:58 -0500
Subject: Suspend 2 merge: 7/51: Reboot handler hook.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101293507.5805.212.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice and simple.

We override swsusp's hook with the suspend2 one. It's not that I want to
step on Pavel's toes. Rather, people who go to the trouble of applying
suspend2, probably want to use it :>


diff -ruN 300-reboot-handler-hook-old/kernel/sys.c 300-reboot-handler-hook-new/kernel/sys.c
--- 300-reboot-handler-hook-old/kernel/sys.c	2004-11-03 21:51:17.000000000 +1100
+++ 300-reboot-handler-hook-new/kernel/sys.c	2004-11-06 09:23:26.887002384 +1100
@@ -502,10 +502,14 @@
 		machine_restart(buffer);
 		break;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SOFTWARE_SUSPEND2
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret = software_suspend();
+			int ret = -EINVAL;
+			if (!(test_suspend_state(SUSPEND_DISABLED))) {
+				suspend_try_suspend();
+				ret = 0;
+			}
 			unlock_kernel();
 			return ret;
 		}


