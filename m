Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756970AbWKZURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbWKZURr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757960AbWKZURr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:17:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756970AbWKZURq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:17:46 -0500
Date: Sun, 26 Nov 2006 15:17:37 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: touch softlockup during stack unwinding.
Message-ID: <20061126201737.GA13650@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061126064704.GA5126@redhat.com> <200611262026.57604.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611262026.57604.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the soft watchdog fires after we're done oopsing.
See http://projects.info-pull.com/mokb/MOKB-25-11-2006.html for an example.
The NMI watchdog could also fire, so tickle both watchdogs.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/arch/i386/kernel/traps.c~	2006-11-26 01:44:58.000000000 -0500
+++ linux-2.6/arch/i386/kernel/traps.c	2006-11-26 01:45:32.000000000 -0500
@@ -29,6 +29,7 @@
 #include <linux/kexec.h>
 #include <linux/unwind.h>
 #include <linux/uaccess.h>
+#include <linux/nmi.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -247,6 +247,7 @@ void dump_trace(struct task_struct *task
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
+		touch_nmi_watchdog();
 	}
 }
 EXPORT_SYMBOL(dump_trace);


-- 
http://www.codemonkey.org.uk
