Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVJKEno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJKEno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJKEnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:43:43 -0400
Received: from xenotime.net ([66.160.160.81]:33421 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751289AbVJKEnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:43:43 -0400
Date: Mon, 10 Oct 2005 21:43:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] sparse cleanups: NULL pointers, C99 struct init.
Message-Id: <20051010214341.6e2a1805.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Convert most of the remaining "Using plain integer as NULL pointer"
sparse warnings to use NULL.
(Not duplicating patches that are already in -mm, -bird, or -kj.)

Convert isdn driver struct initializer to use C99 syntax.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/isdn/hisax/hfc4s8s_l1.c     |   10 +++++-----
 arch/i386/kernel/reboot_fixups.c    |    2 +-
 drivers/char/drm/drm_context.c      |    4 ++--
 drivers/char/tpm/tpm_atmel.c        |    2 +-
 drivers/char/tpm/tpm_nsc.c          |    2 +-
 drivers/media/dvb/dvb-usb/dtt200u.c |    4 ++--
 drivers/media/dvb/dvb-usb/vp7045.c  |    2 +-
 drivers/net/skfp/smt.c              |    2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff -Naurp linux-2614-rc3-g7/drivers/char/drm/drm_context.c~char_drm_null linux-2614-rc3-g7/drivers/char/drm/drm_context.c
