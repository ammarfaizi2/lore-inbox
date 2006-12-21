Return-Path: <linux-kernel-owner+w=401wt.eu-S1161024AbWLUMp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWLUMp5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWLUMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:45:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43673 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161024AbWLUMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:45:57 -0500
Date: Thu, 21 Dec 2006 13:43:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch] change WARN_ON back to "BUG: at ..."
Message-ID: <20061221124327.GA17190@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] change WARN_ON back to "BUG: at ..."
From: Ingo Molnar <mingo@elte.hu>

WARN_ON() ever triggering is a kernel bug. Do not try to paper over this 
fact by suggesting to the user that this is 'only' a warning, as the 
following recent commit does:

  commit 30e25b71e725b150585e17888b130e3324f8cf7c
  Author: Jeremy Fitzhardinge <jeremy@goop.org>
  Date:   Fri Dec 8 02:36:24 2006 -0800

    [PATCH] Fix generic WARN_ON message

    A warning is a warning, not a BUG.

( it might make sense to rename BUG() to CRASH() and BUG_ON() to
  CRASH_ON(), but that does not change the fact that WARN_ON()
  signals a kernel bug. )

i and others objected to this change during lkml review:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=116115160710533&w=2

still the change slipped upstream - grumble :)

Also, use the standard "BUG: " format to make it easier to grep logs and 
to make it easier to google for kernel bugs.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-generic/bug.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/asm-generic/bug.h
===================================================================
--- linux.orig/include/asm-generic/bug.h
+++ linux/include/asm-generic/bug.h
@@ -35,7 +35,7 @@ struct bug_entry {
 #define WARN_ON(condition) ({						\
 	typeof(condition) __ret_warn_on = (condition);			\
 	if (unlikely(__ret_warn_on)) {					\
-		printk("WARNING at %s:%d %s()\n", __FILE__,	\
+		printk("BUG: at %s:%d %s()\n", __FILE__,		\
 			__LINE__, __FUNCTION__);			\
 		dump_stack();						\
 	}								\
