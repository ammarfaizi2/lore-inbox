Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbUKGUTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUKGUTC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGUTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:19:02 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44040 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261601AbUKGUS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:18:57 -0500
Date: Sun, 7 Nov 2004 21:18:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mpt_linux_developer@lsil.com
Cc: linux-kernel@vger.kernel.org
Subject: RFC: 2.6: unused code under drivers/message/fusion/
Message-ID: <20041107201821.GT14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this patch is wrong, but I'd like to note that it actually 
changes nothing since all code removed or made static currently has no 
in-kernel users (there seems to be a mptstm.c missing?).

Please comment on how to correctly handle this.


diffstat output:
 drivers/message/fusion/mptbase.c  |    7 ++-----
 drivers/message/fusion/mptbase.h  |    2 --
 drivers/message/fusion/mptscsih.c |    2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptscsih.c.old	2004-11-07 20:56:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptscsih.c	2004-11-07 20:56:48.000000000 +0100
@@ -98,7 +98,7 @@
 
 /* Set string for command line args from insmod */
 #ifdef MODULE
-char *mptscsih = NULL;
+static char *mptscsih = NULL;
 module_param(mptscsih, charp, 0);
 #endif
 
--- linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptbase.h.old	2004-11-07 20:57:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptbase.h	2004-11-07 20:57:37.000000000 +0100
@@ -984,10 +984,8 @@
  *  Public data decl's...
  */
 extern struct list_head	  ioc_list;
-extern struct proc_dir_entry	*mpt_proc_root_dir;
 
 extern int		  mpt_lan_index;	/* needed by mptlan.c */
-extern int		  mpt_stm_index;	/* needed by mptstm.c */
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 #endif		/* } __KERNEL__ */
--- linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptbase.c.old	2004-11-07 20:57:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/message/fusion/mptbase.c	2004-11-07 20:58:54.000000000 +0100
@@ -133,9 +133,8 @@
  *  Public data...
  */
 int mpt_lan_index = -1;
-int mpt_stm_index = -1;
 
-struct proc_dir_entry *mpt_proc_root_dir;
+static struct proc_dir_entry *mpt_proc_root_dir;
 
 #define WHOINIT_UNKNOWN		0xAA
 
@@ -355,7 +354,7 @@
 			dmfprintk((MYIOC_s_INFO_FMT "Got TURBO reply req_idx=%08x\n", ioc->name, pa));
 			type = (pa >> MPI_CONTEXT_REPLY_TYPE_SHIFT);
 			if (type == MPI_CONTEXT_REPLY_TYPE_SCSI_TARGET) {
-				cb_idx = mpt_stm_index;
+				cb_idx = -1;
 				mf = NULL;
 				mr = (MPT_FRAME_HDR *) CAST_U32_TO_PTR(pa);
 			} else if (type == MPI_CONTEXT_REPLY_TYPE_LAN) {
@@ -5868,7 +5867,6 @@
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 EXPORT_SYMBOL(ioc_list);
-EXPORT_SYMBOL(mpt_proc_root_dir);
 EXPORT_SYMBOL(mpt_register);
 EXPORT_SYMBOL(mpt_deregister);
 EXPORT_SYMBOL(mpt_event_register);
@@ -5886,7 +5884,6 @@
 EXPORT_SYMBOL(mpt_GetIocState);
 EXPORT_SYMBOL(mpt_print_ioc_summary);
 EXPORT_SYMBOL(mpt_lan_index);
-EXPORT_SYMBOL(mpt_stm_index);
 EXPORT_SYMBOL(mpt_HardResetHandler);
 EXPORT_SYMBOL(mpt_config);
 EXPORT_SYMBOL(mpt_toolbox);



