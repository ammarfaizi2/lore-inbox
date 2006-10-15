Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWJOWZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWJOWZI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJOWZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:25:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26791 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932157AbWJOWZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:25:06 -0400
Date: Sun, 15 Oct 2006 23:25:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rfcomm endianness bug: param_mask is little-endian on the wire
Message-ID: <20061015222501.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/rfcomm/core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 0494ff1..5417676 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -854,7 +854,7 @@ int rfcomm_send_rpn(struct rfcomm_sessio
 	rpn->flow_ctrl     = flow_ctrl_settings;
 	rpn->xon_char      = xon_char;
 	rpn->xoff_char     = xoff_char;
-	rpn->param_mask    = param_mask;
+	rpn->param_mask    = cpu_to_le16(param_mask);
 
 	*ptr = __fcs(buf); ptr++;
 
@@ -1343,7 +1343,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 	/* Check for sane values, ignore/accept bit_rate, 8 bits, 1 stop bit,
 	 * no parity, no flow control lines, normal XON/XOFF chars */
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_BITRATE) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_BITRATE)) {
 		bit_rate = rpn->bit_rate;
 		if (bit_rate != RFCOMM_RPN_BR_115200) {
 			BT_DBG("RPN bit rate mismatch 0x%x", bit_rate);
@@ -1352,7 +1352,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_DATA) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_DATA)) {
 		data_bits = __get_rpn_data_bits(rpn->line_settings);
 		if (data_bits != RFCOMM_RPN_DATA_8) {
 			BT_DBG("RPN data bits mismatch 0x%x", data_bits);
@@ -1361,7 +1361,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_STOP) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_STOP)) {
 		stop_bits = __get_rpn_stop_bits(rpn->line_settings);
 		if (stop_bits != RFCOMM_RPN_STOP_1) {
 			BT_DBG("RPN stop bits mismatch 0x%x", stop_bits);
@@ -1370,7 +1370,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_PARITY) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_PARITY)) {
 		parity = __get_rpn_parity(rpn->line_settings);
 		if (parity != RFCOMM_RPN_PARITY_NONE) {
 			BT_DBG("RPN parity mismatch 0x%x", parity);
@@ -1379,7 +1379,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_FLOW) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_FLOW)) {
 		flow_ctrl = rpn->flow_ctrl;
 		if (flow_ctrl != RFCOMM_RPN_FLOW_NONE) {
 			BT_DBG("RPN flow ctrl mismatch 0x%x", flow_ctrl);
@@ -1388,7 +1388,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_XON) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON)) {
 		xon_char = rpn->xon_char;
 		if (xon_char != RFCOMM_RPN_XON_CHAR) {
 			BT_DBG("RPN XON char mismatch 0x%x", xon_char);
@@ -1397,7 +1397,7 @@ static int rfcomm_recv_rpn(struct rfcomm
 		}
 	}
 
-	if (rpn->param_mask & RFCOMM_RPN_PM_XOFF) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF)) {
 		xoff_char = rpn->xoff_char;
 		if (xoff_char != RFCOMM_RPN_XOFF_CHAR) {
 			BT_DBG("RPN XOFF char mismatch 0x%x", xoff_char);
-- 
1.4.2.GIT

