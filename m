Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQLNAig>; Wed, 13 Dec 2000 19:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbQLNAi0>; Wed, 13 Dec 2000 19:38:26 -0500
Received: from jalon.able.es ([212.97.163.2]:64506 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129539AbQLNAiU>;
	Wed, 13 Dec 2000 19:38:20 -0500
Date: Thu, 14 Dec 2000 01:07:47 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ver_linux+kgcc
Message-ID: <20001214010747.A859@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In short: scripts/ver_linux can lie about the cc version used to build
kernel. With recent add for the detection of gcc727, kgcc anc cc, kernel
can be compiled with one cc and ver_linux report one other.

This can help people reporting hangs or bugs, because usually give the
output of ver_linux and it usually is wrong about gcc used for kernel.

BTW, I have added the GNU make version info present in 2.4 but not in 2.2.
NOTE: the cc misversioning also happens in 2.4

================== patch-ver_linux
--- linux/scripts/ver_linux.org Thu Dec 14 00:52:16 2000
+++ linux/scripts/ver_linux     Thu Dec 14 01:07:15 2000
@@ -9,7 +9,13 @@
 echo '-- unusual then possibly you have very old versions)'
 uname -a
 insmod -V  2>&1 | awk 'NR==1 {print "Kernel modules        ",$NF}'
-echo "Gnu C                 " `gcc --version`
+echo "Gnu C                 " \
+       `gcc272 --version 2>/dev/null || \
+        kgcc --version 2>/dev/null || \
+        gcc --version 2>/dev/null || \
+        cc --version`
+make --version 2>&1 | awk -F, '{print $1}' | awk \
+      '/GNU Make/{print "Gnu Make              ",$NF}'
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "Binutils              ",$NF}'
 ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed -e 's/\.so$//' \
================== patch-ver_linux
-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
