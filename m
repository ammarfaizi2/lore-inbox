Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261254AbVCFAWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCFAWv (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCEXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:44:23 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:44932 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261241AbVCEXhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:40 -0500
Date: Sat, 05 Mar 2005 17:37:38 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 5/13] hc_crisv10: Clean up printk()'s in
 drivers/usb/host/hc_crisv10.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233737.7648.58688.80967@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add KERN_ constants to printk()s missing them, and fix the debugging macros in
drivers/usb/host/hc_crisv10.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/host/hc_crisv10.c linux-2.6.11-mm1/drivers/usb/host/hc_crisv10.c
--- linux-2.6.11-mm1-original/drivers/usb/host/hc_crisv10.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/host/hc_crisv10.c	2005-03-05 15:21:06.000000000 -0500
@@ -32,16 +32,14 @@
 
 #include "hc_crisv10.h"
 
+#define PFX "hc_crisv10: "
+
 #define ETRAX_USB_HC_IRQ USB_HC_IRQ_NBR
 #define ETRAX_USB_RX_IRQ USB_DMA_RX_IRQ_NBR
 #define ETRAX_USB_TX_IRQ USB_DMA_TX_IRQ_NBR
 
 static const char *usb_hcd_version = "$Revision: 1.2 $";
 
-#undef KERN_DEBUG
-#define KERN_DEBUG ""
-
-
 #undef USB_DEBUG_RH
 #undef USB_DEBUG_EPID
 #undef USB_DEBUG_SB
@@ -54,50 +52,50 @@ static const char *usb_hcd_version = "$R
 #undef USB_DEBUG_ISOC
 
 #ifdef USB_DEBUG_RH
-#define dbg_rh(format, arg...) printk(KERN_DEBUG __FILE__ ": (RH) " format "\n" , ## arg)
+#define dbg_rh(format, arg...) printk(KERN_DEBUG PFX "(RH) " format "\n" , ## arg)
 #else
 #define dbg_rh(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_EPID
-#define dbg_epid(format, arg...) printk(KERN_DEBUG __FILE__ ": (EPID) " format "\n" , ## arg)
+#define dbg_epid(format, arg...) printk(KERN_DEBUG PFX "(EPID) " format "\n" , ## arg)
 #else
 #define dbg_epid(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_SB
-#define dbg_sb(format, arg...) printk(KERN_DEBUG __FILE__ ": (SB) " format "\n" , ## arg)
+#define dbg_sb(format, arg...) printk(KERN_DEBUG PFX "(SB) " format "\n" , ## arg)
 #else
 #define dbg_sb(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_CTRL
-#define dbg_ctrl(format, arg...) printk(KERN_DEBUG __FILE__ ": (CTRL) " format "\n" , ## arg)
+#define dbg_ctrl(format, arg...) printk(KERN_DEBUG PFX "(CTRL) " format "\n" , ## arg)
 #else
 #define dbg_ctrl(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_BULK
-#define dbg_bulk(format, arg...) printk(KERN_DEBUG __FILE__ ": (BULK) " format "\n" , ## arg)
+#define dbg_bulk(format, arg...) printk(KERN_DEBUG PFX "(BULK) " format "\n" , ## arg)
 #else
 #define dbg_bulk(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_INTR
-#define dbg_intr(format, arg...) printk(KERN_DEBUG __FILE__ ": (INTR) " format "\n" , ## arg)
+#define dbg_intr(format, arg...) printk(KERN_DEBUG PFX "(INTR) " format "\n" , ## arg)
 #else
 #define dbg_intr(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_ISOC
-#define dbg_isoc(format, arg...) printk(KERN_DEBUG __FILE__ ": (ISOC) " format "\n" , ## arg)
+#define dbg_isoc(format, arg...) printk(KERN_DEBUG PFX "(ISOC) " format "\n" , ## arg)
 #else
 #define dbg_isoc(format, arg...) do {} while (0)
 #endif
 
 #ifdef USB_DEBUG_TRACE
-#define DBFENTER (printk(": Entering: %s\n", __FUNCTION__))
-#define DBFEXIT  (printk(": Exiting:  %s\n", __FUNCTION__))
+#define DBFENTER (printk(PFX "%s(): entering\n", __FUNCTION__))
+#define DBFEXIT  (printk(PFX "%s(): exiting\n",  __FUNCTION__))
 #else
 #define DBFENTER do {} while (0)
 #define DBFEXIT  do {} while (0)
