Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271195AbTHRFOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 01:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271210AbTHRFOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 01:14:23 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:19472 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S271195AbTHRFOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 01:14:22 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Mon, 18 Aug 2003 12:28:26 +0800
User-Agent: KMail/1.5.2
Cc: Valdis.Kletnieks@vt.edu, "David D. Hagood" <wowbagger@sktc.net>,
       Jamie Lokier <jamie@shareable.org>,
       Hank Leininger <linux-kernel@progressive-comp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200308170410.30844.mhf@linuxmail.org> <3F3EB8FA.1080605@sktc.net> <20030817205407.GA27725@unthought.net>
In-Reply-To: <20030817205407.GA27725@unthought.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308181220.53083.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for your valuable input,

I was chasing some data corruption testing swsusp. 

This simple patch met my immediate needs (against 2.4.22-rc1)

 diff -uN kernel/signal.c.orig kernel/signal.c
--- kernel/signal.c.orig        2003-08-16 22:08:57.000000000 +0800
+++ kernel/signal.c     2003-08-17 06:21:49.000000000 +0800
@@ -536,6 +536,11 @@
        int ret;


+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+       if (sig == 11 || sig == 13)
+    printk("Signal: %d\n",sig);
+#endif
+
 #if DEBUG_SIG
 printk("SIG queue (%s:%d): %d ", t->comm, t->pid, sig);
 #endif


> ----------------
> 5.     Use step 4 and if the problem persists and is not secondary to a 
> rogue program/daemon get a 3.5 ft (approx. 1 meter) length of sucker rod*
> and have a chat with the user in question.

As to security concerns, I feel this being the appropriate approach ;)

Regards
Michael

-- 
Powered by linux-2.6. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/


