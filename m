Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUJYEu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUJYEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUJYEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:50:57 -0400
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:23943 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261368AbUJYEuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:50:50 -0400
Date: Mon, 25 Oct 2004 00:52:21 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.10-rc1
Message-ID: <20041025045221.GE3989@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20041025045108.GD3989@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025045108.GD3989@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#   2004/10/24 23:27:24-04:00 nacc@us.ibm.com
#   [PNPBIOS] use msleep_interruptible()
#   
#   Description: Use msleep_interruptible() instead of
#   schedule_timeout() to guarantee the task delays as expected.
#   
#   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
#   Signed-off-by: Adam Belay <ambx1@neo.rr.com>

diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:14 -04:00
+++ b/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:14 -04:00
@@ -60,6 +60,7 @@
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/dmi.h>
+#include <linux/delay.h>
 
 #include <asm/page.h>
 #include <asm/desc.h>
@@ -177,8 +178,7 @@
 		/*
 		 * Poll every 2 seconds
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ*2);
+		msleep_interruptible(2000);
 		if(signal_pending(current))
 			break;
 
