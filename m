Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTBVTIT>; Sat, 22 Feb 2003 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTBVTIT>; Sat, 22 Feb 2003 14:08:19 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:11533 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267424AbTBVTIT>; Sat, 22 Feb 2003 14:08:19 -0500
Date: Sat, 22 Feb 2003 13:18:25 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] Fix for drivers/pnp/interface.c
Message-ID: <20030222191825.GB28591@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A BK pull from this morning brings in a number of PNP changes, and there
is a problem with interface.c. The patch below moves the variable
declarations to the beginning of the block, and the code now compiles
without problems. I'm using GCC-2.95.4 from Debian, BTW.

Art Haas

===== drivers/pnp/interface.c 1.10 vs edited =====
--- 1.10/drivers/pnp/interface.c	Wed Feb 19 11:54:46 2003
+++ edited/drivers/pnp/interface.c	Sat Feb 22 11:47:10 2003
@@ -432,11 +432,11 @@
 		goto done;
 	}
 	if (!strnicmp(buf,"set",3)) {
+		struct pnp_resource_table res;
+		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 		if (dev->active)
 			goto done;
 		buf += 3;
-		struct pnp_resource_table res;
-		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 		pnp_init_resource_table(&res);
 		while (1) {
 			while (isspace(*buf))
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
