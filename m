Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUEJFk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUEJFk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUEJFk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:40:57 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:52356 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264519AbUEJFkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:40:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 oops in psmouse/serio after resuming from APM suspend-to-ram
Date: Mon, 10 May 2004 00:40:40 -0500
User-Agent: KMail/1.6.2
Cc: Ari Pollak <ajp@aripollak.com>
References: <409BEF21.6040206@aripollak.com> <200405071716.15523.dtor_core@ameritech.net> <c7j8vk$rhf$1@sea.gmane.org>
In-Reply-To: <c7j8vk$rhf$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405100040.51116.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 May 2004 01:30 pm, Ari Pollak wrote:
> This patch did indeed fix the problem; thanks! Hopefully it will be in 
> the next -mm update.
>

Actually the previous patch is a bad one, I think this one is better:

===================================================================


ChangeSet@1.1620, 2004-05-10 00:33:57-05:00, dtor_core@ameritech.net
  Input: do not call synaptics_init unless we are ready to do full
         mouse setup


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Mon May 10 00:35:11 2004
+++ b/drivers/input/mouse/psmouse-base.c	Mon May 10 00:35:11 2004
@@ -427,7 +427,7 @@
 		}
 
 		if (max_proto > PSMOUSE_IMEX) {
-			if (synaptics_init(psmouse) == 0)
+			if (!set_properties || synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
