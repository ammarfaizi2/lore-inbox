Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVCIQoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVCIQoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVCIQoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:44:06 -0500
Received: from [151.97.230.9] ([151.97.230.9]:61700 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261659AbVCIQlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:41:04 -0500
Subject: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it, domen@coderock.org, amitg@calsoftinc.com,
       gud@eth.net
From: blaisorblade@yahoo.it
Date: Wed, 09 Mar 2005 10:42:33 +0100
Message-Id: <20050309094234.8FC0C6477@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: <domen@coderock.org>
Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>, <amitg@calsoftinc.com>, <gud@eth.net>

Unify the spinlock initialization as far as possible.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/port_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/drivers/port_kern.c~uml-switch-spinlock-init arch/um/drivers/port_kern.c
--- linux-2.6.11/arch/um/drivers/port_kern.c~uml-switch-spinlock-init	2005-03-09 10:35:28.786848080 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/port_kern.c	2005-03-09 10:35:28.789847624 +0100
@@ -185,11 +185,11 @@ void *port_data(int port_num)
 		  .has_connection 	= 0,
 		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
 								  0),
-		  .lock 		= SPIN_LOCK_UNLOCKED,
 		  .port 	 	= port_num,
 		  .fd  			= fd,
 		  .pending 		= LIST_HEAD_INIT(port->pending),
 		  .connections 		= LIST_HEAD_INIT(port->connections) });
+	spin_lock_init(&port->lock);
 	list_add(&port->list, &ports);
 
  found:
_
