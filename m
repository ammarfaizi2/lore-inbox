Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbVKZPVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbVKZPVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbVKZPVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:21:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10653 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422633AbVKZPVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:21:08 -0500
Date: Sat, 26 Nov 2005 16:21:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] warn-on-once.patch
Message-ID: <20051126152115.GA15686@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013522.18537.97944.sendpatchset@cog.beaverton.ibm.com> <20051126145216.GB12999@elte.hu> <20051126151734.GA15240@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126151734.GA15240@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > - introduce WARN_ON_ONCE(cond)
> 
> replacement patch below - fixed bug found by Thomas Gleixner. (I've 
> updated the gtod-B11-cleanup.tar.gz patchqueue with both this fix and 
> the x64 fix.)

replacement of the replacement (fix trailing semicolon).

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-generic/bug.h |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux/include/asm-generic/bug.h
===================================================================
--- linux.orig/include/asm-generic/bug.h
+++ linux/include/asm-generic/bug.h
@@ -39,4 +39,14 @@
 #endif
 #endif
 
+#define WARN_ON_ONCE(condition)		\
+do {					\
+	static int warn_once = 1;	\
+					\
+	if (warn_once && (condition)) {	\
+		warn_once = 0;		\
+		WARN_ON(1);		\
+	}				\
+} while (0)
+
 #endif
