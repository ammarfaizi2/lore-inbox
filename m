Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVDSITK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDSITK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVDSITJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:19:09 -0400
Received: from 225-2.east.net ([202.130.225.2]:26772 "EHLO out01.east.net")
	by vger.kernel.org with ESMTP id S261400AbVDSITF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:19:05 -0400
Subject: [ Patch ]: Fix loopback communication latency bug
From: yangyi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rt-Dev@Mvista. Com" <rt-dev@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: bmrtech
Message-Id: <1113897790.4632.161.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Apr 2005 16:03:10 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo

For the option PREEMPT_RT, local communication latency is very very big,
it is about 30 to 50 times as big as the option PREEMPT_NONE as far as
local ping latency is concerned. Obviously, this should be fixed ASAP.

This patch fixes this bug by changing netif_rx to netif_rx_ni in
loopback device driver.

--- linux-2.6.10-orig/drivers/net/loopback.c    2005-04-19
15:12:34.000000000 +0800
+++ linux-2.6.10/drivers/net/loopback.c 2005-04-19 15:13:28.000000000
+0800
@@ -153,7 +153,7 @@ static int loopback_xmit(struct sk_buff
        lb_stats->tx_packets++;
        put_cpu();

-       netif_rx(skb);
+       netif_rx_ni(skb);

        return(0);
 }

