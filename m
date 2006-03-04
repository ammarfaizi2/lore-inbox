Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWCDMRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWCDMRe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWCDMOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751709AbWCDMO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:29 -0500
Date: Sat, 4 Mar 2006 13:14:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] drivers/message/fusion/mptbase.c: make mpt_read_ioc_pg_3() static
Message-ID: <20060304121429.GM9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
>  git-scsi-misc.patch
>...
>  git trees
>...


mpt_read_ioc_pg_3() can now become static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/fusion/mptbase.c |    4 ++--
 drivers/message/fusion/mptbase.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc5-mm2-full/drivers/message/fusion/mptbase.h.old	2006-03-03 17:44:55.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/message/fusion/mptbase.h	2006-03-03 17:45:02.000000000 +0100
@@ -1021,7 +1021,6 @@
 extern void	 mpt_alloc_fw_memory(MPT_ADAPTER *ioc, int size);
 extern void	 mpt_free_fw_memory(MPT_ADAPTER *ioc);
 extern int	 mpt_findImVolumes(MPT_ADAPTER *ioc);
-extern int	 mpt_read_ioc_pg_3(MPT_ADAPTER *ioc);
 extern int	 mptbase_sas_persist_operation(MPT_ADAPTER *ioc, u8 persist_opcode);
 extern int	 mptbase_GetFcPortPage0(MPT_ADAPTER *ioc, int portnum);
 
--- linux-2.6.16-rc5-mm2-full/drivers/message/fusion/mptbase.c.old	2006-03-03 17:45:10.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/message/fusion/mptbase.c	2006-03-03 17:47:07.000000000 +0100
@@ -180,6 +180,7 @@
 static void	mpt_fc_log_info(MPT_ADAPTER *ioc, u32 log_info);
 static void	mpt_spi_log_info(MPT_ADAPTER *ioc, u32 log_info);
 static void	mpt_sas_log_info(MPT_ADAPTER *ioc, u32 log_info);
+static int	mpt_read_ioc_pg_3(MPT_ADAPTER *ioc);
 
 /* module entry point */
 static int  __init    fusion_init  (void);
@@ -4871,7 +4872,7 @@
 	return rc;
 }
 
-int
+static int
 mpt_read_ioc_pg_3(MPT_ADAPTER *ioc)
 {
 	IOCPage3_t		*pIoc3;
@@ -6364,7 +6365,6 @@
 EXPORT_SYMBOL(mpt_HardResetHandler);
 EXPORT_SYMBOL(mpt_config);
 EXPORT_SYMBOL(mpt_findImVolumes);
-EXPORT_SYMBOL(mpt_read_ioc_pg_3);
 EXPORT_SYMBOL(mpt_alloc_fw_memory);
 EXPORT_SYMBOL(mpt_free_fw_memory);
 EXPORT_SYMBOL(mptbase_sas_persist_operation);

