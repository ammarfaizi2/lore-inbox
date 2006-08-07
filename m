Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWHGFPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWHGFPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWHGFPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:15:04 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:27356 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751052AbWHGFPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:15:02 -0400
Subject: Re: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1154926114.21647.38.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <1154925943.21647.32.camel@localhost.localdomain>
	 <1154926048.21647.35.camel@localhost.localdomain>
	 <1154926114.21647.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 15:14:59 +1000
Message-Id: <1154927700.7642.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And a trivial warning fix on that last one when !CONFIG_PARAVIRT.

struct paravirt_patch is only defined for CONFIG_PARAVIRT, so we
declare the (unused) __start and __stop section markers as char, which
causes a warning when we pass them to the dummy apply_paravirt.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

--- working-2.6.18-rc3-mm2/arch/i386/kernel/alternative.c.~1~	2006-08-07 14:33:13.000000000 +1000
+++ working-2.6.18-rc3-mm2/arch/i386/kernel/alternative.c	2006-08-07 15:08:21.000000000 +1000
@@ -369,7 +369,7 @@
 extern struct paravirt_patch __start_parainstructions[],
 	__stop_parainstructions[];
 #else
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+void apply_paravirt(void *start, void *end)
 {
 }
 extern char __start_parainstructions[], __stop_parainstructions[];


-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

