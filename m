Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWD1Pm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWD1Pm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWD1Pm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:42:29 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:32238 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1030434AbWD1Pm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:42:28 -0400
Date: Fri, 28 Apr 2006 17:42:23 +0200
From: Peter Hagervall <hager@cs.umu.se>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Sparse fixes for synclink_cs
Message-ID: <20060428154223.GA12661@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark a few non-exported functions static.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

---

 synclink_cs.c |   54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)


diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 0721345..0c141c2 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -844,7 +844,7 @@ static int bh_action(MGSLPC_INFO *info)
 	return rc;
 }
 
-void bh_handler(void* Context)
+static void bh_handler(void* Context)
 {
 	MGSLPC_INFO *info = (MGSLPC_INFO*)Context;
 	int action;
@@ -888,7 +888,7 @@ void bh_handler(void* Context)
 			__FILE__,__LINE__,info->device_name);
 }
 
-void bh_transmit(MGSLPC_INFO *info)
+static void bh_transmit(MGSLPC_INFO *info)
 {
 	struct tty_struct *tty = info->tty;
 	if (debug_level >= DEBUG_LEVEL_BH)
@@ -900,7 +900,7 @@ void bh_transmit(MGSLPC_INFO *info)
 	}
 }
 
-void bh_status(MGSLPC_INFO *info)
+static void bh_status(MGSLPC_INFO *info)
 {
 	info->ri_chkcount = 0;
 	info->dsr_chkcount = 0;
@@ -2305,7 +2305,7 @@ static int mgslpc_ioctl(struct tty_struc
 	return ioctl_common(info, cmd, arg);
 }
 
-int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg)
+static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg)
 {
 	int error;
 	struct mgsl_icount cnow;	/* kernel counter temps */
@@ -2877,7 +2877,7 @@ done:
 	return ((count < begin+len-off) ? count : begin+len-off);
 }
 
-int rx_alloc_buffers(MGSLPC_INFO *info)
+static int rx_alloc_buffers(MGSLPC_INFO *info)
 {
 	/* each buffer has header and data */
 	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
@@ -2900,13 +2900,13 @@ int rx_alloc_buffers(MGSLPC_INFO *info)
 	return 0;
 }
 
-void rx_free_buffers(MGSLPC_INFO *info)
+static void rx_free_buffers(MGSLPC_INFO *info)
 {
 	kfree(info->rx_buf);
 	info->rx_buf = NULL;
 }
 
-int claim_resources(MGSLPC_INFO *info)
+static int claim_resources(MGSLPC_INFO *info)
 {
 	if (rx_alloc_buffers(info) < 0 ) {
 		printk( "Cant allocate rx buffer %s\n", info->device_name);
@@ -2916,7 +2916,7 @@ int claim_resources(MGSLPC_INFO *info)
 	return 0;
 }
 
-void release_resources(MGSLPC_INFO *info)
+static void release_resources(MGSLPC_INFO *info)
 {
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("release_resources(%s)\n", info->device_name);
@@ -2928,7 +2928,7 @@ void release_resources(MGSLPC_INFO *info
  * 	
  * Arguments:		info	pointer to device instance data
  */
-void mgslpc_add_device(MGSLPC_INFO *info)
+static void mgslpc_add_device(MGSLPC_INFO *info)
 {
 	info->next_device = NULL;
 	info->line = mgslpc_device_count;
@@ -2964,7 +2964,7 @@ #ifdef CONFIG_HDLC
 #endif
 }
 
-void mgslpc_remove_device(MGSLPC_INFO *remove_info)
+static void mgslpc_remove_device(MGSLPC_INFO *remove_info)
 {
 	MGSLPC_INFO *info = mgslpc_device_list;
 	MGSLPC_INFO *last = NULL;
@@ -3257,7 +3257,7 @@ static void loopback_enable(MGSLPC_INFO 
 	write_reg(info, CHA + MODE, val);
 }
 
-void hdlc_mode(MGSLPC_INFO *info)
+static void hdlc_mode(MGSLPC_INFO *info)
 {
 	unsigned char val;
 	unsigned char clkmode, clksubmode;
@@ -3497,7 +3497,7 @@ void hdlc_mode(MGSLPC_INFO *info)
 	rx_stop(info);
 }
 
-void rx_stop(MGSLPC_INFO *info)
+static void rx_stop(MGSLPC_INFO *info)
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):rx_stop(%s)\n",
@@ -3510,7 +3510,7 @@ void rx_stop(MGSLPC_INFO *info)
 	info->rx_overflow = 0;
 }
 
-void rx_start(MGSLPC_INFO *info)
+static void rx_start(MGSLPC_INFO *info)
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):rx_start(%s)\n",
@@ -3526,7 +3526,7 @@ void rx_start(MGSLPC_INFO *info)
 	info->rx_enabled = 1;
 }
 
