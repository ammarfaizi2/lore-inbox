Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSHFAmK>; Mon, 5 Aug 2002 20:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318950AbSHFAmK>; Mon, 5 Aug 2002 20:42:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54914 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318948AbSHFAmJ>;
	Mon, 5 Aug 2002 20:42:09 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208060045.g760jdr15064@eng2.beaverton.ibm.com>
Subject: [PATCH] /proc/partitions fix for 2.5.30
To: linux-kernel@vger.kernel.org
Date: Mon, 5 Aug 2002 17:45:39 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the problem with /proc/partitions showing wrong number of
blocks in 2.5.30.

Here is the patch. Please apply.

Thanks,
Badari

--- linux/drivers/block/genhd.c	Mon Aug  5 17:30:36 2002
+++ linux.new/drivers/block/genhd.c	Mon Aug  5 17:23:29 2002
@@ -166,7 +166,7 @@
 			continue;
 		seq_printf(part, "%4d  %4d %10ld %s\n",
 			sgp->major, n + sgp->first_minor,
-			sgp->part[n].nr_sects << 1,
+			sgp->part[n].nr_sects >> 1,
 			disk_name(sgp, n + sgp->first_minor, buf));
 	}
 
