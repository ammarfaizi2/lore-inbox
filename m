Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHRMck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHRMck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHRMaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:30:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:227 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266147AbUHRM0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:26:07 -0400
Date: Wed, 18 Aug 2004 14:27:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
Message-ID: <20040818122703.GA17301@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040818141231.4bd5ff9d@mango.fruits.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20040818141231.4bd5ff9d@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Hi, it applied against 2.6.8.1 with some offsets and some buzz [?].
> Well anyways it compiled fine and the copy_page_range latency is
> gone.. Now i also see the extracty entropy thing, too..

could you try the attached patch that changes SHA_CODE_SIZE to 3 - does
this reduce the latency caused by extract_entropy?

> Btw: one question: at one point in time the IRQ handlers were in the
> SCHED_FIFO scheduling class. Why has this changed?

so that they dont starve the audio threads by default - the audio IRQ
has to get another priority anyway. Maybe we could try a default
SCHED_FIFO prio lower than the typical rt_priority of jackd - e.g. 30?

	Ingo

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=1

--- linux/drivers/char/random.c.orig	
+++ linux/drivers/char/random.c	
@@ -942,7 +942,7 @@ EXPORT_SYMBOL(add_disk_randomness);
 #define HASH_TRANSFORM SHATransform
 
 /* Various size/speed tradeoffs are available.  Choose 0..3. */
-#define SHA_CODE_SIZE 0
+#define SHA_CODE_SIZE 3
 
 /*
  * SHA transform algorithm, taken from code written by Peter Gutmann,

--Q68bSM7Ycu6FN28Q--
