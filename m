Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUKUX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUKUX7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUKUX7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:59:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56839 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261857AbUKUX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:58:53 -0500
Date: Mon, 22 Nov 2004 00:58:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cdrom.c: make several functions static (fwd)
Message-ID: <20041121235851.GG13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm2 (I've edited it for a trivial context adjustment).

Please apply or comment on it.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 31 Oct 2004 22:33:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cdrom.c: make several functions static

The patch below makes several functions in cdrom.c static.

This includes cdrom_is_mrw and cdrom_is_random_writable which were 
EXPORT_SYMBOL'ed but weren't used anywhere outside of cdrom.h .


diffstat output:
 drivers/cdrom/cdrom.c |   24 +++++++++++-------------
 include/linux/cdrom.h |    2 --
 2 files changed, 11 insertions(+), 15 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/include/linux/cdrom.h.old	2004-10-31 01:19:52.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/include/linux/cdrom.h	2004-10-31 01:20:17.000000000 +0200
@@ -1185,8 +1185,6 @@
 };
 
 extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct media_event_desc *med);
-extern int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write);
-extern int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write);
 
 #endif  /* End of kernel only stuff */ 
 
--- linux-2.6.10-rc1-mm2-full/drivers/cdrom/cdrom.c.old	2004-10-31 01:13:21.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/cdrom/cdrom.c	2004-10-31 01:16:08.000000000 +0200
@@ -505,7 +505,7 @@
  * the first prototypes used 0x2c as the page code for the mrw mode page,
  * subsequently this was changed to 0x03. probe the one used by this drive
  */
-int cdrom_mrw_probe_pc(struct cdrom_device_info *cdi)
+static int cdrom_mrw_probe_pc(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
 	char buffer[16];
@@ -526,7 +526,7 @@
 	return 1;
 }
 
-int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
+static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 {
 	struct packet_command cgc;
 	struct mrw_feature_desc *mfd;
@@ -680,7 +680,7 @@
 	return 0;
 }
 
-int cdrom_get_random_writable(struct cdrom_device_info *cdi,
+static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 			      struct rwrt_feature_desc *rfd)
 {
 	struct packet_command cgc;
@@ -701,7 +701,7 @@
 	return 0;
 }
 
-int cdrom_has_defect_mgt(struct cdrom_device_info *cdi)
+static int cdrom_has_defect_mgt(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
 	char buffer[16];
@@ -726,7 +726,7 @@
 }
 
 
-int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
+static int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
 {
 	struct rwrt_feature_desc rfd;
 	int ret;
@@ -3074,14 +3074,12 @@
 EXPORT_SYMBOL(cdrom_mode_sense);
 EXPORT_SYMBOL(init_cdrom_command);
 EXPORT_SYMBOL(cdrom_get_media_event);
-EXPORT_SYMBOL(cdrom_is_mrw);
-EXPORT_SYMBOL(cdrom_is_random_writable);
 
 #ifdef CONFIG_SYSCTL
 
 #define CDROM_STR_SIZE 1000
 
-struct cdrom_sysctl_settings {
+static struct cdrom_sysctl_settings {
 	char	info[CDROM_STR_SIZE];	/* general info */
 	int	autoclose;		/* close tray upon mount, etc */
 	int	autoeject;		/* eject on umount */
@@ -3090,7 +3088,7 @@
 	int	check;			/* check media type */
 } cdrom_sysctl_settings;
 
-int cdrom_sysctl_info(ctl_table *ctl, int write, struct file * filp,
+static int cdrom_sysctl_info(ctl_table *ctl, int write, struct file * filp,
                            void __user *buffer, size_t *lenp, loff_t *ppos)
 {
         int pos;
@@ -3193,7 +3191,7 @@
    procfs/sysctl yet. When they are, this will naturally disappear. For now
    just update all drives. Later this will become the template on which
    new registered drives will be based. */
-void cdrom_update_settings(void)
+static void cdrom_update_settings(void)
 {
 	struct cdrom_device_info *cdi;
 
@@ -3271,7 +3269,7 @@
 }
 
 /* Place files in /proc/sys/dev/cdrom */
-ctl_table cdrom_table[] = {
+static ctl_table cdrom_table[] = {
 	{
 		.ctl_name	= DEV_CDROM_INFO,
 		.procname	= "info",
@@ -3323,7 +3321,7 @@
 	{ .ctl_name = 0 }
 };
 
-ctl_table cdrom_cdrom_table[] = {
+static ctl_table cdrom_cdrom_table[] = {
 	{
 		.ctl_name	= DEV_CDROM,
 		.procname	= "cdrom",
@@ -3335,7 +3333,7 @@
 };
 
 /* Make sure that /proc/sys/dev is there */
-ctl_table cdrom_root_table[] = {
+static ctl_table cdrom_root_table[] = {
 	{
 		.ctl_name	= CTL_DEV,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

