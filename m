Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbULOByZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbULOByZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbULOBRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:17:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261791AbULOBFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:05:35 -0500
Date: Wed, 15 Dec 2004 02:05:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: irda-users@lists.sourceforge.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/irda/: misc possible cleanups
Message-ID: <20041215010528.GA12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - discovery.c: irlmp_find_device
  - ircomm/ircomm_param.c: ircomm_param_flush
  - irda_device.c: irda_device_set_dtr_rts
  - irda_device.c: irda_device_change_speed
  - irda_device.c: irda_device_set_mode
  - iriap.c: iriap_getinfobasedetails_request
  - iriap.c: iriap_getinfobasedetails_confirm
  - iriap.c: iriap_getobjects_request
  - iriap.c: iriap_getobjects_confirm
  - iriap.c: iriap_getvalue
  - irlan_client.c: irlan_client_reconnect_data_channel
  - irlap_frame.c: irlap_send_frmr_frame
  - irlmp.c: irlmp_status_request
- remove the follwong unused global variables:
  - irnet/irnet_ppp.c: irnet_ppp_ops
  - irsysctl.c: sysctl_compression
- qos.c: #ifndef CONFIG_IRDA_DYNAMIC_WINDOW irlap_requested_line_capacity

Please comment on which of these changes are correct and which conflict
with pending patches.


diffstat output:
 include/net/irda/ircomm_event.h      |    1 
 include/net/irda/ircomm_lmp.h        |   27 -----
 include/net/irda/ircomm_param.h      |    1 
 include/net/irda/ircomm_ttp.h        |   31 ------
 include/net/irda/ircomm_tty.h        |    2 
 include/net/irda/ircomm_tty_attach.h |    1 
 include/net/irda/irda_device.h       |    2 
 include/net/irda/iriap.h             |   10 --
 include/net/irda/irlan_client.h      |    3 
 include/net/irda/irlan_common.h      |    3 
 include/net/irda/irlap.h             |    2 
 include/net/irda/irlap_frame.h       |    1 
 include/net/irda/irlmp.h             |    3 
 include/net/irda/irttp.h             |    3 
 include/net/irda/parameters.h        |    2 
 include/net/irda/qos.h               |    1 
 net/irda/af_irda.c                   |    4 
 net/irda/discovery.c                 |   35 -------
 net/irda/ircomm/ircomm_core.c        |    4 
 net/irda/ircomm/ircomm_event.c       |    2 
 net/irda/ircomm/ircomm_lmp.c         |  128 +++++++++++++--------------
 net/irda/ircomm/ircomm_param.c       |   17 ---
 net/irda/ircomm/ircomm_tty.c         |    7 -
 net/irda/ircomm/ircomm_tty_attach.c  |   12 +-
 net/irda/ircomm/ircomm_tty_ioctl.c   |    2 
 net/irda/irda_device.c               |   70 --------------
 net/irda/iriap.c                     |   51 ++++------
 net/irda/irias_object.c              |    6 -
 net/irda/irlan/irlan_client.c        |   41 --------
 net/irda/irlan/irlan_common.c        |   32 ++++--
 net/irda/irlan/irlan_provider.c      |    6 -
 net/irda/irlap.c                     |    8 +
 net/irda/irlap_event.c               |    2 
 net/irda/irlap_frame.c               |   35 +------
 net/irda/irlmp.c                     |   12 +-
 net/irda/irmod.c                     |    4 
 net/irda/irnet/irnet.h               |    2 
 net/irda/irnet/irnet_ppp.c           |    9 +
 net/irda/irnet/irnet_ppp.h           |    7 -
 net/irda/irsysctl.c                  |    1 
 net/irda/irttp.c                     |   12 +-
 net/irda/parameters.c                |   11 +-
 net/irda/qos.c                       |   10 +-
 43 files changed, 179 insertions(+), 444 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/irda/af_irda.c.old	2004-12-14 14:58:49.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/af_irda.c	2004-12-14 14:59:09.000000000 +0100
@@ -298,7 +298,7 @@
  *    Accept incoming connection
  *
  */
-void irda_connect_response(struct irda_sock *self)
+static void irda_connect_response(struct irda_sock *self)
 {
 	struct sk_buff *skb;
 
@@ -1155,7 +1155,7 @@
  *    Destroy socket
  *
  */
-void irda_destroy_socket(struct irda_sock *self)
+static void irda_destroy_socket(struct irda_sock *self)
 {
 	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
--- linux-2.6.10-rc3-mm1-full/net/irda/discovery.c.old	2004-12-14 14:59:25.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/discovery.c	2004-12-14 14:59:38.000000000 +0100
@@ -315,41 +315,6 @@
 	return(buffer);
 }
 
-/*
- * Function irlmp_find_device (name, saddr)
- *
- *    Look through the discovery log at each of the links and try to find 
- *    the device with the given name. Return daddr and saddr. If saddr is
- *    specified, that look at that particular link only (not impl).
- */
-__u32 irlmp_find_device(hashbin_t *cachelog, char *name, __u32 *saddr)
-{
-	unsigned long flags;
-	discovery_t *d;
-
-	spin_lock_irqsave(&cachelog->hb_spinlock, flags);
-
-	/* Look at all discoveries for that link */
-	d = (discovery_t *) hashbin_get_first(cachelog);
-	while (d != NULL) {
-		IRDA_DEBUG(1, "Discovery:\n");
-		IRDA_DEBUG(1, "  daddr=%08x\n", d->data.daddr);
-		IRDA_DEBUG(1, "  nickname=%s\n", d->data.info);
-
-		if (strcmp(name, d->data.info) == 0) {
-			*saddr = d->data.saddr;
-			
-			spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
-			return d->data.daddr;
-		}
-		d = (discovery_t *) hashbin_get_next(cachelog);
-	}
-
-	spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
-
-	return 0;
-}
-
 #ifdef CONFIG_PROC_FS
 static inline discovery_t *discovery_seq_idx(loff_t pos)
 
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_core.c.old	2004-12-14 14:59:51.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_core.c	2004-12-14 15:00:19.000000000 +0100
@@ -68,7 +68,7 @@
 
 hashbin_t *ircomm = NULL;
 
-int __init ircomm_init(void)
+static int __init ircomm_init(void)
 {
 	ircomm = hashbin_new(HB_LOCK); 
 	if (ircomm == NULL) {
@@ -89,7 +89,7 @@
 	return 0;
 }
 
-void __exit ircomm_cleanup(void)
+static void __exit ircomm_cleanup(void)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_tty_attach.h.old	2004-12-14 15:00:52.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_tty_attach.h	2004-12-14 15:01:01.000000000 +0100
@@ -67,7 +67,6 @@
 };
 
 extern char *ircomm_state[];
-extern char *ircomm_event[];
 extern char *ircomm_tty_state[];
 
 int ircomm_tty_do_event(struct ircomm_tty_cb *self, IRCOMM_TTY_EVENT event,
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_event.h.old	2004-12-14 15:01:08.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_event.h	2004-12-14 15:01:13.000000000 +0100
@@ -75,7 +75,6 @@
 };
 
 extern char *ircomm_state[];
-extern char *ircomm_event[];
 
 struct ircomm_cb;   /* Forward decl. */
 
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_event.c.old	2004-12-14 15:01:21.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_event.c	2004-12-14 15:01:31.000000000 +0100
@@ -57,7 +57,7 @@
 	"IRCOMM_CONN",
 };
 
