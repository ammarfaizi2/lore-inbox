Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbULDAXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbULDAXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbULDAVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:21:50 -0500
Received: from fmr22.intel.com ([143.183.121.14]:33771 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262509AbULDAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:21:09 -0500
Date: Fri, 3 Dec 2004 16:18:50 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add cpu_relax in idle spin loop for no-hlt kernel option
Message-ID: <20041203161850.A2133@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If given no-hlt kernel option, ia32 idle loop turns out to be a spin loop.
Add cpu_relax() in this spin loop because IA32 SDM recommends that a PAUSE
instruction be put in all spin loops.

The patch is against 2.6.9 kernel.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

diff -Nurp a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-10-18 14:53:05.000000000 -0700
+++ b/arch/i386/kernel/process.c	2004-12-02 18:04:43.000000000 -0800
@@ -97,6 +97,8 @@ void default_idle(void)
 		else
 			local_irq_enable();
 	}
+	else
+		cpu_relax();
 }
 
 /*
