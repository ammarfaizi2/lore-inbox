Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbREYVAF>; Fri, 25 May 2001 17:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbREYU7q>; Fri, 25 May 2001 16:59:46 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:46119
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261857AbREYU7k>; Fri, 25 May 2001 16:59:40 -0400
Date: Fri, 25 May 2001 22:59:34 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add missing spin_unlock_irq to ide.c (244ac16)
Message-ID: <20010525225934.K851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I forgot to cc l-k on this one when it went to andre.)

Hi.

This patch adds a spin_unlock_irqsave to ide_spin_wait_hwgroup as
reported by the Stanford team way back. It applies against 244ac16.


--- linux-244-ac16-clean/drivers/ide/ide.c	Fri May 25 21:11:08 2001
+++ linux-244-ac16/drivers/ide/ide.c	Fri May 25 22:46:43 2001
@@ -2362,6 +2362,8 @@
 		__restore_flags(lflags);	/* local CPU only */
 		spin_lock_irq(&io_request_lock);
 	}
+
+        spin_unlock_irq(&io_request_lock);
 	return 0;
 }
 
-- 
        Rasmus(rasmus@jaquet.dk)

