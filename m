Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbRGKOSh>; Wed, 11 Jul 2001 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbRGKOS2>; Wed, 11 Jul 2001 10:18:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:57585 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S267312AbRGKOSO>; Wed, 11 Jul 2001 10:18:14 -0400
To: ralf@gnu.ai.mit.edu
Cc: linux-mips@fnet.fr, linux-kernel@vger.kernel.org
Subject: Re: optimised rw-semaphores for MIPS/MIPS64 
In-Reply-To: Message from David Howells <dhowells@redhat.com> 
   of "Wed, 11 Jul 2001 15:00:47 BST." <2508.994860047@warthog.cambridge.redhat.com> 
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <2571.994861087.0@warthog.cambridge.redhat.com>
Date: Wed, 11 Jul 2001 15:18:14 +0100
Message-ID: <2574.994861094@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2571.994861087.1@warthog.cambridge.redhat.com>

You'll also need the asm-mips*/compiler.h patch.

David


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="compilerh.diff"; charset="us-ascii"
Content-ID: <2571.994861087.2@warthog.cambridge.redhat.com>
Content-Description: compiler smoothing header files patch

diff -uNr -x CVS -x TAGS linux-2.4-mips/include/asm-mips/compiler.h linux-mips-rwsem/include/asm-mips/compiler.h
--- linux-2.4-mips/include/asm-mips/compiler.h	Thu Jan  1 01:00:00 1970
+++ linux-mips-rwsem/include/asm-mips/compiler.h	Wed Jul 11 15:12:33 2001
@@ -0,0 +1,13 @@
+#ifndef __ASM_COMPILER_H
+#define __ASM_COMPILER_H
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __ASM_COMPILER_H */
diff -uNr -x CVS -x TAGS linux-2.4-mips/include/asm-mips64/compiler.h linux-mips-rwsem/include/asm-mips64/compiler.h
--- linux-2.4-mips/include/asm-mips64/compiler.h	Thu Jan  1 01:00:00 1970
+++ linux-mips-rwsem/include/asm-mips64/compiler.h	Wed Jul 11 15:12:05 2001
@@ -0,0 +1,13 @@
+#ifndef __ASM_COMPILER_H
+#define __ASM_COMPILER_H
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __ASM_COMPILER_H */

------- =_aaaaaaaaaa0--