@@ -522,32 +520,36 @@ static struct usb_operations etrax_usb_d
    USB_DEBUG_URB macros. */
 static void __dump_urb(struct urb* purb)
 {
-	printk("\nurb                  :0x%08lx\n", (unsigned long)purb);
-	printk("dev                   :0x%08lx\n", (unsigned long)purb->dev);
-	printk("pipe                  :0x%08x\n", purb->pipe);
-	printk("status                :%d\n", purb->status);
-	printk("transfer_flags        :0x%08x\n", purb->transfer_flags);
-	printk("transfer_buffer       :0x%08lx\n", (unsigned long)purb->transfer_buffer);
-	printk("transfer_buffer_length:%d\n", purb->transfer_buffer_length);
-	printk("actual_length         :%d\n", purb->actual_length);
-	printk("setup_packet          :0x%08lx\n", (unsigned long)purb->setup_packet);
-	printk("start_frame           :%d\n", purb->start_frame);
-	printk("number_of_packets     :%d\n", purb->number_of_packets);
-	printk("interval              :%d\n", purb->interval);
-	printk("error_count           :%d\n", purb->error_count);
-	printk("context               :0x%08lx\n", (unsigned long)purb->context);
-	printk("complete              :0x%08lx\n\n", (unsigned long)purb->complete);
+	pr_info(PFX "%s(): start\n");
+	pr_info(PFX "urb                  :0x%08lx\n", (unsigned long)purb);
+	pr_info(PFX "dev                   :0x%08lx\n", (unsigned long)purb->dev);
+	pr_info(PFX "pipe                  :0x%08x\n", purb->pipe);
+	pr_info(PFX "status                :%d\n", purb->status);
+	pr_info(PFX "transfer_flags        :0x%08x\n", purb->transfer_flags);
+	pr_info(PFX "transfer_buffer       :0x%08lx\n", (unsigned long)purb->transfer_buffer);
+	pr_info(PFX "transfer_buffer_length:%d\n", purb->transfer_buffer_length);
+	pr_info(PFX "actual_length         :%d\n", purb->actual_length);
+	pr_info(PFX "setup_packet          :0x%08lx\n", (unsigned long)purb->setup_packet);
+	pr_info(PFX "start_frame           :%d\n", purb->start_frame);
+	pr_info(PFX "number_of_packets     :%d\n", purb->number_of_packets);
+	pr_info(PFX "interval              :%d\n", purb->interval);
+	pr_info(PFX "error_count           :%d\n", purb->error_count);
+	pr_info(PFX "context               :0x%08lx\n", (unsigned long)purb->context);
+	pr_info(PFX "complete              :0x%08lx\n\n", (unsigned long)purb->complete);
+	pr_info(PFX "%s(): end\n");
 }
 
 static void __dump_in_desc(volatile USB_IN_Desc_t *in)
 {
-	printk("\nUSB_IN_Desc at 0x%08lx\n", (unsigned long)in);
-	printk("  sw_len  : 0x%04x (%d)\n", in->sw_len, in->sw_len);
-	printk("  command : 0x%04x\n", in->command);
-	printk("  next    : 0x%08lx\n", in->next);
-	printk("  buf     : 0x%08lx\n", in->buf);
-	printk("  hw_len  : 0x%04x (%d)\n", in->hw_len, in->hw_len);
-	printk("  status  : 0x%04x\n\n", in->status);
+	pr_info(PFX "%s(): start\n");
+	pr_info(PFX "USB_IN_Desc at 0x%08lx\n", (unsigned long)in);
+	pr_info(PFX "  sw_len  : 0x%04x (%d)\n", in->sw_len, in->sw_len);
+	pr_info(PFX "  command : 0x%04x\n", in->command);
+	pr_info(PFX "  next    : 0x%08lx\n", in->next);
+	pr_info(PFX "  buf     : 0x%08lx\n", in->buf);
+	pr_info(PFX "  hw_len  : 0x%04x (%d)\n", in->hw_len, in->hw_len);
+	pr_info(PFX "  status  : 0x%04x\n\n", in->status);
+	pr_info(PFX "%s(): end\n");
 }
 
 static void __dump_sb_desc(volatile USB_SB_Desc_t *sb)
@@ -572,32 +574,36 @@ static void __dump_sb_desc(volatile USB_
 		tt_string = "unknown (weird)";
 	}
 
