Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSKUWgZ>; Thu, 21 Nov 2002 17:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSKUWgZ>; Thu, 21 Nov 2002 17:36:25 -0500
Received: from 1-245.ctame701-1.telepar.net.br ([200.181.137.245]:17311 "EHLO
	1-245.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265098AbSKUWgY>; Thu, 21 Nov 2002 17:36:24 -0500
Date: Thu, 21 Nov 2002 20:43:17 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <linux@advansys.com>
Subject: [PATCH] advansys.c buffer overflow
Message-ID: <Pine.LNX.4.44L.0211212040480.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Stanford checker found an error in advansys.c, the driver
is accessing field 6 in an array[6].  Since this is the only
place where this field is accessed it should be safe to simply
remove this line.

===== drivers/scsi/advansys.c 1.18 vs edited =====
--- 1.18/drivers/scsi/advansys.c	Tue Oct 15 16:13:00 2002
+++ edited/drivers/scsi/advansys.c	Wed Nov 20 01:00:08 2002
@@ -5100,7 +5100,6 @@
                 ep->adapter_info[3] = asc_dvc_varp->cfg->adapter_info[3];
                 ep->adapter_info[4] = asc_dvc_varp->cfg->adapter_info[4];
                 ep->adapter_info[5] = asc_dvc_varp->cfg->adapter_info[5];
-                ep->adapter_info[6] = asc_dvc_varp->cfg->adapter_info[6];

                /*
                 * Modify board configuration.


