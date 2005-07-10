Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVGJVgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVGJVgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGJTjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:40156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261792AbVGJTfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:44 -0400
Date: Sun, 10 Jul 2005 19:35:43 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 35/82] remove linux/version.h from drivers/scsi/cpqfcTSinit.c
Message-ID: <20050710193543.35.MfBvHx3206.2247.olh@nectarine.suse.de>
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

drivers/scsi/cpqfcTSinit.c |   32 --------------------------------
1 files changed, 32 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/cpqfcTSinit.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/cpqfcTSinit.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/cpqfcTSinit.c
@@ -34,7 +34,6 @@
#include <linux/config.h>
#include <linux/interrupt.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/blkdev.h>
#include <linux/kernel.h>
#include <linux/string.h>
@@ -66,37 +65,10 @@ MODULE_LICENSE("GPL");

int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev, unsigned int reset_flags);

-// This struct was originally defined in
-// /usr/src/linux/include/linux/proc_fs.h
-// since it's only partially implemented, we only use first
-// few fields...
-// NOTE: proc_fs changes in 2.4 kernel
-
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-static struct proc_dir_entry proc_scsi_cpqfcTS =
-{
-  PROC_SCSI_CPQFCTS,           // ushort low_ino (enumerated list)
-  7,                           // ushort namelen
-  DEV_NAME,                    // const char* name
-  S_IFDIR | S_IRUGO | S_IXUGO, // mode_t mode
-  2                            // nlink_t nlink
-	                       // etc. ...
-};
-
-
-#endif
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,7)
#  define CPQFC_DECLARE_COMPLETION(x) DECLARE_COMPLETION(x)
#  define CPQFC_WAITING waiting
#  define CPQFC_COMPLETE(x) complete(x)
#  define CPQFC_WAIT_FOR_COMPLETION(x) wait_for_completion(x);
-#else
-#  define CPQFC_DECLARE_COMPLETION(x) DECLARE_MUTEX_LOCKED(x)
-#  define CPQFC_WAITING sem
-#  define CPQFC_COMPLETE(x) up(x)
-#  define CPQFC_WAIT_FOR_COMPLETION(x) down(x)
-#endif

static int cpqfc_alloc_private_data_pool(CPQFCHBA *hba);

@@ -288,11 +260,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S

ENTER("cpqfcTS_detect");

-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-  ScsiHostTemplate->proc_dir = &proc_scsi_cpqfcTS;
-#else
ScsiHostTemplate->proc_name = "cpqfcTS";
-#endif

for( i=0; i < HBA_TYPES; i++)
{