-char *ircomm_event[] = {
+static char *ircomm_event[] = {
 	"IRCOMM_CONNECT_REQUEST",
         "IRCOMM_CONNECT_RESPONSE",
         "IRCOMM_TTP_CONNECT_INDICATION",
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_lmp.h.old	2004-12-14 15:01:50.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_lmp.h	2004-12-14 15:08:50.000000000 +0100
@@ -32,34 +32,7 @@
 #define IRCOMM_LMP_H
 
 #include <net/irda/ircomm_core.h>
-#include <net/irda/ircomm_event.h>
 
 int ircomm_open_lsap(struct ircomm_cb *self);
-int  ircomm_lmp_connect_request(struct ircomm_cb *self, 
-				struct sk_buff *userdata, 
-				struct ircomm_info *info);
-int  ircomm_lmp_connect_response(struct ircomm_cb *self, struct sk_buff *skb);
-int  ircomm_lmp_disconnect_request(struct ircomm_cb *self, 
-				   struct sk_buff *userdata, 
-				   struct ircomm_info *info);
-int  ircomm_lmp_data_request(struct ircomm_cb *self, struct sk_buff *skb, 
-			     int clen);
-int  ircomm_lmp_control_request(struct ircomm_cb *self, 
-			       struct sk_buff *userdata);
-int  ircomm_lmp_data_indication(void *instance, void *sap,
-				struct sk_buff *skb);
-void ircomm_lmp_connect_confirm(void *instance, void *sap,
-				struct qos_info *qos, 
-				__u32 max_sdu_size, 
-				__u8 max_header_size,
-				struct sk_buff *skb);
-void ircomm_lmp_connect_indication(void *instance, void *sap,
-				   struct qos_info *qos,
-				   __u32 max_sdu_size,
-				   __u8 max_header_size,
-				   struct sk_buff *skb);
-void ircomm_lmp_disconnect_indication(void *instance, void *sap, 
-				      LM_REASON reason,
-				      struct sk_buff *skb);
 
 #endif
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_lmp.c.old	2004-12-14 15:02:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_lmp.c	2004-12-14 15:07:37.000000000 +0100
@@ -41,44 +41,6 @@
 #include <net/irda/ircomm_event.h>
 #include <net/irda/ircomm_lmp.h>
 
-/*
- * Function ircomm_open_lsap (self)
- *
- *    Open LSAP. This function will only be used when using "raw" services
- *
- */
-int ircomm_open_lsap(struct ircomm_cb *self)
-{
-	notify_t notify;
-	
-	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
-	
-        /* Register callbacks */
-        irda_notify_init(&notify);
-	notify.data_indication       = ircomm_lmp_data_indication;
-	notify.connect_confirm       = ircomm_lmp_connect_confirm;
-        notify.connect_indication    = ircomm_lmp_connect_indication;
-	notify.disconnect_indication = ircomm_lmp_disconnect_indication;
-	notify.instance = self;
-	strlcpy(notify.name, "IrCOMM", sizeof(notify.name));
-
-	self->lsap = irlmp_open_lsap(LSAP_ANY, &notify, 0);
-	if (!self->lsap) {
-		IRDA_DEBUG(0,"%sfailed to allocate tsap\n", __FUNCTION__ );
-		return -1;
-	}
-	self->slsap_sel = self->lsap->slsap_sel;
-
-	/*
-	 *  Initialize the call-table for issuing commands
-	 */
-	self->issue.data_request       = ircomm_lmp_data_request;
-	self->issue.connect_request    = ircomm_lmp_connect_request;
-	self->issue.connect_response   = ircomm_lmp_connect_response;
-	self->issue.disconnect_request = ircomm_lmp_disconnect_request;
-
-	return 0;
-}
 
 /*
  * Function ircomm_lmp_connect_request (self, userdata)
@@ -86,9 +48,9 @@
  *    
  *
  */
-int ircomm_lmp_connect_request(struct ircomm_cb *self, 
-			       struct sk_buff *userdata, 
-			       struct ircomm_info *info)
+static int ircomm_lmp_connect_request(struct ircomm_cb *self, 
+				      struct sk_buff *userdata, 
+				      struct ircomm_info *info)
 {
 	int ret = 0;
 
@@ -109,7 +71,8 @@
  *    
  *
  */
-int ircomm_lmp_connect_response(struct ircomm_cb *self, struct sk_buff *userdata)
+static int ircomm_lmp_connect_response(struct ircomm_cb *self,
+				       struct sk_buff *userdata)
 {
 	struct sk_buff *tx_skb;
 	int ret;
@@ -141,9 +104,9 @@
 	return 0;
 }
 
-int ircomm_lmp_disconnect_request(struct ircomm_cb *self, 
-				  struct sk_buff *userdata, 
-				  struct ircomm_info *info)
+static int ircomm_lmp_disconnect_request(struct ircomm_cb *self, 
+					 struct sk_buff *userdata, 
+					 struct ircomm_info *info)
 {
         struct sk_buff *tx_skb;
 	int ret;
@@ -175,7 +138,7 @@
  *    been deallocated. We do this to make sure we don't flood IrLAP with 
  *    frames, since we are not using the IrTTP flow control mechanism
  */
-void ircomm_lmp_flow_control(struct sk_buff *skb)
+static void ircomm_lmp_flow_control(struct sk_buff *skb)
 {
 	struct irda_skb_cb *cb;
 	struct ircomm_cb *self;
@@ -215,8 +178,9 @@
  *    Send data frame to peer device
  *
  */
-int ircomm_lmp_data_request(struct ircomm_cb *self, struct sk_buff *skb, 
-			    int not_used)
+static int ircomm_lmp_data_request(struct ircomm_cb *self,
+				   struct sk_buff *skb, 
+				   int not_used)
 {
 	struct irda_skb_cb *cb;
 	int ret;
@@ -256,8 +220,8 @@
  *    Incoming data which we must deliver to the state machine, to check
  *    we are still connected.
  */
-int ircomm_lmp_data_indication(void *instance, void *sap,
-			       struct sk_buff *skb)
+static int ircomm_lmp_data_indication(void *instance, void *sap,
+				      struct sk_buff *skb)
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 
@@ -282,11 +246,11 @@
  *    Connection has been confirmed by peer device
  *
  */
-void ircomm_lmp_connect_confirm(void *instance, void *sap,
-				struct qos_info *qos, 
-				__u32 max_seg_size, 
-				__u8 max_header_size,
-				struct sk_buff *skb)
+static void ircomm_lmp_connect_confirm(void *instance, void *sap,
+				       struct qos_info *qos, 
+				       __u32 max_seg_size, 
+				       __u8 max_header_size,
+				       struct sk_buff *skb)
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
@@ -315,11 +279,11 @@
  *    Peer device wants to make a connection with us
  *
  */
-void ircomm_lmp_connect_indication(void *instance, void *sap,
-				   struct qos_info *qos,
-				   __u32 max_seg_size,
-				   __u8 max_header_size,
-				   struct sk_buff *skb)
+static void ircomm_lmp_connect_indication(void *instance, void *sap,
+					  struct qos_info *qos,
+					  __u32 max_seg_size,
+					  __u8 max_header_size,
+					  struct sk_buff *skb)
 {
 	struct ircomm_cb *self = (struct ircomm_cb *)instance;
 	struct ircomm_info info;
@@ -347,9 +311,9 @@
  *    Peer device has closed the connection, or the link went down for some
  *    other reason
  */
-void ircomm_lmp_disconnect_indication(void *instance, void *sap, 
-				      LM_REASON reason,
-				      struct sk_buff *skb)
+static void ircomm_lmp_disconnect_indication(void *instance, void *sap, 
+					     LM_REASON reason,
+					     struct sk_buff *skb)
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
@@ -367,3 +331,41 @@
 	if(skb)
 		dev_kfree_skb(skb);
 }
+/*
+ * Function ircomm_open_lsap (self)
+ *
+ *    Open LSAP. This function will only be used when using "raw" services
+ *
+ */
+int ircomm_open_lsap(struct ircomm_cb *self)
+{
+	notify_t notify;
+	
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
+	
+        /* Register callbacks */
+        irda_notify_init(&notify);
+	notify.data_indication       = ircomm_lmp_data_indication;
+	notify.connect_confirm       = ircomm_lmp_connect_confirm;
+        notify.connect_indication    = ircomm_lmp_connect_indication;
+	notify.disconnect_indication = ircomm_lmp_disconnect_indication;
+	notify.instance = self;
+	strlcpy(notify.name, "IrCOMM", sizeof(notify.name));
+
+	self->lsap = irlmp_open_lsap(LSAP_ANY, &notify, 0);
+	if (!self->lsap) {
+		IRDA_DEBUG(0,"%sfailed to allocate tsap\n", __FUNCTION__ );
+		return -1;
+	}
+	self->slsap_sel = self->lsap->slsap_sel;
+
+	/*
+	 *  Initialize the call-table for issuing commands
+	 */
+	self->issue.data_request       = ircomm_lmp_data_request;
+	self->issue.connect_request    = ircomm_lmp_connect_request;
+	self->issue.connect_response   = ircomm_lmp_connect_response;
+	self->issue.disconnect_request = ircomm_lmp_disconnect_request;
+
+	return 0;
+}
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_param.h.old	2004-12-14 15:09:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_param.h	2004-12-14 15:09:17.000000000 +0100
@@ -141,7 +141,6 @@
 
 struct ircomm_tty_cb; /* Forward decl. */
 
-int ircomm_param_flush(struct ircomm_tty_cb *self);
 int ircomm_param_request(struct ircomm_tty_cb *self, __u8 pi, int flush);
 
 extern pi_param_info_t ircomm_param_info;
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_param.c.old	2004-12-14 15:09:26.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_param.c	2004-12-14 15:09:35.000000000 +0100
@@ -92,23 +92,6 @@
 pi_param_info_t ircomm_param_info = { pi_major_call_table, 3, 0x0f, 4 };
 
 /*
- * Function ircomm_param_flush (self)
- *
- *    Flush (send) out all queued parameters
- *
- */
-int ircomm_param_flush(struct ircomm_tty_cb *self)
-{
-	/* we should lock here, but I guess this function is unused...
-	 * Jean II */
-	if (self->ctrl_skb) {
-		ircomm_control_request(self->ircomm, self->ctrl_skb);
-		self->ctrl_skb = NULL;	
-	}
-	return 0;
-}
-
-/*
  * Function ircomm_param_request (self, pi, flush)
  *
  *    Queue a parameter for the control channel
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_ttp.h.old	2004-12-14 15:48:48.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_ttp.h	2004-12-14 15:53:48.000000000 +0100
@@ -32,39 +32,8 @@
 #define IRCOMM_TTP_H
 
 #include <net/irda/ircomm_core.h>
-#include <net/irda/ircomm_event.h>
 
 int  ircomm_open_tsap(struct ircomm_cb *self);
-int  ircomm_ttp_connect_request(struct ircomm_cb *self, 
-				struct sk_buff *userdata, 
-				struct ircomm_info *info);
-int  ircomm_ttp_connect_response(struct ircomm_cb *self, struct sk_buff *skb);
-int  ircomm_ttp_disconnect_request(struct ircomm_cb *self, 
-				   struct sk_buff *userdata, 
-				   struct ircomm_info *info);
-int  ircomm_ttp_data_request(struct ircomm_cb *self, struct sk_buff *skb, 
-			     int clen);
-int  ircomm_ttp_control_request(struct ircomm_cb *self, 
-			       struct sk_buff *userdata);
-int  ircomm_ttp_data_indication(void *instance, void *sap,
-				struct sk_buff *skb);
-void ircomm_ttp_connect_confirm(void *instance, void *sap,
-				struct qos_info *qos, 
-				__u32 max_sdu_size, 
-				__u8 max_header_size,
-				struct sk_buff *skb);
-void ircomm_ttp_connect_indication(void *instance, void *sap,
-				   struct qos_info *qos,
-				   __u32 max_sdu_size,
-				   __u8 max_header_size,
-				   struct sk_buff *skb);
-void ircomm_ttp_disconnect_indication(void *instance, void *sap, 
-				      LM_REASON reason,
-				      struct sk_buff *skb);
-void ircomm_ttp_flow_indication(void *instance, void *sap, LOCAL_FLOW cmd);
 
 #endif
 
-
-
-
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty.c.old	2004-12-14 15:54:14.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty.c	2004-12-14 15:55:16.000000000 +0100
@@ -64,6 +64,7 @@
 static void ircomm_tty_hangup(struct tty_struct *tty);
 static void ircomm_tty_do_softint(void *private_);
 static void ircomm_tty_shutdown(struct ircomm_tty_cb *self);
+static void ircomm_tty_stop(struct tty_struct *tty);
 
 static int ircomm_tty_data_indication(void *instance, void *sap,
 				      struct sk_buff *skb);
@@ -108,7 +109,7 @@
  *    Init IrCOMM TTY layer/driver
  *
  */
-int __init ircomm_tty_init(void)
+static int __init ircomm_tty_init(void)
 {
 	driver = alloc_tty_driver(IRCOMM_TTY_PORTS);
 	if (!driver)
@@ -159,7 +160,7 @@
  *    Remove IrCOMM TTY layer/driver
  *
  */
-void __exit ircomm_tty_cleanup(void)
+static void __exit ircomm_tty_cleanup(void)
 {
 	int ret;
 
@@ -1064,7 +1065,7 @@
  *     This routine notifies the tty driver that it should stop outputting
  *     characters to the tty device. 
  */
-void ircomm_tty_stop(struct tty_struct *tty) 
+static void ircomm_tty_stop(struct tty_struct *tty) 
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty_attach.c.old	2004-12-14 15:55:32.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty_attach.c	2004-12-14 15:56:39.000000000 +0100
@@ -52,8 +52,9 @@
 					    void *priv);
 static void ircomm_tty_getvalue_confirm(int result, __u16 obj_id, 
 					struct ias_value *value, void *priv);
-void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self, int timeout);
-void ircomm_tty_watchdog_timer_expired(void *data);
+static void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self,
+					    int timeout);
+static void ircomm_tty_watchdog_timer_expired(void *data);
 
 static int ircomm_tty_state_idle(struct ircomm_tty_cb *self, 
 				 IRCOMM_TTY_EVENT event, 
@@ -90,7 +91,7 @@
 	"*** ERROR *** ",
 };
 
-char *ircomm_tty_event[] = {
+static char *ircomm_tty_event[] = {
 	"IRCOMM_TTY_ATTACH_CABLE",
 	"IRCOMM_TTY_DETACH_CABLE",
 	"IRCOMM_TTY_DATA_REQUEST",
@@ -594,7 +595,8 @@
  *    connection attempt is successful, and if not, we will retry after 
  *    the timeout
  */
-void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self, int timeout)
+static void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self,
+					    int timeout)
 {
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -609,7 +611,7 @@
  *    Called when the connect procedure have taken to much time.
  *
  */
-void ircomm_tty_watchdog_timer_expired(void *data)
+static void ircomm_tty_watchdog_timer_expired(void *data)
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) data;
 	
--- linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_tty.h.old	2004-12-14 15:56:54.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/ircomm_tty.h	2004-12-14 21:18:10.000000000 +0100
@@ -118,10 +118,8 @@
 };
 
 void ircomm_tty_start(struct tty_struct *tty);
-void ircomm_tty_stop(struct tty_struct *tty);
 void ircomm_tty_check_modem_status(struct ircomm_tty_cb *self);
 
-extern void ircomm_tty_change_speed(struct ircomm_tty_cb *self);
 extern int ircomm_tty_tiocmget(struct tty_struct *tty, struct file *file);
 extern int ircomm_tty_tiocmset(struct tty_struct *tty, struct file *file,
 			       unsigned int set, unsigned int clear);
--- linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty_ioctl.c.old	2004-12-14 15:57:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/ircomm/ircomm_tty_ioctl.c	2004-12-14 15:57:22.000000000 +0100
@@ -53,7 +53,7 @@
  *    Change speed of the driver. If the remote device is a DCE, then this
  *    should make it change the speed of its serial port
  */
-void ircomm_tty_change_speed(struct ircomm_tty_cb *self)
+static void ircomm_tty_change_speed(struct ircomm_tty_cb *self)
 {
 	unsigned cflag, cval;
 	int baud;
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irda_device.h.old	2004-12-14 15:57:38.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irda_device.h	2004-12-14 15:58:11.000000000 +0100
@@ -227,8 +227,6 @@
 	return (skb_queue_len(&dev->qdisc->q) == 0);
 }
 int  irda_device_set_raw_mode(struct net_device* self, int status);
-int  irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts);
-int  irda_device_change_speed(struct net_device *dev, __u32 speed);
 struct net_device *alloc_irdadev(int sizeof_priv);
 
 /* Dongle interface */
--- linux-2.6.10-rc3-mm1-full/net/irda/irda_device.c.old	2004-12-14 15:57:51.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irda_device.c	2004-12-14 15:58:50.000000000 +0100
@@ -143,47 +143,6 @@
 EXPORT_SYMBOL(irda_device_set_media_busy);
 
 
-int irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts)
-{
-	struct if_irda_req req;
-	int ret;
-
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
-
-	if (!dev->do_ioctl) {
-		ERROR("%s: do_ioctl not impl. by device driver\n",
-				__FUNCTION__);
-		return -1;
-	}
-
-	req.ifr_dtr = dtr;
-	req.ifr_rts = rts;
-
-	ret = dev->do_ioctl(dev, (struct ifreq *) &req, SIOCSDTRRTS);
-
-	return ret;
-}
-
-int irda_device_change_speed(struct net_device *dev, __u32 speed)
-{
-	struct if_irda_req req;
-	int ret;
-
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
-
-	if (!dev->do_ioctl) {
-		ERROR("%s: do_ioctl not impl. by device driver\n",
-				__FUNCTION__);
-		return -1;
-	}
-
-	req.ifr_baudrate = speed;
-
-	ret = dev->do_ioctl(dev, (struct ifreq *) &req, SIOCSBANDWIDTH);
-
-	return ret;
-}
-
 /*
  * Function irda_device_is_receiving (dev)
  *
@@ -372,7 +331,7 @@
  *    This function should be used by low level device drivers in a similar way
  *    as ether_setup() is used by normal network device drivers
  */
-void irda_device_setup(struct net_device *dev)
+static void irda_device_setup(struct net_device *dev)
 {
         dev->hard_header_len = 0;
         dev->addr_len        = 0;
@@ -502,33 +461,6 @@
 }
 EXPORT_SYMBOL(irda_device_unregister_dongle);
 
-/*
- * Function irda_device_set_mode (self, mode)
- *
- *    Set the Infrared device driver into mode where it sends and receives
- *    data without using IrLAP framing. Check out the particular device
- *    driver to find out which modes it support.
- */
-int irda_device_set_mode(struct net_device* dev, int mode)
-{
-	struct if_irda_req req;
-	int ret;
-
-	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
-
-	if (!dev->do_ioctl) {
-		ERROR("%s: set_raw_mode not impl. by device driver\n",
-				__FUNCTION__);
-		return -1;
-	}
-
-	req.ifr_mode = mode;
-
-	ret = dev->do_ioctl(dev, (struct ifreq *) &req, SIOCSMODE);
-
-	return ret;
-}
-
 #ifdef CONFIG_ISA
 /*
  * Function setup_dma (idev, buffer, count, mode)
--- linux-2.6.10-rc3-mm1-full/include/net/irda/iriap.h.old	2004-12-14 16:00:41.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/iriap.h	2004-12-14 16:03:37.000000000 +0100
@@ -97,22 +97,12 @@
 int iriap_getvaluebyclass_request(struct iriap_cb *self, 
 				  __u32 saddr, __u32 daddr,
 				  char *name, char *attr);
-void iriap_getvaluebyclass_confirm(struct iriap_cb *self, struct sk_buff *skb);
 void iriap_connect_request(struct iriap_cb *self);
 void iriap_send_ack( struct iriap_cb *self);
 void iriap_call_indication(struct iriap_cb *self, struct sk_buff *skb);
 
 void iriap_register_server(void);
 
-void iriap_watchdog_timer_expired(void *data);
-
-static inline void iriap_start_watchdog_timer(struct iriap_cb *self, 
-					      int timeout) 
-{
-	irda_start_timer(&self->watchdog_timer, timeout, self, 
-			 iriap_watchdog_timer_expired);
-}
-
 #endif
 
 
--- linux-2.6.10-rc3-mm1-full/net/irda/iriap.c.old	2004-12-14 15:59:03.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/iriap.c	2004-12-14 20:27:40.000000000 +0100
@@ -77,6 +77,15 @@
 static int iriap_data_indication(void *instance, void *sap,
 				 struct sk_buff *skb);
 
+static void iriap_watchdog_timer_expired(void *data);
+
+static inline void iriap_start_watchdog_timer(struct iriap_cb *self, 
+					      int timeout) 
+{
+	irda_start_timer(&self->watchdog_timer, timeout, self, 
+			 iriap_watchdog_timer_expired);
+}
+
 /*
  * Function iriap_init (void)
  *
@@ -328,7 +337,7 @@
 /*
  * Function iriap_disconnect_request (handle)
  */
-void iriap_disconnect_request(struct iriap_cb *self)
+static void iriap_disconnect_request(struct iriap_cb *self)
 {
 	struct sk_buff *tx_skb;
 
@@ -352,31 +361,6 @@
 	irlmp_disconnect_request(self->lsap, tx_skb);
 }
 
-void iriap_getinfobasedetails_request(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
-}
-
-void iriap_getinfobasedetails_confirm(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
-}
-
-void iriap_getobjects_request(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
-}
-
-void iriap_getobjects_confirm(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
-}
-
-void iriap_getvalue(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
-}
-
 /*
  * Function iriap_getvaluebyclass (addr, name, attr)
  *
@@ -445,7 +429,8 @@
  *    to service user.
  *
  */
-void iriap_getvaluebyclass_confirm(struct iriap_cb *self, struct sk_buff *skb)
+static void iriap_getvaluebyclass_confirm(struct iriap_cb *self,
+					  struct sk_buff *skb)
 {
 	struct ias_value *value;
 	int charset;
@@ -552,8 +537,10 @@
  *    Send answer back to remote LM-IAS
  *
  */
-void iriap_getvaluebyclass_response(struct iriap_cb *self, __u16 obj_id,
-				    __u8 ret_code, struct ias_value *value)
+static void iriap_getvaluebyclass_response(struct iriap_cb *self,
+					   __u16 obj_id,
+					   __u8 ret_code,
+					   struct ias_value *value)
 {
 	struct sk_buff *tx_skb;
 	int n;
@@ -641,8 +628,8 @@
  *    getvaluebyclass is requested from peer LM-IAS
  *
  */
-void iriap_getvaluebyclass_indication(struct iriap_cb *self,
-				      struct sk_buff *skb)
+static void iriap_getvaluebyclass_indication(struct iriap_cb *self,
+					     struct sk_buff *skb)
 {
 	struct ias_object *obj;
 	struct ias_attrib *attrib;
@@ -962,7 +949,7 @@
  *    Query has taken too long time, so abort
  *
  */
-void iriap_watchdog_timer_expired(void *data)
+static void iriap_watchdog_timer_expired(void *data)
 {
 	struct iriap_cb *self = (struct iriap_cb *) data;
 
--- linux-2.6.10-rc3-mm1-full/net/irda/irias_object.c.old	2004-12-14 16:03:56.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irias_object.c	2004-12-14 16:04:32.000000000 +0100
@@ -116,7 +116,7 @@
  *    Delete given attribute and deallocate all its memory
  *
  */
-void __irias_delete_attrib(struct ias_attrib *attrib)
+static void __irias_delete_attrib(struct ias_attrib *attrib)
 {
 	ASSERT(attrib != NULL, return;);
 	ASSERT(attrib->magic == IAS_ATTRIB_MAGIC, return;);
@@ -267,8 +267,8 @@
  *    Add attribute to object
  *
  */
-void irias_add_attrib( struct ias_object *obj, struct ias_attrib *attrib,
-		       int owner)
+static void irias_add_attrib(struct ias_object *obj, struct ias_attrib *attrib,
+			     int owner)
 {
 	ASSERT(obj != NULL, return;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irlan_client.h.old	2004-12-14 19:55:15.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irlan_client.h	2004-12-14 19:57:02.000000000 +0100
@@ -33,12 +33,9 @@
 #include <net/irda/irias_object.h>
 #include <net/irda/irlan_event.h>
 
-void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout);
 void irlan_client_discovery_indication(discinfo_t *, DISCOVERY_MODE, void *);
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr);
 
-void irlan_client_open_ctrl_tsap( struct irlan_cb *self);
-
 void irlan_client_parse_response(struct irlan_cb *self, struct sk_buff *skb);
 void irlan_client_get_value_confirm(int result, __u16 obj_id, 
 				    struct ias_value *value, void *priv);
--- linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_client.c.old	2004-12-14 19:55:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_client.c	2004-12-14 19:57:08.000000000 +0100
@@ -66,6 +66,7 @@
 					      struct sk_buff *);
 static void irlan_check_response_param(struct irlan_cb *self, char *param, 
 				       char *value, int val_len);
+static void irlan_client_open_ctrl_tsap(struct irlan_cb *self);
 
 static void irlan_client_kick_timer_expired(void *data)
 {
@@ -88,7 +89,7 @@
 	}
 }
 
-void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout)
+static void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout)
 {
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__ );
 	
@@ -248,7 +249,7 @@
  *    Initialize callbacks and open IrTTP TSAPs
  *
  */
-void irlan_client_open_ctrl_tsap(struct irlan_cb *self)
+static void irlan_client_open_ctrl_tsap(struct irlan_cb *self)
 {
 	struct tsap_cb *tsap;
 	notify_t notify;
@@ -309,42 +310,6 @@
 }
 
 /*
- * Function irlan_client_reconnect_data_channel (self)
- *
- *    Try to reconnect data channel (currently not used)
- *
- */
-void irlan_client_reconnect_data_channel(struct irlan_cb *self) 
-{
-	struct sk_buff *skb;
-	__u8 *frame;
-		
-	IRDA_DEBUG(4, "%s()\n", __FUNCTION__ );
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRLAN_MAGIC, return;);
-	
-	skb = dev_alloc_skb(128);
-	if (!skb)
-		return;
-
-	/* Reserve space for TTP, LMP, and LAP header */
-	skb_reserve(skb, self->max_header_size);
-	skb_put(skb, 2);
-	
-	frame = skb->data;
-	
- 	frame[0] = CMD_RECONNECT_DATA_CHAN;
-	frame[1] = 0x01;
- 	irlan_insert_array_param(skb, "RECONNECT_KEY", 
-				 self->client.reconnect_key,
-				 self->client.key_len);
-	
-	irttp_data_request(self->client.tsap_ctrl, skb);	
-}
-
-
-/*
  * Function print_ret_code (code)
  *
  *    Print return code of request to peer IrLAN layer.
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irlan_common.h.old	2004-12-14 20:00:16.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irlan_common.h	2004-12-14 20:01:40.000000000 +0100
@@ -190,7 +190,6 @@
 	struct timer_list watchdog_timer;
 };
 
-struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr);
 void irlan_close(struct irlan_cb *self);
 void irlan_close_tsaps(struct irlan_cb *self);
 
@@ -204,13 +203,11 @@
 
 struct irlan_cb *irlan_get_any(void);
 void irlan_get_provider_info(struct irlan_cb *self);
-void irlan_get_unicast_addr(struct irlan_cb *self);
 void irlan_get_media_char(struct irlan_cb *self);
 void irlan_open_data_channel(struct irlan_cb *self);
 void irlan_close_data_channel(struct irlan_cb *self);
 void irlan_set_multicast_filter(struct irlan_cb *self, int status);
 void irlan_set_broadcast_filter(struct irlan_cb *self, int status);
-void irlan_open_unicast_addr(struct irlan_cb *self);
 
 int irlan_insert_byte_param(struct sk_buff *skb, char *param, __u8 value);
 int irlan_insert_short_param(struct sk_buff *skb, char *param, __u16 value);
--- linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_common.c.old	2004-12-14 19:57:23.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_common.c	2004-12-14 20:02:09.000000000 +0100
@@ -105,10 +105,13 @@
 extern struct proc_dir_entry *proc_irda;
 #endif /* CONFIG_PROC_FS */
 
+static struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr);
 static void __irlan_close(struct irlan_cb *self);
 static int __irlan_insert_param(struct sk_buff *skb, char *param, int type, 
 				__u8 value_byte, __u16 value_short, 
 				__u8 *value_array, __u16 value_len);
+static void irlan_open_unicast_addr(struct irlan_cb *self);
+static void irlan_get_unicast_addr(struct irlan_cb *self);
 void irlan_close_tsaps(struct irlan_cb *self);
 
 /*
@@ -185,7 +188,7 @@
  *    Open new instance of a client/provider, we should only register the 
  *    network device if this instance is ment for a particular client/provider
  */
-struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr)
+static struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr)
 {
 	struct net_device *dev;
 	struct irlan_cb *self;
@@ -294,9 +297,11 @@
  *    Here we receive the connect indication for the data channel
  *
  */
-void irlan_connect_indication(void *instance, void *sap, struct qos_info *qos,
-			      __u32 max_sdu_size, __u8 max_header_size, 
-			      struct sk_buff *skb)
+static void irlan_connect_indication(void *instance, void *sap,
+				     struct qos_info *qos,
+				     __u32 max_sdu_size,
+				     __u8 max_header_size, 
+				     struct sk_buff *skb)
 {
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
@@ -339,9 +344,11 @@
 	netif_start_queue(self->dev); /* Clear reason */
 }
 
-void irlan_connect_confirm(void *instance, void *sap, struct qos_info *qos, 
-			   __u32 max_sdu_size, __u8 max_header_size, 
-			   struct sk_buff *skb) 
+static void irlan_connect_confirm(void *instance, void *sap,
+				  struct qos_info *qos, 
+				  __u32 max_sdu_size,
+				  __u8 max_header_size, 
+				  struct sk_buff *skb) 
 {
 	struct irlan_cb *self;
 
@@ -384,8 +391,9 @@
  *    Callback function for the IrTTP layer. Indicates a disconnection of
  *    the specified connection (handle)
  */
-void irlan_disconnect_indication(void *instance, void *sap, LM_REASON reason, 
-				 struct sk_buff *userdata) 
+static void irlan_disconnect_indication(void *instance,
+					void *sap, LM_REASON reason, 
+					struct sk_buff *userdata) 
 {
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
@@ -602,7 +610,7 @@
  *    This function makes sure that commands on the control channel is being
  *    sent in a command/response fashion
  */
-void irlan_ctrl_data_request(struct irlan_cb *self, struct sk_buff *skb)
+static void irlan_ctrl_data_request(struct irlan_cb *self, struct sk_buff *skb)
 {
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
@@ -722,7 +730,7 @@
  *    address.
  *
  */
-void irlan_open_unicast_addr(struct irlan_cb *self) 
+static void irlan_open_unicast_addr(struct irlan_cb *self)
 {
 	struct sk_buff *skb;
 	__u8 *frame;
@@ -839,7 +847,7 @@
  *    can construct its packets.
  *
  */
-void irlan_get_unicast_addr(struct irlan_cb *self) 
+static void irlan_get_unicast_addr(struct irlan_cb *self)
 {
 	struct sk_buff *skb;
 	__u8 *frame;
--- linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_provider.c.old	2004-12-14 20:02:39.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlan/irlan_provider.c	2004-12-14 20:02:59.000000000 +0100
@@ -175,9 +175,9 @@
 	irttp_connect_response(tsap, IRLAN_MTU, NULL);
 }
 
-void irlan_provider_disconnect_indication(void *instance, void *sap, 
-					  LM_REASON reason, 
-					  struct sk_buff *userdata) 
+static void irlan_provider_disconnect_indication(void *instance, void *sap, 
+						 LM_REASON reason, 
+						 struct sk_buff *userdata) 
 {
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irlap.h.old	2004-12-14 20:03:18.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irlap.h	2004-12-14 20:03:59.000000000 +0100
@@ -253,10 +253,8 @@
 int  irlap_generate_rand_time_slot(int S, int s);
 void irlap_initiate_connection_state(struct irlap_cb *);
 void irlap_flush_all_queues(struct irlap_cb *);
-void irlap_change_speed(struct irlap_cb *self, __u32 speed, int now);
 void irlap_wait_min_turn_around(struct irlap_cb *, struct qos_info *);
 
-void irlap_init_qos_capabilities(struct irlap_cb *, struct qos_info *);
 void irlap_apply_default_connection_parameters(struct irlap_cb *self);
 void irlap_apply_connection_parameters(struct irlap_cb *self, int now);
 
--- linux-2.6.10-rc3-mm1-full/net/irda/irlap.c.old	2004-12-14 20:03:35.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlap.c	2004-12-14 20:04:24.000000000 +0100
@@ -60,6 +60,8 @@
 
 extern void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 static void __irlap_close(struct irlap_cb *self);
+static void irlap_init_qos_capabilities(struct irlap_cb *self,
+					struct qos_info *qos_user);
 
 #ifdef CONFIG_IRDA_DEBUG
 static char *lap_reasons[] = {
@@ -867,7 +869,7 @@
  *    Change the speed of the IrDA port
  *
  */
-void irlap_change_speed(struct irlap_cb *self, __u32 speed, int now)
+static void irlap_change_speed(struct irlap_cb *self, __u32 speed, int now)
 {
 	struct sk_buff *skb;
 
@@ -894,8 +896,8 @@
  *    IrLAP itself. Normally, IrLAP will not specify any values, but it can
  *    be used to restrict certain values.
  */
-void irlap_init_qos_capabilities(struct irlap_cb *self,
-				 struct qos_info *qos_user)
+static void irlap_init_qos_capabilities(struct irlap_cb *self,
+					struct qos_info *qos_user)
 {
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
--- linux-2.6.10-rc3-mm1-full/net/irda/irlap_event.c.old	2004-12-14 20:04:40.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlap_event.c	2004-12-14 20:04:50.000000000 +0100
@@ -181,7 +181,7 @@
  * Make sure that state is XMIT_P/XMIT_S when calling this function
  * (and that nobody messed up with the state). - Jean II
  */
-void irlap_start_poll_timer(struct irlap_cb *self, int timeout)
+static void irlap_start_poll_timer(struct irlap_cb *self, int timeout)
 {
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irlap_frame.h.old	2004-12-14 20:05:31.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irlap_frame.h	2004-12-14 20:05:39.000000000 +0100
@@ -133,7 +133,6 @@
 void irlap_resend_rejected_frames(struct irlap_cb *, int command);
 void irlap_resend_rejected_frame(struct irlap_cb *self, int command);
 
-void irlap_send_i_frame(struct irlap_cb *, struct sk_buff *, int command);
 void irlap_send_ui_frame(struct irlap_cb *self, struct sk_buff *skb,
 			 __u8 caddr, int command);
 
--- linux-2.6.10-rc3-mm1-full/net/irda/irlap_frame.c.old	2004-12-14 20:05:04.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlap_frame.c	2004-12-14 20:06:11.000000000 +0100
@@ -43,6 +43,9 @@
 #include <net/irda/irlap_frame.h>
 #include <net/irda/qos.h>
 
+static void irlap_send_i_frame(struct irlap_cb *self, struct sk_buff *skb,
+			       int command);
+
 /*
  * Function irlap_insert_info (self, skb)
  *
@@ -629,34 +632,6 @@
 		irlap_do_event(self, RECV_RR_RSP, skb, info);
 }
 
-void irlap_send_frmr_frame( struct irlap_cb *self, int command)
-{
-	struct sk_buff *tx_skb = NULL;
-	__u8 *frame;
-
-	ASSERT( self != NULL, return;);
-	ASSERT( self->magic == LAP_MAGIC, return;);
-
-	tx_skb = dev_alloc_skb( 32);
-	if (!tx_skb)
-		return;
-
-	frame = skb_put(tx_skb, 2);
-
-	frame[0] = self->caddr;
-	frame[0] |= (command) ? CMD_FRAME : 0;
-
-	frame[1]  = (self->vs << 1);
-	frame[1] |= PF_BIT;
-	frame[1] |= (self->vr << 5);
-
-	frame[2] = 0;
-
-	IRDA_DEBUG(4, "%s(), vr=%d, %ld\n", __FUNCTION__, self->vr, jiffies);
-
-	irlap_queue_xmit(self, tx_skb);
-}
-
 /*
  * Function irlap_recv_rnr_frame (self, skb, info)
  *
@@ -1129,8 +1104,8 @@
  *
  *    Contruct and transmit Information (I) frame
  */
-void irlap_send_i_frame(struct irlap_cb *self, struct sk_buff *skb,
-			int command)
+static void irlap_send_i_frame(struct irlap_cb *self, struct sk_buff *skb,
+			       int command)
 {
 	/* Insert connection address */
 	skb->data[0] = self->caddr;
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irlmp.h.old	2004-12-14 20:06:30.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irlmp.h	2004-12-14 20:08:40.000000000 +0100
@@ -242,12 +242,9 @@
 void irlmp_connless_data_indication(struct lsap_cb *, struct sk_buff *);
 #endif /* CONFIG_IRDA_ULTRA */
 
-void irlmp_status_request(void);
 void irlmp_status_indication(struct lap_cb *, LINK_STATUS link, LOCK_STATUS lock);
 void irlmp_flow_indication(struct lap_cb *self, LOCAL_FLOW flow);
 
-int  irlmp_slsap_inuse(__u8 slsap);
-__u8 irlmp_find_free_slsap(void);
 LM_REASON irlmp_convert_lap_reason(LAP_REASON);
 
 static inline __u32 irlmp_get_saddr(const struct lsap_cb *self)
--- linux-2.6.10-rc3-mm1-full/net/irda/irlmp.c.old	2004-12-14 20:06:48.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irlmp.c	2004-12-14 20:08:45.000000000 +0100
@@ -44,6 +44,9 @@
 #include <net/irda/irlmp.h>
 #include <net/irda/irlmp_frame.h>
 
+static __u8 irlmp_find_free_slsap(void);
+static int irlmp_slsap_inuse(__u8 slsap_sel);
+
 /* Master structure */
 struct irlmp_cb *irlmp = NULL;
 
@@ -1278,11 +1281,6 @@
 }
 #endif /* CONFIG_IRDA_ULTRA */
 
-void irlmp_status_request(void)
-{
-	IRDA_DEBUG(0, "%s(), Not implemented\n", __FUNCTION__);
-}
-
 /*
  * Propagate status indication from LAP to LSAPs (via LMP)
  * This don't trigger any change of state in lap_cb, lmp_cb or lsap_cb,
@@ -1656,7 +1654,7 @@
  * of the allocated LSAP, but I'm not sure the complexity is worth it.
  * Jean II
  */
-int irlmp_slsap_inuse(__u8 slsap_sel)
+static int irlmp_slsap_inuse(__u8 slsap_sel)
 {
 	struct lsap_cb *self;
 	struct lap_cb *lap;
@@ -1756,7 +1754,7 @@
  *    Find a free source LSAP to use. This function is called if the service
  *    user has requested a source LSAP equal to LM_ANY
  */
-__u8 irlmp_find_free_slsap(void)
+static __u8 irlmp_find_free_slsap(void)
 {
 	__u8 lsap_sel;
 	int wrapped = 0;
--- linux-2.6.10-rc3-mm1-full/net/irda/irmod.c.old	2004-12-14 20:09:01.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irmod.c	2004-12-14 20:09:41.000000000 +0100
@@ -100,7 +100,7 @@
  *  Protocol stack initialisation entry point.
  *  Initialise the various components of the IrDA stack
  */
-int __init irda_init(void)
+static int __init irda_init(void)
 {
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
@@ -136,7 +136,7 @@
  *  Protocol stack cleanup/removal entry point.
  *  Cleanup the various components of the IrDA stack
  */
-void __exit irda_cleanup(void)
+static void __exit irda_cleanup(void)
 {
 	/* Remove External APIs */
 #ifdef CONFIG_SYSCTL
--- linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet.h.old	2004-12-14 20:11:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet.h	2004-12-14 21:13:58.000000000 +0100
@@ -520,8 +520,6 @@
 /* ---------------------------- MODULE ---------------------------- */
 extern int
 	irnet_init(void);		/* Initialise IrNET module */
-extern void
-	irnet_cleanup(void);		/* Teardown IrNET module */
 
 /**************************** VARIABLES ****************************/
 
--- linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet_ppp.h.old	2004-12-14 20:12:15.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet_ppp.h	2004-12-14 20:12:54.000000000 +0100
@@ -116,11 +116,4 @@
 	&irnet_device_fops
 };
 
-/* Generic PPP callbacks (to call us) */
-struct ppp_channel_ops irnet_ppp_ops =
-{
-  ppp_irnet_send,
-  ppp_irnet_ioctl
-};
-
 #endif /* IRNET_PPP_H */
--- linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet_ppp.c.old	2004-12-14 20:10:30.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irnet/irnet_ppp.c	2004-12-14 20:12:50.000000000 +0100
@@ -16,6 +16,13 @@
 #include "irnet_ppp.h"		/* Private header */
 /* Please put other headers in irnet.h - Thanks */
 
+/* Generic PPP callbacks (to call us) */
+static struct ppp_channel_ops irnet_ppp_ops =
+{
+  ppp_irnet_send,
+  ppp_irnet_ioctl
+};
+
 /************************* CONTROL CHANNEL *************************/
 /*
  * When a pppd instance is not active on /dev/irnet, it acts as a control
@@ -1095,7 +1102,7 @@
 /*
  * Module exit
  */
-void __exit
+static void __exit
 irnet_cleanup(void)
 {
   irda_irnet_cleanup();
--- linux-2.6.10-rc3-mm1-full/net/irda/irsysctl.c.old	2004-12-14 20:13:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irsysctl.c	2004-12-14 20:13:17.000000000 +0100
@@ -43,7 +43,6 @@
 extern int  sysctl_discovery_timeout;
 extern int  sysctl_slot_timeout;
 extern int  sysctl_fast_poll_increase;
-int         sysctl_compression = 0;
 extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
 extern int  sysctl_min_tx_turn_time;
--- linux-2.6.10-rc3-mm1-full/include/net/irda/irttp.h.old	2004-12-14 20:14:11.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/irttp.h	2004-12-14 20:14:53.000000000 +0100
@@ -167,9 +167,6 @@
 int irttp_disconnect_request(struct tsap_cb *self, struct sk_buff *skb,
 			     int priority);
 void irttp_flow_request(struct tsap_cb *self, LOCAL_FLOW flow);
-void irttp_status_indication(void *instance,
-			     LINK_STATUS link, LOCK_STATUS lock);
-void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow);
 struct tsap_cb *irttp_dup(struct tsap_cb *self, void *instance);
 
 static __inline __u32 irttp_get_saddr(struct tsap_cb *self)
--- linux-2.6.10-rc3-mm1-full/net/irda/irttp.c.old	2004-12-14 20:13:41.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/irttp.c	2004-12-14 20:15:23.000000000 +0100
@@ -64,6 +64,10 @@
 static int irttp_param_max_sdu_size(void *instance, irda_param_t *param, 
 				    int get);
 
+static void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow);
+static void irttp_status_indication(void *instance,
+				    LINK_STATUS link, LOCK_STATUS lock);
+
 /* Information for parsing parameters in IrTTP */
 static pi_minor_info_t pi_minor_call_table[] = {
 	{ NULL, 0 },                                             /* 0x00 */
@@ -961,8 +965,8 @@
  *    Status_indication, just pass to the higher layer...
  *
  */
-void irttp_status_indication(void *instance,
-			     LINK_STATUS link, LOCK_STATUS lock)
+static void irttp_status_indication(void *instance,
+				    LINK_STATUS link, LOCK_STATUS lock)
 {
 	struct tsap_cb *self;
 
@@ -993,7 +997,7 @@
  *    Flow_indication : IrLAP tells us to send more data.
  *
  */
-void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow)
+static void irttp_flow_indication(void *instance, void *sap, LOCAL_FLOW flow)
 {
 	struct tsap_cb *self;
 
@@ -1613,7 +1617,7 @@
  *    for some reason should fail. We mark rx sdu as busy to apply back
  *    pressure is necessary.
  */
-void irttp_do_data_indication(struct tsap_cb *self, struct sk_buff *skb)
+static void irttp_do_data_indication(struct tsap_cb *self, struct sk_buff *skb)
 {
 	int err;
 
--- linux-2.6.10-rc3-mm1-full/include/net/irda/parameters.h.old	2004-12-14 20:15:45.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/parameters.h	2004-12-14 20:17:01.000000000 +0100
@@ -90,11 +90,9 @@
 } pi_param_info_t;
 
 int irda_param_pack(__u8 *buf, char *fmt, ...);
-int irda_param_unpack(__u8 *buf, char *fmt, ...);
 
 int irda_param_insert(void *self, __u8 pi, __u8 *buf, int len, 
 		      pi_param_info_t *info);
-int irda_param_extract(void *self, __u8 *buf, int len, pi_param_info_t *info);
 int irda_param_extract_all(void *self, __u8 *buf, int len, 
 			   pi_param_info_t *info);
 
--- linux-2.6.10-rc3-mm1-full/net/irda/parameters.c.old	2004-12-14 20:16:01.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/parameters.c	2004-12-14 20:17:28.000000000 +0100
@@ -51,6 +51,8 @@
 static int irda_insert_no_value(void *self, __u8 *buf, int len, __u8 pi,
 				PV_TYPE type, PI_HANDLER func);
 
+static int irda_param_unpack(__u8 *buf, char *fmt, ...);
+
 /* Parameter value call table. Must match PV_TYPE */
 static PV_HANDLER pv_extract_table[] = {
 	irda_extract_integer, /* Handler for any length integers */
@@ -400,7 +402,7 @@
 /*
  * Function irda_param_unpack (skb, fmt, ...)
  */
-int irda_param_unpack(__u8 *buf, char *fmt, ...)
+static int irda_param_unpack(__u8 *buf, char *fmt, ...)
 {
 	irda_pv_t arg;
 	va_list args;
@@ -440,7 +442,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(irda_param_unpack);
 
 /*
  * Function irda_param_insert (self, pi, buf, len, info)
@@ -496,13 +497,14 @@
 EXPORT_SYMBOL(irda_param_insert);
 
 /*
- * Function irda_param_extract_all (self, buf, len, info)
+ * Function irda_param_extract (self, buf, len, info)
  *
  *    Parse all parameters. If len is correct, then everything should be
  *    safe. Returns the number of bytes that was parsed
  *
  */
-int irda_param_extract(void *self, __u8 *buf, int len, pi_param_info_t *info)
+static int irda_param_extract(void *self, __u8 *buf, int len,
+			      pi_param_info_t *info)
 {
 	pi_minor_info_t *pi_minor_info;
 	__u8 pi_minor;
@@ -549,7 +551,6 @@
 						  type, pi_minor_info->func);
 	return ret;
 }
-EXPORT_SYMBOL(irda_param_extract);
 
 /*
  * Function irda_param_extract_all (self, buf, len, info)
--- linux-2.6.10-rc3-mm1-full/include/net/irda/qos.h.old	2004-12-14 20:18:19.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/irda/qos.h	2004-12-14 20:18:30.000000000 +0100
@@ -87,7 +87,6 @@
 void irda_qos_compute_intersection(struct qos_info *, struct qos_info *);
 
 __u32 irlap_max_line_capacity(__u32 speed, __u32 max_turn_time);
-__u32 irlap_requested_line_capacity(struct qos_info *qos);
 
 void irda_qos_bits_to_value(struct qos_info *qos);
 
--- linux-2.6.10-rc3-mm1-full/net/irda/qos.c.old	2004-12-14 20:17:41.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/irda/qos.c	2004-12-14 21:17:36.000000000 +0100
@@ -96,6 +96,10 @@
 static int irlap_param_min_turn_time(void *instance, irda_param_t *param, 
 				     int get);
 
+#ifndef CONFIG_IRDA_DYNAMIC_WINDOW
+static __u32 irlap_requested_line_capacity(struct qos_info *qos);
+#endif
+
 static __u32 min_turn_times[]  = { 10000, 5000, 1000, 500, 100, 50, 10, 0 }; /* us */
 static __u32 baud_rates[]      = { 2400, 9600, 19200, 38400, 57600, 115200, 576000, 
 				   1152000, 4000000, 16000000 };           /* bps */
@@ -333,7 +337,7 @@
  *     Adjust QoS settings in case some values are not possible to use because
  *     of other settings
  */
-void irlap_adjust_qos_settings(struct qos_info *qos)
+static void irlap_adjust_qos_settings(struct qos_info *qos)
 {
 	__u32 line_capacity;
 	int index;
@@ -723,7 +727,8 @@
 	return line_capacity;
 }
 
-__u32 irlap_requested_line_capacity(struct qos_info *qos)
+#ifndef CONFIG_IRDA_DYNAMIC_WINDOW
+static __u32 irlap_requested_line_capacity(struct qos_info *qos)
 {	__u32 line_capacity;
 	
 	line_capacity = qos->window_size.value * 
@@ -736,6 +741,7 @@
 	
 	return line_capacity;			       		  
 }
+#endif
 
 void irda_qos_bits_to_value(struct qos_info *qos)
 {

