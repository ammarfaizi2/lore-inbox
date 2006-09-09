Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWIILZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWIILZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIILZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:25:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751319AbWIILZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:25:37 -0400
Subject: [PATCH] [2/6] Remove <asm/timex.h> from user export
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:24:55 +0100
Message-Id: <1157801095.2977.48.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's useful stuff in <linux/timex.h> but <asm/timex.h> has nothing
for userspace. Stop exporting it, and include it only from within the
existing #ifdef __KERNEL__ part of <linux/timex.h>

This fixes a 'make headers_check' failure on i386 because
asm-i386/timex.h includes both asm-i386/tsc.h and asm-i386/processor.h,
neither of which are exported to userspace. It's not entirely clear
_why_ it includes either of these, but it does.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index 6b16dda..c00de60 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -2,7 +2,7 @@ unifdef-y += a.out.h auxvec.h byteorder.
 	ioctls.h ipcbuf.h mman.h msgbuf.h param.h poll.h		\
 	posix_types.h ptrace.h resource.h sembuf.h shmbuf.h shmparam.h	\
 	sigcontext.h siginfo.h signal.h socket.h sockios.h stat.h	\
-	statfs.h termbits.h termios.h timex.h types.h unistd.h user.h
+	statfs.h termbits.h termios.h types.h unistd.h user.h
 
 # These probably shouldn't be exported
 unifdef-y += elf.h page.h
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 19bb653..d543d38 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -57,7 +57,6 @@ #include <linux/compiler.h>
 #include <linux/time.h>
 
 #include <asm/param.h>
-#include <asm/timex.h>
 
 /*
  * SHIFT_KG and SHIFT_KF establish the damping of the PLL and are chosen
@@ -191,6 +190,8 @@ #define TIME_ERROR	5	/* clock not synchr
 #define TIME_BAD	TIME_ERROR /* bw compat */
 
 #ifdef __KERNEL__
+#include <asm/timex.h>
+
 /*
  * kernel variables
  * Note: maximum error = NTP synch distance = dispersion + delay / 2;


-- 
dwmw2

