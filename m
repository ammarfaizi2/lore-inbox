Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVLQRaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVLQRaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVLQRaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:30:19 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30923 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932614AbVLQRaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:30:18 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] quiet IDE resource reservation messages
Date: Sat, 17 Dec 2005 09:30:24 -0800
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wsEpD4XeiYlzRXS"
Message-Id: <200512170930.24218.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wsEpD4XeiYlzRXS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In combined mode, having IDE resources reserved before the IDE driver 
can get to them is normal and expected, so quiet the 'resource 
conflict' messages a bit so as not to alarm anyone (and clean up my 
'quiet' boot a bit).

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks,
Jesse

--Boundary-00=_wsEpD4XeiYlzRXS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ide-silence-info.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-silence-info.patch"

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 02167a5..57325a2 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -773,7 +773,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 			}
 		}
 		if (!msgout)
-			printk(KERN_ERR "%s: ports already in use, skipping probe\n",
+			printk(KERN_INFO "%s: ports already in use, skipping probe\n",
 				hwif->name);
 		return;	
 	}
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 8af179b..84dd69b 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -366,8 +366,8 @@ static struct resource* hwif_request_reg
 	struct resource *res = request_region(addr, num, hwif->name);
 
 	if (!res)
-		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
-				hwif->name, addr, addr+num-1);
+		printk(KERN_INFO "%s: I/O resource 0x%lX-0x%lX not free.\n",
+				 hwif->name, addr, addr+num-1);
 	return res;
 }
 

--Boundary-00=_wsEpD4XeiYlzRXS--
