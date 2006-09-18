Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWIRAyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWIRAyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWIRAyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:54:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965193AbWIRAyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:54:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iZcZSVaET/iLtMCt145bMDqdN0N4rXMzc1WKDdg+QNyv1PPuvVJccWkCK6COk5h0j8s1YdttwgZCWEbgFGs/zj5xi8+hU57EIpBGglKwebmFexcw7uur2Wwn3iCZ6YTmanvCmU7KzvE4uXlelN6uXh3M7OsKxbwYBaVLEoz+M6w=
Message-ID: <6b4e42d10609171754p4054762bm5711c744b61e68a0@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:54:17 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: potential crash fix : drivers/pcmcia/au1000_generic
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling.

I have not subscribed to pcmcia list. Please cc me any comments.

Signed off by Om Narasimhan <om.turyx@gmail.com>

 drivers/pcmcia/au1000_generic.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index d5dd0ce..9a87a87 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2001-2003 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
- *         	ppopov@embeddedalley.com or source@mvista.com
+ *			ppopov@embeddedalley.com or source@mvista.com
  *
  * Copyright 2004 Pete Popov, Embedded Alley Solutions, Inc.
  * Updated the driver to 2.6. Followed the sa11xx API and largely
@@ -438,17 +438,16 @@ #endif
 	dev_set_drvdata(dev, sinfo);
 	return 0;

-	do {
+out_err:
+	flush_scheduled_work();
+	ops->hw_shutdown(skt);
+	while (i-- > 0) {
 		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
-
 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
-out_err:
 		flush_scheduled_work();
 		ops->hw_shutdown(skt);
-
-		i--;
-	} while (i > 0);
+	}
 	kfree(sinfo);
 out:
 	return ret;
