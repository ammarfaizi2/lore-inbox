Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbUAGIjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUAGIjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:39:24 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:60366 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S265435AbUAGIjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:39:23 -0500
X-Sender-Authentication: net64
Date: Wed, 7 Jan 2004 09:39:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] fix VLAN support for ns83820
Message-Id: <20040107093904.1b89dc0f.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

attached patch fixes the usual vlan issue with too small buffers in driver ns83820.

Regards,
Stephan

--- linux/drivers/net/ns83820.c-orig    2004-01-07 10:57:23.000000000 +0100
+++ linux/drivers/net/ns83820.c 2004-01-07 10:58:23.000000000 +0100
@@ -141,7 +141,7 @@
 #define NR_TX_DESC     128
 
 /* not tunable */
-#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14)    /* rx/tx mac addr + type */
+#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14 + 4)        /* rx/tx mac addr + type + vlan */
 
 #define MIN_TX_DESC_FREE       8
 
