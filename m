Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUFIXFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUFIXFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUFIXFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:05:07 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:52610 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266194AbUFIXFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:05:02 -0400
Subject: PATCH: 2.6.7-rc3 drivers/char/ipmi/ipmi_devintf.c: user/kernel
	pointer typo
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: minyard@mvista.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 16:04:59 -0700
Message-Id: <1086822299.32056.134.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judging from context, I think there's a misplaced "&" in this code that
can cause stack overflows and other nasty problems.  Perhaps it's left 
over from when msgdata was an array instead of a pointer?  Let me know 
if you have any questions or I made a mistake.

Best,
Rob


--- linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c.orig	Wed Jun  9 12:08:23 2004
+++ linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c	Wed Jun  9 12:07:09 2004
@@ -199,7 +199,7 @@ static int handle_send_req(ipmi_user_t  
 			goto out;
 		}
 
-		if (copy_from_user(&msgdata,
+		if (copy_from_user(msgdata,
 				   req->msg.data,
 				   req->msg.data_len))
 		{



