Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUJDKg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUJDKg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUJDKg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:36:58 -0400
Received: from zamok.crans.org ([138.231.136.6]:6112 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S267939AbUJDKgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:36:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Mon, 04 Oct 2004 12:36:55 +0200
In-Reply-To: <20041004020207.4f168876.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 4 Oct 2004 02:02:07 -0700")
Message-ID: <87oeji93co.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
>
>
> - Hopefully those x86 compile errors are fixed up.
>
> - Various fairly minor updates
>

It fails to compile at arch/i386/kernel/irq.c if CONFIG_4KSTACKS is undefined
this seems to fix (just compile tested, too far from home to boot-test it :))


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=2.6.9-rc3-mm1-build-fix.patch

--- linux-2.6.9-rc3-mm2/arch/i386/kernel/irq.c.old	2004-10-04 12:30:08.600490264 +0200
+++ linux-2.6.9-rc3-mm2/arch/i386/kernel/irq.c	2004-10-04 12:27:44.632376744 +0200
@@ -199,6 +199,7 @@
 
 atomic_t irq_err_count;
 
+#ifdef CONFIG_4KSTACKS
 int is_irq_stack_ptr(struct task_struct *task, void *p)
 {
 	unsigned long off;
@@ -213,6 +214,7 @@
 
 	return 0;
 }
+#endif
 
 /*
  * /proc/interrupts printing:

--=-=-=


Hum, and I can see that there is a fix to get reiser4 working with 4Kstacks
but reiser4 option still doesn't appear if CONFIG_4KSTACKS is enabled.

-- 
Mathieu Segaud

--=-=-=--

