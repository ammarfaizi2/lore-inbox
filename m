Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVKPRba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVKPRba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKPRba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:31:30 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:10779 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S965096AbVKPRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:31:29 -0500
X-IronPort-AV: i="3.97,338,1125896400"; 
   d="scan'208"; a="341287047:sNHT90442228"
Date: Wed, 16 Nov 2005 11:31:23 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: minyard@acm.org, akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net
Subject: [PATCH 2.6.15-rc] ipmi: missing NULL test for kthread
Message-ID: <20051116173123.GA25777@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On IPMI systems with BT interfaces, we don't start the kernel thread,
so smi_info->thread is NULL.  Test for NULL when stopping the thread,
because kthread_stop() doesn't, and an oops ensues otherwise.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -urNp --exclude-from=/home/mdomsch/excludes --minimal linux-2.6/drivers/char/ipmi/ipmi_si_intf.c linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c
--- linux-2.6/drivers/char/ipmi/ipmi_si_intf.c	Wed Nov 16 08:45:57 2005
+++ linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c	Wed Nov 16 08:49:12 2005
@@ -2203,7 +2203,7 @@ static void setup_xaction_handlers(struc
 
 static inline void wait_for_timer_and_thread(struct smi_info *smi_info)
 {
-	if (smi_info->thread != ERR_PTR(-ENOMEM))
+	if (smi_info->thread != NULL && smi_info->thread != ERR_PTR(-ENOMEM))
 		kthread_stop(smi_info->thread);
 	del_timer_sync(&smi_info->si_timer);
 }