-	printk("\n   USB_SB_Desc at 0x%08lx\n", (unsigned long)sb);
-	printk("     command : 0x%04x\n", sb->command);
-	printk("        rem     : %d\n", (sb->command & 0x3f00) >> 8);
-	printk("        full    : %d\n", (sb->command & 0x40) >> 6);
-	printk("        tt      : %d (%s)\n", tt, tt_string);
-	printk("        intr    : %d\n", (sb->command & 0x8) >> 3);
-	printk("        eot     : %d\n", (sb->command & 0x2) >> 1);
-	printk("        eol     : %d\n", sb->command & 0x1);
-	printk("     sw_len  : 0x%04x (%d)\n", sb->sw_len, sb->sw_len);
-	printk("     next    : 0x%08lx\n", sb->next);
-	printk("     buf     : 0x%08lx\n\n", sb->buf);
+	pr_info(PFX "%s(): start\n");
+	pr_info(PFX "USB_SB_Desc at 0x%08lx\n", (unsigned long)sb);
+	pr_info(PFX "     command : 0x%04x\n", sb->command);
+	pr_info(PFX "        rem     : %d\n", (sb->command & 0x3f00) >> 8);
+	pr_info(PFX "        full    : %d\n", (sb->command & 0x40) >> 6);
+	pr_info(PFX "        tt      : %d (%s)\n", tt, tt_string);
+	pr_info(PFX "        intr    : %d\n", (sb->command & 0x8) >> 3);
+	pr_info(PFX "        eot     : %d\n", (sb->command & 0x2) >> 1);
+	pr_info(PFX "        eol     : %d\n", sb->command & 0x1);
+	pr_info(PFX "     sw_len  : 0x%04x (%d)\n", sb->sw_len, sb->sw_len);
+	pr_info(PFX "     next    : 0x%08lx\n", sb->next);
+	pr_info(PFX "     buf     : 0x%08lx\n\n", sb->buf);
+	pr_info(PFX "%s(): end\n");
 }
 
 
 static void __dump_ep_desc(volatile USB_EP_Desc_t *ep)
 {
-	printk("\nUSB_EP_Desc at 0x%08lx\n", (unsigned long)ep);
-	printk("  command : 0x%04x\n", ep->command);
-	printk("     ep_id   : %d\n", (ep->command & 0x1f00) >> 8);
-	printk("     enable  : %d\n", (ep->command & 0x10) >> 4);
-	printk("     intr    : %d\n", (ep->command & 0x8) >> 3);
-	printk("     eof     : %d\n", (ep->command & 0x2) >> 1);
-	printk("     eol     : %d\n", ep->command & 0x1);
-	printk("  hw_len  : 0x%04x (%d)\n", ep->hw_len, ep->hw_len);
-	printk("  next    : 0x%08lx\n", ep->next);
-	printk("  sub     : 0x%08lx\n\n", ep->sub);
+	pr_info(PFX "%s(): start\n");
+	pr_info(PFX "USB_EP_Desc at 0x%08lx\n", (unsigned long)ep);
+	pr_info(PFX "  command : 0x%04x\n", ep->command);
+	pr_info(PFX "     ep_id   : %d\n", (ep->command & 0x1f00) >> 8);
+	pr_info(PFX "     enable  : %d\n", (ep->command & 0x10) >> 4);
+	pr_info(PFX "     intr    : %d\n", (ep->command & 0x8) >> 3);
+	pr_info(PFX "     eof     : %d\n", (ep->command & 0x2) >> 1);
+	pr_info(PFX "     eol     : %d\n", ep->command & 0x1);
+	pr_info(PFX "  hw_len  : 0x%04x (%d)\n", ep->hw_len, ep->hw_len);
+	pr_info(PFX "  next    : 0x%08lx\n", ep->next);
+	pr_info(PFX "  sub     : 0x%08lx\n\n", ep->sub);
+	pr_info(PFX "%s(): end\n");
 }
 
 static inline void __dump_ep_list(int pipe_type)
@@ -626,7 +632,7 @@ static inline void __dump_ep_list(int pi
 	}
 	ep = first_ep;
 
