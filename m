Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVA3P6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVA3P6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVA3P6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:58:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:46008 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261718AbVA3P57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:57:59 -0500
Date: Sun, 30 Jan 2005 17:01:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Achim Leubner <achim_leubner@adaptec.com>,
       Boji Tony Kannanthanam <boji.t.kannanthanam@intel.com>,
       Johannes Dinner <johannes_dinner@adaptec.com>,
       linux-scsi@vger.kernel.org
Subject: shouldn't "irq" be module_param_array instead of module_param in
 scsi/gdth.c ?
Message-ID: <Pine.LNX.4.62.0501301653480.2731@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This little warning made me take a closer look : 
drivers/scsi/gdth.c:645: warning: return from incompatible pointer type

And line 645 looks like this :

module_param(irq, int, 0);

looking a bit up in the file I find :

/* IRQ list for GDT3000/3020 EISA controllers */
static int irq[MAXHA] __initdata =
{0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};

That certainly looks like an array to me, so I'm wondering if something 
like this patch would be correct?  I'm not familliar enough with 
module_param* to be completely confident, but this silences the warning.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc2-bk7-orig/drivers/scsi/gdth.c	2005-01-22 21:59:46.000000000 +0100
+++ linux-2.6.11-rc2-bk7/drivers/scsi/gdth.c	2005-01-30 16:52:45.000000000 +0100
@@ -642,7 +642,7 @@ static int probe_eisa_isa = 0;
 static int force_dma32 = 0;
 
 /* parameters for modprobe/insmod */
-module_param(irq, int, 0);
+module_param_array(irq, int, NULL, 0);
 module_param(disable, int, 0);
 module_param(reserve_mode, int, 0);
 module_param_array(reserve_list, int, NULL, 0);



-- 
Kind regards,
  Jesper Juhl

PS. Please CC me on replies.


