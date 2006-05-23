Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWEWIAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWEWIAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWEWIAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:00:16 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:22613 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751287AbWEWIAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:00:15 -0400
Subject: Re: [PATCH] s390: next_timer_interrupt overflow in stop_hz_timer
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Jones <davej@redhat.com>, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060522201428.GA10346@redhat.com>
References: <200605212100.k4LL0pCX012928@hera.kernel.org>
	 <20060522201428.GA10346@redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 23 May 2006 09:22:42 +0200
Message-Id: <1148368962.5402.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 16:14 -0400, Dave Jones wrote:

> arch/s390/kernel/time.c: In function 'stop_hz_timer':
> arch/s390/kernel/time.c:275: error: expected ')' before 'next'
> arch/s390/kernel/time.c:275: error: expected ')' before 'jiffies'

Argh,
I really have to stop doing things in a hurry. This result in stupid
things like missing parentheses for a type cast.

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

--
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: fix typo in stop_hz_timer.

Add missing parentheses for type cast to u64.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-05-23 09:10:41.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-05-23 09:04:47.000000000 +0200
@@ -273,7 +273,7 @@ static inline void stop_hz_timer(void)
 	next = next_timer_interrupt();
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
-		timer = (__u64 next) - (__u64 jiffies) + jiffies_64;
+		timer = ((__u64) next) - ((__u64) jiffies) + jiffies_64;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 	todval = -1ULL;
 	/* Be careful about overflows. */


