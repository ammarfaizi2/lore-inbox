Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWIHAHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWIHAHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWIHAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:07:09 -0400
Received: from mailfe06.tele2.fr ([212.247.154.172]:53205 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751918AbWIHAHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:07:06 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Fri, 8 Sep 2006 02:06:02 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] no SA_NODEFER on sparc?
Message-ID: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that the sparc arch misses a definition for SA_NODEFER. Is
that on purpose?  If not, here is a patch for fixing this.

Add SA_NODEFER, deprecating linuxish SA_NOMASK.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/include/asm-sparc/signal.h b/include/asm-sparc/signal.h
index d03a21c..5484f65 100644
--- a/include/asm-sparc/signal.h
+++ b/include/asm-sparc/signal.h
@@ -133,16 +133,19 @@ #define _SV_IGNCHILD  8u    /* Do not se
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
  * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOMASK is the historical Linux name for the Single Unix name NODEFER.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
+#define SA_NODEFER	0x20u
 #define SA_NOCLDWAIT	0x100u
 #define SA_SIGINFO	0x200u
 
+#define SA_NOMASK	SA_NODEFER
+
 #define SIG_BLOCK          0x01	/* for blocking signals */
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
 #define SIG_SETMASK        0x04	/* for setting the signal mask */
diff --git a/include/asm-sparc64/signal.h b/include/asm-sparc64/signal.h
index 9968871..f40f2bc 100644
--- a/include/asm-sparc64/signal.h
+++ b/include/asm-sparc64/signal.h
@@ -134,16 +134,18 @@ #define _SV_IGNCHILD  8u    /* Do not se
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
  * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOMASK is the historical Linux name for the Single Unix name NODEFER.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
+#define SA_NODEFER	0x20u
 #define SA_NOCLDWAIT    0x100u
 #define SA_SIGINFO      0x200u
 
+#define SA_NOMASK	SA_NODEFER
 
 #define SIG_BLOCK          0x01	/* for blocking signals */
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
