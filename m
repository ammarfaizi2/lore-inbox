Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUFAQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUFAQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUFAQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:26:32 -0400
Received: from aun.it.uu.se ([130.238.12.36]:12461 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265097AbUFAQY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:24:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.44497.301200.142505@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 18:24:49 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
In-Reply-To: <20040601112957.GO2093@holomorphy.com>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<20040601112957.GO2093@holomorphy.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
 > > - NFS server udpates
 > > - md updates
 > > - big x86 dmi_scan.c cleanup
 > > - merged perfctr.  No documentation though :(
 > > - cris architecture update
 > 
 > Hmm. perfctr needs some structs.

Indeed. CONFIG_PERFCTR=n leads to compile-time warnings
from the syscall prototypes in <linux/perfctr.h>.
I'm not sure if providing dummy struct declarations is
cleaner than bracketing the offending code inside #ifdef
CONFIG_PERFCTR, but this patch should fix the warnings for now.

Andrew: please apply.

/Mikael

--- linux-2.6.7-rc2-mm1/include/linux/perfctr.h.~1~	2004-06-01 17:53:56.000000000 +0200
+++ linux-2.6.7-rc2-mm1/include/linux/perfctr.h	2004-06-01 18:18:24.000000000 +0200
@@ -54,6 +54,11 @@
 	unsigned int _reserved4;
 };
 
+#else
+struct perfctr_info;
+struct perfctr_cpu_mask;
+struct perfctr_sum_ctrs;
+struct vperfctr_control;
 #endif	/* CONFIG_PERFCTR */
 
 #ifdef __KERNEL__
