Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWEaKzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWEaKzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWEaKzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:55:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51159 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751577AbWEaKzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:55:50 -0400
Date: Wed, 31 May 2006 12:56:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531105609.GA608@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com> <20060530220931.GA32759@elte.hu> <20060530221850.GA1764@elte.hu> <20060530222608.GA3274@elte.hu> <20060530222954.GA3746@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530222954.GA3746@elte.hu>
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

> CONFIG_PROFILE_LIKELY it is, please disable it in your config, along 
> with CONFIG_DEBUG_STACKOVERFLOW:

the tracer fix for PROFILE_LIKELY is below. I have also uploaded an 
updated tracing patch to

  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch

which allows the enabling of PROFILE_LIKELY && LATENCY_TRACING again. 
There's an updated combo patch too:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch

for easy pickup of all current fixes against mm1 baseline.

	Ingo

Index: linux/lib/likely_prof.c
===================================================================
--- linux.orig/lib/likely_prof.c
+++ linux/lib/likely_prof.c
@@ -20,7 +20,7 @@
 
 static struct likeliness *likeliness_head;
 
-int do_check_likely(struct likeliness *likeliness, int ret)
+int notrace do_check_likely(struct likeliness *likeliness, int ret)
 {
 	static unsigned long likely_lock;
 
