Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVGJVgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVGJVgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVGJTjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40924 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261794AbVGJTfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:45 -0400
Date: Sun, 10 Jul 2005 19:35:44 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 36/82] remove linux/version.h from drivers/scsi/dpt/dpti_i2o.h
Message-ID: <20050710193544.36.hHLDaW3232.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code for obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/dpt/dpti_i2o.h |   11 -----------
1 files changed, 11 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/dpt/dpti_i2o.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/dpt/dpti_i2o.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/dpt/dpti_i2o.h
@@ -22,7 +22,6 @@
#include <linux/i2o-dev.h>

#include <asm/semaphore.h> /* Needed for MUTEX init macros */
-#include <linux/version.h>
#include <linux/config.h>
#include <linux/notifier.h>
#include <asm/atomic.h>
@@ -48,21 +47,11 @@
*	I2O Interface Objects
*/

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-
-#define DECLARE_MUTEX(name) struct semaphore name=MUTEX
-
-typedef struct wait_queue *adpt_wait_queue_head_t;
-#define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) adpt_wait_queue_head_t wait = NULL
-typedef struct wait_queue adpt_wait_queue_t;
-#else
-
#include <linux/wait.h>
typedef wait_queue_head_t adpt_wait_queue_head_t;
#define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) DECLARE_WAIT_QUEUE_HEAD(wait)
typedef wait_queue_t adpt_wait_queue_t;

-#endif
/*
* message structures
*/
