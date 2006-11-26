Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967318AbWKZGrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967318AbWKZGrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 01:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967319AbWKZGrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 01:47:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50877 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967318AbWKZGrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 01:47:19 -0500
Date: Sun, 26 Nov 2006 01:47:04 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: touch softlockup during
Message-ID: <20061126064704.GA5126@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the soft watchdog fires after we're done oopsing.
See http://projects.info-pull.com/mokb/MOKB-25-11-2006.html for an example.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.18.noarch/arch/i386/kernel/traps.c~	2006-11-26 01:40:58.000000000 -0500
+++ linux-2.6.18.noarch/arch/i386/kernel/traps.c	2006-11-26 01:41:28.000000000 -0500
@@ -243,6 +243,7 @@ void dump_trace(struct task_struct *task
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
+		touch_softlockup_watchdog();
 	}
 }
 EXPORT_SYMBOL(dump_trace);
-- 
http://www.codemonkey.org.uk
