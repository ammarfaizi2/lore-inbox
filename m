Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTF0UKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTF0UKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:10:19 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:51218 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S264766AbTF0UKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:10:10 -0400
Subject: PATCH 2.4.21 fix: kswapd can fail starting
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2003 22:24:18 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19Vzla-000CR0-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
when i was looking for non checked returns of kernel_thread() i noticed
that vmscan.c never checks. This patch changes that. Note that
kswapd_init() can fail. I have no idea what to do then perhaps somebody
should take a look at that also ?

walter

--- mm/vmscan.c.org     2003-06-25 21:49:45.000000000 +0200
+++ mm/vmscan.c 2003-06-25 21:45:39.000000000 +0200
@@ -768,7 +768,8 @@
 {
        printk("Starting kswapd\n");
        swap_setup();
-       kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+       if (kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL)<0)
+         return 1;
        return 0;
 }

-- 
