Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268958AbTGJFL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268962AbTGJFL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:11:26 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:22290 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S268958AbTGJFKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:10:51 -0400
Date: Thu, 10 Jul 2003 13:23:03 +0800 (SGT)
From: Jeff Chua <jeff89@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22-pre4 ide module fix init_cmd640_vlb
Message-ID: <Pine.LNX.4.56.0307101315480.845@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/10/2003
 01:25:26 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/10/2003
 01:25:28 PM,
	Serialize complete at 07/10/2003 01:25:28 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

The following patch fixes problem when CONFIG_BLK_DEV_CMD640=y

depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre4/kernel/drivers/ide/ide-core.o
depmod:         init_cmd640_vlb

init_cmd640_vlb() doesn't exist. This patch removes the function call so
that ide can be loaded as a module.

Thanks,
Jeff.

--- drivers/ide/ide.c	Thu Jul 10 13:03:49 2003
+++ drivers/ide/ide.c.new	Thu Jul 10 13:03:55 2003
@@ -2112,8 +2112,6 @@
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 			{
-				extern void init_cmd640_vlb (void);
-				init_cmd640_vlb();
 				goto done;
 			}
 #endif /* CONFIG_BLK_DEV_CMD640 */


