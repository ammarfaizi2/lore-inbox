Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVLAADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVLAADy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK3X6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:46754
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751287AbVK3X5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:32 -0500
Subject: [patch 12/43] Check user space timespec in do_sys_settimeofday
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:13 +0100
Message-Id: <1133395393.32542.455.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (sys-settimeofday-check-timespec.patch)
- Check if the timespec which is provided from user space is
  normalized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/time.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15-rc2-rework/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/time.c
+++ linux-2.6.15-rc2-rework/kernel/time.c
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

