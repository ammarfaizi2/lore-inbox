Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVAJSGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVAJSGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVAJSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:05:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17579 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262394AbVAJSEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:04:24 -0500
Date: Mon, 10 Jan 2005 10:04:17 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [announce] 2.6.10-bk13-kj
Message-ID: <20050110180417.GC3099@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> all patches:
> ------------

<snip>

> msleep-drivers_scsi_ide-scsi.patch

Please consider replacing with the following patch (just a minor change):

Description:  Use msleep() instead of schedule_timeout() to guarantee the
task delays as expected. Remove set_current_state() as it is taken care of by
msleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/scsi/ide-scsi.c	2004-12-24 13:35:01.000000000 -0800
+++ 2.6.10/drivers/scsi/ide-scsi.c	2005-01-05 14:23:05.000000000 -0800
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -1004,9 +1005,8 @@ static int idescsi_eh_reset (struct scsi
 	/* ide_do_reset starts a polling handler which restarts itself every 50ms until the reset finishes */
 
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(cmd->device->host->host_lock);
-		schedule_timeout(HZ/20);
+		msleep(50);
 		spin_lock_irq(cmd->device->host->host_lock);
 	} while ( HWGROUP(drive)->handler );
 

