Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVAKDvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVAKDvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAKDsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:48:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:6118 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262429AbVAJSXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:23:07 -0500
Date: Mon, 10 Jan 2005 10:23:04 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] scsi/qla1280: replace schedule_timeout() with ssleep()
Message-ID: <20050110182304.GF3099@us.ibm.com>
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

> msleep-drivers_scsi_ppa.patch

Please drop this patch, as it incorrectly uses msleep() around waitqueues.

> msleep-drivers_scsi_qla1280.patch

Please conside replacing with the following patch:

Description: Use ssleep() instead of schedule_timeout to guarantee the task
delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/scsi/qla1280.c	2004-12-24 13:35:40.000000000 -0800
+++ 2.6.10/drivers/scsi/qla1280.c	2005-01-05 14:23:05.000000000 -0800
@@ -2939,7 +2939,7 @@ qla1280_bus_reset(struct scsi_qla_host *
 		ha->bus_settings[bus].failed_reset_count++;
 	} else {
 		spin_unlock_irq(HOST_LOCK);
-		schedule_timeout(reset_delay * HZ);
+		ssleep(reset_delay);
 		spin_lock_irq(HOST_LOCK);
 
 		ha->bus_settings[bus].scsi_bus_dead = 0;
