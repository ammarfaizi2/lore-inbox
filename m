Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTCWADj>; Sat, 22 Mar 2003 19:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCWADj>; Sat, 22 Mar 2003 19:03:39 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:61910 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S262178AbTCWADi>; Sat, 22 Mar 2003 19:03:38 -0500
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: PATCH: make ieee1394 compile in 2.4.21-pre5
Date: Sun, 23 Mar 2003 01:14:40 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303230114.40658.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
 sbp2.c and raw1394.c don't compile in this version.

Some important defines for tasklet support are missing in 
ieee1394_types.h.

I checked it out againts ieee1394 CVS and tested in my machine. 
Everything seems right now, at least it compiles and can access to
the firewire cd-rom.

Regards,

--- linux-2.4.21-pre5/drivers/ieee1394/ieee1394_types.h.orig    2003-03-23 00:48:48.000000000 +0100
+++ linux-2.4.21-pre5/drivers/ieee1394/ieee1394_types.h 2003-03-23 00:48:59.000000000 +0100
@@ -18,6 +18,13 @@
 #define MAX(a,b) ((a) > (b) ? (a) : (b))
 #endif

+/* Use task queue */
+#include <linux/tqueue.h>
+#define hpsb_queue_struct tq_struct
+#define hpsb_queue_list list
+#define hpsb_schedule_work(x) schedule_task(x)
+#define HPSB_INIT_WORK(x,y,z) INIT_TQUEUE(x,y,z)
+#define HPSB_PREPARE_WORK(x,y,z) PREPARE_TQUEUE(x,y,z)

 typedef u32 quadlet_t;
 typedef u64 octlet_t;


-- 
  ricardo galli       GPG id C8114D34
