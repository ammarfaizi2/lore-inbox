Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWERWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWERWfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWERWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:35:36 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:8408 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750789AbWERWff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:35:35 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] rtc subsystem, use ENOIOCTLCMD where appropriate
Date: Fri, 19 May 2006 00:32:25 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <20060517013033.10d08a8f@inspiron> <20060517232742.2ac4ccaa@inspiron> <e4ilgb$f10$1@terminus.zytor.com>
In-Reply-To: <e4ilgb$f10$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605190032.25796.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans Peter,

H. Peter Anvin wrote
> ENOIOCTLCMD is right here, *except* in the very last hunk, because
> it's a request to the upper layers to emulate the operation:

So would a patch like this be welcome and clear this up?

diff --git a/include/linux/errno.h b/include/linux/errno.h
index d90b80f..d33ae4b 100644
--- a/include/linux/errno.h
+++ b/include/linux/errno.h
@@ -9,7 +9,7 @@
 #define ERESTARTSYS	512
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
-#define ENOIOCTLCMD	515	/* No ioctl command */
+#define ENOIOCTLCMD	515	/* No ioctl command, upper layer please emulate or pass ENOTTY to user space */
 #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
 
 /* Defined for the NFSv3 protocol */


Regards

Ingo Oeser
