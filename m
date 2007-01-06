Return-Path: <linux-kernel-owner+w=401wt.eu-S1751449AbXAFS1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXAFS1A (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXAFS1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:27:00 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:40207 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbXAFS07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:26:59 -0500
Date: Sat, 6 Jan 2007 10:25:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kernel@bardioc.dyndns.org
Subject: [PATCH] sysrq: showBlockedTasks is sysrq-W
Message-Id: <20070106102531.29ce662c.randy.dunlap@oracle.com>
In-Reply-To: <20070105193605.GA14592@aepfle.de>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net>
	<20070105193605.GA14592@aepfle.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 20:36:05 +0100 Olaf Hering wrote:

> On Fri, Jan 05, Randy Dunlap wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > SysRq showBlockedTasks is not done via B or T, it's done via X,
> > so put that in the Help message.
> 
> Weird, who failed to run this command before adding new stuff?!
> find * -type f -print0 | xargs -0 env -i grep -nw register_sysrq_key
> 
> sysrq x is for xmon, see arch/powerpc/xmon/xmon.c
> Better switch the new stuff to 'z' or 'w'
---

From: Randy Dunlap <randy.dunlap@oracle.com>

SysRq showBlockedTasks is not done via B or T, it's done via W,
so put that in the Help message.

It was previously done via X, but X is already used for Xmon
on powerpc platforms and this collision needs to be avoided.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/sysrq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2620-rc3g4.orig/drivers/char/sysrq.c
+++ linux-2620-rc3g4/drivers/char/sysrq.c
@@ -215,7 +215,7 @@ static void sysrq_handle_showstate_block
 }
 static struct sysrq_key_op sysrq_showstate_blocked_op = {
 	.handler	= sysrq_handle_showstate_blocked,
-	.help_msg	= "showBlockedTasks",
+	.help_msg	= "showBlockedTasks(W)",
 	.action_msg	= "Show Blocked State",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -342,8 +342,8 @@ static struct sysrq_key_op *sysrq_key_ta
 	&sysrq_mountro_op,		/* u */
 	/* May be assigned at init time by SMP VOYAGER */
 	NULL,				/* v */
-	NULL,				/* w */
-	&sysrq_showstate_blocked_op,	/* x */
+	&sysrq_showstate_blocked_op,	/* w */
+	NULL,				/* x */
 	NULL,				/* y */
 	NULL				/* z */
 };
