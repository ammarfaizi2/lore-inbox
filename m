Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKPV5T>; Thu, 16 Nov 2000 16:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQKPV5I>; Thu, 16 Nov 2000 16:57:08 -0500
Received: from nas1-6.kmp.club-internet.fr ([213.44.17.6]:35822 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129178AbQKPV5A>;
	Thu, 16 Nov 2000 16:57:00 -0500
Date: Thu, 16 Nov 2000 22:21:52 +0100
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Local root exploit with kmod and modutils > 2.1.121
Message-ID: <20001116222152.E8326@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as modprobe (insmod) args parsing seems POSIX compliant, we should put a
"--" before
what should be interpreted only as a textual argument, not as an option.
This is a lot safer: whatever is passed, modprobe will take it as a module
name.

--- linux-2.4.0-test10/kernel/kmod.c    Tue Sep 26 01:18:55 2000
+++ linux/kernel/kmod.c Thu Nov 16 19:57:45 2000
@@ -133,7 +133,7 @@
 static int exec_modprobe(void * module_name)
 {
        static char * envp[] = { "HOME=/", "TERM=linux",
"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-       char *argv[] = { modprobe_path, "-s", "-k", (char*)module_name,
NULL };
+       char *argv[] = { modprobe_path, "-s", "-k", "--",
(char*)module_name, NULL };
        int ret;

        ret = exec_usermodehelper(modprobe_path, argv, envp);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
