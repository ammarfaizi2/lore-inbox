Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVHEULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVHEULe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVHEUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:08:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20151 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262908AbVHEUIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:08:11 -0400
Date: Fri, 5 Aug 2005 22:08:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Message-ID: <20050805200821.GA25282@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org> <20050805104819.GA20278@elte.hu> <200508051626.56910.dominik.karall@gmx.net> <20050805152245.GA12650@elte.hu> <20050805110532.55428af7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805110532.55428af7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > please enable CONFIG_FRAME_POINTERS!
> 
> Seems a bit tricky.  Wouldn't it be best if enabling 
> CONFIG_DEBUG_PREEMPT autoselected CONFIG_KALLSYMS_ALL, 
> CONFIG_FRAME_POINTER and whatever else we need?

ok, agreed:

-----
when DEBUG_PREEMPT is enabled, select FRAME_POINTER and KALLSYMS_ALL
as well, to make the debug output more useful.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 lib/Kconfig.debug |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-preempt-trace/lib/Kconfig.debug
===================================================================
--- linux-preempt-trace.orig/lib/Kconfig.debug
+++ linux-preempt-trace/lib/Kconfig.debug
@@ -70,6 +70,9 @@ config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
 	default y
+	select FRAME_POINTER
+	select KALLSYMS
+	select KALLSYMS_ALL
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
