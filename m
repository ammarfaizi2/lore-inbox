Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRBYPyl>; Sun, 25 Feb 2001 10:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRBYPyb>; Sun, 25 Feb 2001 10:54:31 -0500
Received: from mx2.port.ru ([194.67.23.33]:31754 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S129394AbRBYPyS>;
	Sun, 25 Feb 2001 10:54:18 -0500
From: "Nick Kurshev" <nickols_k@mail.ru>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 25 Feb 2001 18:41:28 +0000 (:)
Reply-To: "Nick Kurshev" <nickols_k@mail.ru>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 7bit
Subject: Probably patch-2.4.1 is not complete
Message-Id: <E14X3Ut-000CN7-00@smtp2.port.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have downloaded a full tarball of linux-kernel-2.4.0 and patches: patch-2.4.1 patch-2.4.2.
But patch-2.4.1 imho it not complete. During linking a linker said about unresolved reference:
__buggy_fxsr_alignment
The patch-2.4.1 contain following records:
 /* Enable FXSR and company _before_ testing for FP problems. */
-#if defined(CONFIG_X86_FXSR) || defined(CONFIG_X86_RUNTIME_FXSR)
 	/*
 	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
 	 */
-	if (offsetof(struct task_struct, thread.i387.fxsave) & 15)
-		panic("Kernel compiled for PII/PIII+ with FXSR, data not 16-byte aligned!");
-
+	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
+		extern void __buggy_fxsr_alignment(void);
+		__buggy_fxsr_alignment();
+	}
 	if (cpu_has_fxsr) {
 		printk(KERN_INFO "Enabling fast FPU save and restore... ");
 		set_in_cr4(X86_CR4_OSFXSR);
 		printk("done.\n");
 	}
-#endif

I.e. in version 2.4.0 of kernel this code was conditionally compiled and did not cause any problems.
In 2.4.1 coditional compilation was avoided. In 2.4.2 this place is not modified.
I did an attempt to find out implementation of __buggy_fxsr_alignment but have not found any source which
contains body of function.

I have K6 cpu and for me this piece of code is unnecessary. But already second patch I'm modifing by hand.
May be it would be better for me to download a full tarball of linux-2.4.2?

Any suggestions please!

Best regards! Nick