--- linux-2614-rc3-g7/drivers/char/drm/drm_context.c~char_drm_null	2005-10-08 11:44:11.000000000 -0700
+++ linux-2614-rc3-g7/drivers/char/drm/drm_context.c	2005-10-09 20:32:23.000000000 -0700
@@ -226,14 +226,14 @@ int drm_getsareactx(struct inode *inode,
 	map = dev->context_sareas[request.ctx_id];
 	up(&dev->struct_sem);
 
-	request.handle = 0;
+	request.handle = NULL;
 	list_for_each_entry(_entry, &dev->maplist->head,head) {
 		if (_entry->map == map) {
 			request.handle = (void *)(unsigned long)_entry->user_token;
 			break;
 		}
 	}
-	if (request.handle == 0)
+	if (request.handle == NULL)
 		return -EINVAL;
 
 
diff -Naurp linux-2614-rc3-g7/drivers/char/tpm/tpm_nsc.c~char_tpm_null linux-2614-rc3-g7/drivers/char/tpm/tpm_nsc.c
--- linux-2614-rc3-g7/drivers/char/tpm/tpm_nsc.c~char_tpm_null	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc3-g7/drivers/char/tpm/tpm_nsc.c	2005-10-09 20:33:31.000000000 -0700
@@ -239,7 +239,7 @@ static struct attribute * nsc_attrs[] = 
 	&dev_attr_pcrs.attr,
 	&dev_attr_caps.attr,
 	&dev_attr_cancel.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group nsc_attr_grp = { .attrs = nsc_attrs };
diff -Naurp linux-2614-rc3-g7/drivers/char/tpm/tpm_atmel.c~char_tpm_null linux-2614-rc3-g7/drivers/char/tpm/tpm_atmel.c
--- linux-2614-rc3-g7/drivers/char/tpm/tpm_atmel.c~char_tpm_null	2005-10-08 11:44:11.000000000 -0700
+++ linux-2614-rc3-g7/drivers/char/tpm/tpm_atmel.c	2005-10-09 20:33:38.000000000 -0700
@@ -137,7 +137,7 @@ static struct attribute* atmel_attrs[] =
 	&dev_attr_pcrs.attr,
 	&dev_attr_caps.attr,
 	&dev_attr_cancel.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group atmel_attr_grp = { .attrs = atmel_attrs };
diff -Naurp linux-2614-rc3-g7/arch/i386/kernel/reboot_fixups.c~i386_reboot_null linux-2614-rc3-g7/arch/i386/kernel/reboot_fixups.c
--- linux-2614-rc3-g7/arch/i386/kernel/reboot_fixups.c~i386_reboot_null	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc3-g7/arch/i386/kernel/reboot_fixups.c	2005-10-09 20:30:18.000000000 -0700
@@ -44,7 +44,7 @@ void mach_reboot_fixups(void)
 
 	for (i=0; i < (sizeof(fixups_table)/sizeof(fixups_table[0])); i++) {
 		cur = &(fixups_table[i]);
-		dev = pci_get_device(cur->vendor, cur->device, 0);
+		dev = pci_get_device(cur->vendor, cur->device, NULL);
 		if (!dev)
 			continue;
 
diff -Naurp linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/dtt200u.c~media_dvb_null linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/dtt200u.c
--- linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/dtt200u.c~media_dvb_null	2005-10-08 11:44:11.000000000 -0700
+++ linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/dtt200u.c	2005-10-09 20:37:49.000000000 -0700
@@ -151,7 +151,7 @@ static struct dvb_usb_properties dtt200u
 		  .cold_ids = { &dtt200u_usb_table[0], NULL },
 		  .warm_ids = { &dtt200u_usb_table[1], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
@@ -192,7 +192,7 @@ static struct dvb_usb_properties wt220u_
 		  .cold_ids = { &dtt200u_usb_table[2], NULL },
 		  .warm_ids = { &dtt200u_usb_table[3], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
diff -Naurp linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/vp7045.c~media_dvb_null linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/vp7045.c
--- linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/vp7045.c~media_dvb_null	2005-10-08 11:44:11.000000000 -0700
+++ linux-2614-rc3-g7/drivers/media/dvb/dvb-usb/vp7045.c	2005-10-09 20:37:58.000000000 -0700
@@ -247,7 +247,7 @@ static struct dvb_usb_properties vp7045_
 		  .cold_ids = { &vp7045_usb_table[2], NULL },
 		  .warm_ids = { &vp7045_usb_table[3], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
diff -Naurp linux-2614-rc3-g7/drivers/net/skfp/smt.c~net_skfp_null linux-2614-rc3-g7/drivers/net/skfp/smt.c
--- linux-2614-rc3-g7/drivers/net/skfp/smt.c~net_skfp_null	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc3-g7/drivers/net/skfp/smt.c	2005-10-09 20:38:55.000000000 -0700
@@ -1896,7 +1896,7 @@ void smt_swap_para(struct smt_header *sm
 
 static void smt_string_swap(char *data, const char *format, int len)
 {
-	const char	*open_paren = 0 ;
+	const char	*open_paren = NULL ;
 	int	x ;
 
 	while (len > 0  && *format) {

diff -Naurp ./drivers/isdn/hisax/hfc4s8s_l1.c~isdn_hfcssll_clean ./drivers/isdn/hisax/hfc4s8s_l1.c
--- ./drivers/isdn/hisax/hfc4s8s_l1.c~isdn_hfcssll_clean	2005-03-26 21:48:11.000000000 -0800
+++ ./drivers/isdn/hisax/hfc4s8s_l1.c	2005-03-27 21:17:01.000000000 -0800
@@ -1062,7 +1062,7 @@ tx_b_frame(struct hfc4s8s_btype *bch)
 				Write_hfc8(l1->hw, A_INC_RES_FIFO, 1);
 			}
 			ack_len += skb->truesize;
-			bch->tx_skb = 0;
+			bch->tx_skb = NULL;
 			bch->tx_cnt = 0;
 			dev_kfree_skb(skb);
 		} else
@@ -1658,10 +1658,10 @@ hfc4s8s_remove(struct pci_dev *pdev)
 }
 
 static struct pci_driver hfc4s8s_driver = {
-      name:"hfc4s8s_l1",
-      probe:hfc4s8s_probe,
-      remove:__devexit_p(hfc4s8s_remove),
-      id_table:hfc4s8s_ids,
+      .name	= "hfc4s8s_l1",
+      .probe	= hfc4s8s_probe,
+      .remove	= __devexit_p(hfc4s8s_remove),
+      .id_table	= hfc4s8s_ids,
 };
 
 /**********************/

---
