Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUFQTic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUFQTic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFQTia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:38:30 -0400
Received: from palrel13.hp.com ([156.153.255.238]:9428 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262766AbUFQThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:37:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16593.62204.126371.863028@napali.hpl.hp.com>
Date: Thu, 17 Jun 2004 12:37:32 -0700
To: Balazs Scheidler <bazsi@balabit.hu>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
In-Reply-To: <1087489727.30553.0.camel@bzorp.balabit>
References: <1087420973.4345.19.camel@bzorp.balabit>
	<16592.60876.886257.165633@napali.hpl.hp.com>
	<1087489727.30553.0.camel@bzorp.balabit>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 17 Jun 2004 18:28:48 +0200, Balazs Scheidler <bazsi@balabit.hu> said:

  >>  Does the oops go away with an SMP kernel?

  Balazs> yes, it does.

Does the attached patch fix the UP problem for you?

	--david

===== include/asm-ia64/gcc_intrin.h 1.5 vs edited =====
--- 1.5/include/asm-ia64/gcc_intrin.h	Mon May 10 23:44:41 2004
+++ edited/include/asm-ia64/gcc_intrin.h	Thu Jun 17 12:10:52 2004
@@ -581,7 +587,7 @@
 
 #define ia64_intrin_local_irq_restore(x)			\
 do {								\
-	asm volatile ("     cmp.ne p6,p7=%0,r0;;"		\
+	asm volatile (";;   cmp.ne p6,p7=%0,r0;;"		\
 		      "(p6) ssm psr.i;"				\
 		      "(p7) rsm psr.i;;"			\
 		      "(p6) srlz.d"				\
