Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262223AbSJASxJ>; Tue, 1 Oct 2002 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJASxI>; Tue, 1 Oct 2002 14:53:08 -0400
Received: from smtp05.wxs.nl ([195.121.6.57]:43955 "EHLO smtp05.wxs.nl")
	by vger.kernel.org with ESMTP id <S262204AbSJASwd>;
	Tue, 1 Oct 2002 14:52:33 -0400
Message-ID: <3D99EF09.7070609@wxs.nl>
Date: Tue, 01 Oct 2002 20:52:57 +0200
From: Gert Vervoort <Gert.Vervoort@wxs.nl>
Organization: Planet Internet
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 ppa.c compile fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/drivers/scsi/ppa.c.1	Tue Oct  1 20:44:42 2002
+++ linux/drivers/scsi/ppa.c	Tue Oct  1 20:48:27 2002
@@ -801,7 +801,7 @@
      if (ppa_engine(tmp, cmd)) {
  	tmp->ppa_tq.data = (void *) tmp;
  	tmp->ppa_tq.sync = 0;
- 
queue_task(&tmp->ppa_tq, &tq_timer);
+ 
schedule_task(&tmp->ppa_tq);
  	return;
      }
      /* Command must of completed hence it is safe to let go... */
@@ -986,8 +986,7 @@

      ppa_hosts[host_no].ppa_tq.data = ppa_hosts + host_no;
      ppa_hosts[host_no].ppa_tq.sync = 0;
-    queue_task(&ppa_hosts[host_no].ppa_tq, &tq_immediate);
-    mark_bh(IMMEDIATE_BH);
+    schedule_task(&ppa_hosts[host_no].ppa_tq);

      return 0;
  }