-	printk("\n\nDumping EP list...\n\n");
+	pr_info(PFX "Dumping EP list...\n");
 
 	do {
 		__dump_ep_desc(ep);
@@ -647,7 +653,7 @@ static inline void __dump_ept_data(int e
 	__u32 r_usb_ept_data;
 
 	if (epid < 0 || epid > 31) {
-		printk("Cannot dump ept data for invalid epid %d\n", epid);
+		printk(KERN_ERR PFX "cannot dump ept data for invalid epid %d\n", epid);
 		return;
 	}
 
@@ -658,30 +664,33 @@ static inline void __dump_ept_data(int e
 	r_usb_ept_data = *R_USB_EPT_DATA;
 	restore_flags(flags);
 
-	printk("\nR_USB_EPT_DATA = 0x%x for epid %d :\n", r_usb_ept_data, epid);
+	pr_info(PFX "%s(): start\n");
+	pr_info(PFX "R_USB_EPT_DATA = 0x%x for epid %d :\n", r_usb_ept_data, epid);
 	if (r_usb_ept_data == 0) {
+		pr_info(PFX "epid %d empty\n", epid);
 		/* No need for more detailed printing. */
-		return;
+		goto out;
 	}
-	printk("  valid           : %d\n", (r_usb_ept_data & 0x80000000) >> 31);
-	printk("  hold            : %d\n", (r_usb_ept_data & 0x40000000) >> 30);
-	printk("  error_count_in  : %d\n", (r_usb_ept_data & 0x30000000) >> 28);
-	printk("  t_in            : %d\n", (r_usb_ept_data & 0x08000000) >> 27);
-	printk("  low_speed       : %d\n", (r_usb_ept_data & 0x04000000) >> 26);
-	printk("  port            : %d\n", (r_usb_ept_data & 0x03000000) >> 24);
-	printk("  error_code      : %d\n", (r_usb_ept_data & 0x00c00000) >> 22);
-	printk("  t_out           : %d\n", (r_usb_ept_data & 0x00200000) >> 21);
-	printk("  error_count_out : %d\n", (r_usb_ept_data & 0x00180000) >> 19);
-	printk("  max_len         : %d\n", (r_usb_ept_data & 0x0003f800) >> 11);
-	printk("  ep              : %d\n", (r_usb_ept_data & 0x00000780) >> 7);
-	printk("  dev             : %d\n", (r_usb_ept_data & 0x0000003f));
+	pr_info(PFX "  valid           : %d\n", (r_usb_ept_data & 0x80000000) >> 31);
+	pr_info(PFX "  hold            : %d\n", (r_usb_ept_data & 0x40000000) >> 30);
+	pr_info(PFX "  error_count_in  : %d\n", (r_usb_ept_data & 0x30000000) >> 28);
+	pr_info(PFX "  t_in            : %d\n", (r_usb_ept_data & 0x08000000) >> 27);
+	pr_info(PFX "  low_speed       : %d\n", (r_usb_ept_data & 0x04000000) >> 26);
+	pr_info(PFX "  port            : %d\n", (r_usb_ept_data & 0x03000000) >> 24);
+	pr_info(PFX "  error_code      : %d\n", (r_usb_ept_data & 0x00c00000) >> 22);
+	pr_info(PFX "  t_out           : %d\n", (r_usb_ept_data & 0x00200000) >> 21);
+	pr_info(PFX "  error_count_out : %d\n", (r_usb_ept_data & 0x00180000) >> 19);
+	pr_info(PFX "  max_len         : %d\n", (r_usb_ept_data & 0x0003f800) >> 11);
+	pr_info(PFX "  ep              : %d\n", (r_usb_ept_data & 0x00000780) >> 7);
+	pr_info(PFX "  dev             : %d\n", (r_usb_ept_data & 0x0000003f));
+out:	pr_info(PFX "%s(): end\n");
 }
 
 static inline void __dump_ept_data_list(void)
 {
 	int i;
 
-	printk("Dumping the whole R_USB_EPT_DATA list\n");
+	pr_info(PFX "dumping the whole R_USB_EPT_DATA list\n");
 
 	for (i = 0; i < 32; i++) {
 		__dump_ept_data(i);
@@ -1334,7 +1343,7 @@ static int etrax_usb_submit_urb(struct u
 	DBFEXIT;
 
         if (ret != 0)
-          printk("Submit URB error %d\n", ret);
+          printk(KERN_ERR PFX "submit URB error %d\n", ret);
 
 	return ret;
 }
@@ -1869,7 +1878,7 @@ static irqreturn_t etrax_usb_rx_interrup
 		epid = IO_EXTRACT(USB_IN_status, epid, myNextRxDesc->status);
 		urb = urb_list_first(epid);
 
-		//printk("eop for epid %d, first urb 0x%lx\n", epid, (unsigned long)urb);
+		//printk(KERN_DEBUG "eop for epid %d, first urb 0x%lx\n", epid, (unsigned long)urb);
 
 		if (!urb) {
 			err("No urb for epid %d in rx interrupt", epid);
