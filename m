Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPTnc>; Thu, 16 Nov 2000 14:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKPTnW>; Thu, 16 Nov 2000 14:43:22 -0500
Received: from nas1-8.kmp.club-internet.fr ([213.44.17.8]:38909 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S130406AbQKPTnI>;
	Thu, 16 Nov 2000 14:43:08 -0500
Message-Id: <200011161908.UAA08671@microsoft.com>
Subject: [PATCH] Re: Local root exploit with kmod and modutils > 2.1.121
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200011161856.VAA03745@ms2.inr.ac.ru>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 16 Nov 2000 18:08:35 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

as modprobe (insmod) seems to have POSIX args handling, we should perhaps add "--"
to the modprobe cmdline, in order to stop further args processing, and to avoid
mixing a textual argument with an option.
BTW, it should perhaps be generalized.

Xav


--- linux-2.4-test10/kernel/kmod.c	Tue Sep 26 01:18:55 2000
+++ linux/kernel/kmod.c	Thu Nov 16 19:57:45 2000
@@ -133,7 +133,7 @@
 static int exec_modprobe(void * module_name)
 {
 	static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { modprobe_path, "-s", "-k", (char*)module_name, NULL };
+	char *argv[] = { modprobe_path, "-s", "-k", "--", (char*)module_name, NULL };
 	int ret;
 
 	ret = exec_usermodehelper(modprobe_path, argv, envp);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
