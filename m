Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWIUHcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWIUHcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIUHcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:32:07 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:233 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750753AbWIUHcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:32:05 -0400
Message-Id: <45125C4C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 21 Sep 2006 09:33:00 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Mikael Pettersson" <mikpe@it.uu.se>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.18] x86_64: silence warning when stack
	unwinding is disabled
References: <200609210712.k8L7CdrR015591@alkaid.it.uu.se>
In-Reply-To: <200609210712.k8L7CdrR015591@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to this effect is already queued in -mm (and perhaps also in Andi's tree). Jan

>>> Mikael Pettersson <mikpe@it.uu.se> 21.09.06 09:12 >>>
Compiling kernel 2.6.18 on x86_64 with CONFIG_STACK_UNWIND=n gives:

arch/x86_64/kernel/traps.c: In function 'show_trace':
arch/x86_64/kernel/traps.c:287: warning: cast to pointer from integer of different size

This is because UNW_SP() evaluates to 0, of type int, which
is cast to a pointer by traps.c. Fix: evaluate to 0UL instead.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.18/include/asm-x86_64/unwind.h.~1~	2006-09-20 19:28:57.000000000 +0200
+++ linux-2.6.18/include/asm-x86_64/unwind.h	2006-09-20 20:17:52.000000000 +0200
@@ -95,7 +95,7 @@ static inline int arch_unw_user_mode(con
 #else
 
 #define UNW_PC(frame) ((void)(frame), 0)
-#define UNW_SP(frame) ((void)(frame), 0)
+#define UNW_SP(frame) ((void)(frame), 0UL)
 
 static inline int arch_unw_user_mode(const void *info)
 {
