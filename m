Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWGWWGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWGWWGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 18:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWGWWGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 18:06:52 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:12557 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S1751348AbWGWWGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 18:06:51 -0400
Message-ID: <44C3F2CB.5090204@stud.feec.vutbr.cz>
Date: Mon, 24 Jul 2006 00:06:03 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Make touch_nmi_watchdog imply touch_softlockup_watchdog on
 all archs
References: <44B61D0A.7010305@stud.feec.vutbr.cz> <p73ejwpmy6m.fsf@verdi.suse.de> <44B683EB.20709@stud.feec.vutbr.cz> <200607131936.34832.ak@suse.de>
In-Reply-To: <200607131936.34832.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

touch_nmi_watchdog() calls touch_softlockup_watchdog() on both
architectures that implement it (i386 and x86_64). On other architectures
it does nothing at all. touch_nmi_watchdog() should imply
touch_softlockup_watchdog() on all architectures.
Suggested by Andi Kleen.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index c8f4d2f..e16904e 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -4,6 +4,7 @@
 #ifndef LINUX_NMI_H
 #define LINUX_NMI_H
 
+#include <linux/sched.h>
 #include <asm/irq.h>
 
 /**
@@ -16,7 +17,7 @@ #include <asm/irq.h>
 #ifdef ARCH_HAS_NMI_WATCHDOG
 extern void touch_nmi_watchdog(void);
 #else
-# define touch_nmi_watchdog() do { } while(0)
+# define touch_nmi_watchdog() touch_softlockup_watchdog()
 #endif
 
 #endif

