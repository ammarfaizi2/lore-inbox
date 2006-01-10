Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWAJDBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWAJDBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 22:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWAJDBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 22:01:50 -0500
Received: from fmr20.intel.com ([134.134.136.19]:58086 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750789AbWAJDBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 22:01:49 -0500
Subject: [PATCH][-mm]kedac not stopped at suspend
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 11:01:01 +0800
Message-Id: <1136862067.5435.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kedac thread doesn't stop at suspend time.
http://bugzilla.kernel.org/show_bug.cgi?id=5849

Thanks,
Shaohua
---

 linux-2.6.15-root/drivers/edac/edac_mc.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/edac/edac_mc.c~edac drivers/edac/edac_mc.c
--- linux-2.6.15/drivers/edac/edac_mc.c~edac	2006-01-09 09:47:18.000000000 +0800
+++ linux-2.6.15-root/drivers/edac/edac_mc.c	2006-01-09 09:59:26.000000000 +0800
@@ -2072,6 +2072,8 @@ static int edac_kernel_thread(void *arg)
 		if(signal_pending(current))
 			flush_signals(current);
 
+		try_to_freeze();
+
 		/* ensure we are interruptable */
 		set_current_state(TASK_INTERRUPTIBLE);
 
_


