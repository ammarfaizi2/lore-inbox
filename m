Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWANWXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWANWXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWANWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:23:31 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:27418 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbWANWXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Iz/A18TV/l3XByXQQvtcNqzRV69hEKU0KTn1Hc2FyBVEKW/91a4vSgMHYtMfV/K2sbgVT8ShQrfgQxbvWFi0CSZX7Lau8xZGXn3ZMhJh8mEXLsOoxCMfJeVc2mcqi8TgjDwqzhbDUrkVUUX8U9AswwI+z3VOuCvh4hjr/56l8oU=
Date: Sun, 15 Jan 2006 01:40:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] arm26: kernel/irq.c: fix compilation
Message-ID: <20060114224043.GA9982@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's trying to "continue;" in "if" statement.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm26/kernel/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm26/kernel/irq.c
+++ b/arch/arm26/kernel/irq.c
@@ -141,7 +141,7 @@ int show_interrupts(struct seq_file *p, 
 	if (i < NR_IRQS) {
 	    	action = irq_desc[i].action;
 		if (!action)
-			continue;
+			goto out;
 		seq_printf(p, "%3d: %10u ", i, kstat_irqs(i));
 		seq_printf(p, "  %s", action->name);
 		for (action = action->next; action; action = action->next) {
@@ -152,6 +152,7 @@ int show_interrupts(struct seq_file *p, 
 		show_fiq_list(p, v);
 		seq_printf(p, "Err: %10lu\n", irq_err_count);
 	}
+out:
 	return 0;
 }
 

