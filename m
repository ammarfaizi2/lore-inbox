Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWFBOIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWFBOIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWFBOIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:08:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33943 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932119AbWFBOI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:08:29 -0400
Date: Fri, 2 Jun 2006 16:08:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm2] lock validator: fix compiler warning
Message-ID: <20060602140857.GA8718@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5125]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: fix compiler warning
From: Ingo Molnar <mingo@elte.hu>

fix harmless lockdep.c warning on !SMP:

 kernel/lockdep.c: In function 'static_obj':
 kernel/lockdep.c:1112: warning: unused variable 'i'

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1109,7 +1109,9 @@ static int static_obj(void *obj)
 	unsigned long start = (unsigned long) &_stext,
 		      end   = (unsigned long) &_end,
 		      addr  = (unsigned long) obj;
+#ifdef CONFIG_SMP
 	int i;
+#endif
 
 	/*
 	 * static variable?
