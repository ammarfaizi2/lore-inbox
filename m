Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHSGzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHSGzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUHSGzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:55:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261184AbUHSGzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:55:39 -0400
Date: Wed, 18 Aug 2004 23:55:23 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: arjanv@redhat.com
Cc: alan@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com, riel@redhat.com, sct@redhat.com
Subject: PF_MEMALLOC in 2.6
Message-Id: <20040818235523.383737cd@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PF_MEMALLOC is required on usb-storage threads in 2.4, because ext3
will deadlock and otherwise misbehave when it's trying to write out
dirty pages under memory pressure.

I received a bug report today from an FC3T1 user with same symptoms
as 2.4. But I'm entirely clueless in the way VM operates. Comments?

-- Pete

--- linux-2.6.8-rc4-mm1/drivers/usb/storage/usb.c	2004-08-16 12:13:06.000000000 -0700
+++ linux-2.6.8-rc4-mm1-ub/drivers/usb/storage/usb.c	2004-08-18 23:48:09.335107648 -0700
@@ -285,7 +285,7 @@ static int usb_stor_control_thread(void 
 	 */
 	daemonize("usb-storage");
 
-	current->flags |= PF_NOFREEZE;
+	current->flags |= PF_NOFREEZE|PF_MEMALLOC;
 
 	unlock_kernel();
 