-void tx_start(MGSLPC_INFO *info)
+static void tx_start(MGSLPC_INFO *info)
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):tx_start(%s)\n",
@@ -3564,7 +3564,7 @@ void tx_start(MGSLPC_INFO *info)
 		info->tx_enabled = 1;
 }
 
-void tx_stop(MGSLPC_INFO *info)
+static void tx_stop(MGSLPC_INFO *info)
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):tx_stop(%s)\n",
@@ -3578,7 +3578,7 @@ void tx_stop(MGSLPC_INFO *info)
 
 /* Reset the adapter to a known state and prepare it for further use.
  */
-void reset_device(MGSLPC_INFO *info)
+static void reset_device(MGSLPC_INFO *info)
 {
 	/* power up both channels (set BIT7) */ 
 	write_reg(info, CHA + CCR0, 0x80);
@@ -3628,7 +3628,7 @@ void reset_device(MGSLPC_INFO *info)
 	write_reg(info, IPC, 0x05);
 }
 
-void async_mode(MGSLPC_INFO *info)
+static void async_mode(MGSLPC_INFO *info)
 {
 	unsigned char val;
 
@@ -3799,7 +3799,7 @@ void async_mode(MGSLPC_INFO *info)
 
 /* Set the HDLC idle mode for the transmitter.
  */
-void tx_set_idle(MGSLPC_INFO *info)
+static void tx_set_idle(MGSLPC_INFO *info)
 {
 	/* Note: ESCC2 only supports flags and one idle modes */ 
 	if (info->idle_mode == HDLC_TXIDLE_FLAGS)
@@ -3810,7 +3810,7 @@ void tx_set_idle(MGSLPC_INFO *info)
 
 /* get state of the V24 status (input) signals.
  */
-void get_signals(MGSLPC_INFO *info)
+static void get_signals(MGSLPC_INFO *info)
 {
 	unsigned char status = 0;
 	
@@ -3832,7 +3832,7 @@ void get_signals(MGSLPC_INFO *info)
 /* Set the state of DTR and RTS based on contents of
  * serial_signals member of device extension.
  */
-void set_signals(MGSLPC_INFO *info)
+static void set_signals(MGSLPC_INFO *info)
 {
 	unsigned char val;
 
@@ -3856,7 +3856,7 @@ void set_signals(MGSLPC_INFO *info)
 		set_reg_bits(info, CHA + PVR, PVR_DTR);
 }
 
-void rx_reset_buffers(MGSLPC_INFO *info)
+static void rx_reset_buffers(MGSLPC_INFO *info)
 {
 	RXBUF *buf;
 	int i;
@@ -3875,7 +3875,7 @@ void rx_reset_buffers(MGSLPC_INFO *info)
  *
  * Returns 1 if frame returned, otherwise 0
  */
-int rx_get_frame(MGSLPC_INFO *info)
+static int rx_get_frame(MGSLPC_INFO *info)
 {
 	unsigned short status;
 	RXBUF *buf;
@@ -3961,7 +3961,7 @@ #endif
 	return 1;
 }
 
-BOOLEAN register_test(MGSLPC_INFO *info)
+static BOOLEAN register_test(MGSLPC_INFO *info)
 {
 	static unsigned char patterns[] = 
 	    { 0x00, 0xff, 0xaa, 0x55, 0x69, 0x96, 0x0f };
@@ -3987,7 +3987,7 @@ BOOLEAN register_test(MGSLPC_INFO *info)
 	return rc;
 }
 
-BOOLEAN irq_test(MGSLPC_INFO *info)
+static BOOLEAN irq_test(MGSLPC_INFO *info)
 {
 	unsigned long end_time;
 	unsigned long flags;
@@ -4022,7 +4022,7 @@ BOOLEAN irq_test(MGSLPC_INFO *info)
 	return info->irq_occurred ? TRUE : FALSE;
 }
 
-int adapter_test(MGSLPC_INFO *info)
+static int adapter_test(MGSLPC_INFO *info)
 {
 	if (!register_test(info)) {
 		info->init_error = DiagStatus_AddressFailure;
@@ -4044,7 +4044,7 @@ int adapter_test(MGSLPC_INFO *info)
 	return 0;
 }
 
-void trace_block(MGSLPC_INFO *info,const char* data, int count, int xmit)
+static void trace_block(MGSLPC_INFO *info,const char* data, int count, int xmit)
 {
 	int i;
 	int linecount;
@@ -4079,7 +4079,7 @@ void trace_block(MGSLPC_INFO *info,const
 /* HDLC frame time out
  * update stats and do tx completion processing
  */
-void tx_timeout(unsigned long context)
+static void tx_timeout(unsigned long context)
 {
 	MGSLPC_INFO *info = (MGSLPC_INFO*)context;
 	unsigned long flags;
