Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHGUvE>; Wed, 7 Aug 2002 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSHGUvE>; Wed, 7 Aug 2002 16:51:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38704 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313558AbSHGUvD>; Wed, 7 Aug 2002 16:51:03 -0400
Date: Wed, 7 Aug 2002 16:54:43 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Buglet in irq compat code in 2.5.30
Message-ID: <20020807165443.A3730@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The save_flags used to save flags, while local_irq_save saves AND
closes interrupts, and local_irq_save_off simply does not exist.
I did not see anything on the list, perhaps nobody is bold enough
to use 2.5.30?

diff -urN -X dontdiff linux-2.5.30/include/linux/interrupt.h linux-2.5.30-sparc/include/linux/interrupt.h
--- linux-2.5.30/include/linux/interrupt.h	Thu Aug  1 14:16:01 2002
+++ linux-2.5.30-sparc/include/linux/interrupt.h	Wed Aug  7 13:48:25 2002
@@ -50,9 +50,9 @@
 #if !CONFIG_SMP
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
-# define save_flags(x)		local_irq_save(x)
+# define save_flags(x)		local_save_flags(x)
 # define restore_flags(x)	local_irq_restore(x)
-# define save_and_cli(x)	local_irq_save_off(x)
+# define save_and_cli(x)	local_irq_save(x)
 #endif
 
 
