Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTEVPm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTEVPm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:42:29 -0400
Received: from holomorphy.com ([66.224.33.161]:31372 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262028AbTEVPm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:42:26 -0400
Date: Thu, 22 May 2003 08:55:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: tulip warning fix
Message-ID: <20030522155517.GR29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -prauN mm8-2.5.69-1/drivers/net/tulip/interrupt.c mm8-2.5.69-2/drivers/net/tulip/interrupt.c
--- mm8-2.5.69-1/drivers/net/tulip/interrupt.c	2003-05-04 16:53:08.000000000 -0700
+++ mm8-2.5.69-2/drivers/net/tulip/interrupt.c	2003-05-22 07:55:19.000000000 -0700
@@ -194,10 +194,10 @@ static int tulip_rx(struct net_device *d
 				if (tp->rx_buffers[entry].mapping !=
 				    le32_to_cpu(tp->rx_ring[entry].buffer1)) {
 					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-					       "do not match in tulip_rx: %08x vs. %08x %p / %p.\n",
+					       "do not match in tulip_rx: %08x vs. %Lx %p / %p.\n",
 					       dev->name,
 					       le32_to_cpu(tp->rx_ring[entry].buffer1),
-					       tp->rx_buffers[entry].mapping,
+					       (u64)tp->rx_buffers[entry].mapping,
 					       skb->head, temp);
 				}
 #endif
