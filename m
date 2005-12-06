Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbVLFAfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbVLFAfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbVLFAf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30926
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751534AbVLFAef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:35 -0500
Message-Id: <20051206000154.439228000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:38 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 12/21] Validate timespec of do_sys_settimeofday
Content-Disposition: inline; filename=sys-settimeofday-check-timespec.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Check if the timespec which is provided from user space is
  normalized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/time.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -154,6 +154,9 @@ int do_sys_settimeofday(struct timespec 
 	static int firsttime = 1;
 	int error = 0;
 
+	if (!timespec_valid(tv))
+		return -EINVAL;
+
 	error = security_settime(tv, tz);
 	if (error)
 		return error;

--

