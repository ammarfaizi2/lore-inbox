Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287786AbSANRaM>; Mon, 14 Jan 2002 12:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSANRaG>; Mon, 14 Jan 2002 12:30:06 -0500
Received: from colorfullife.com ([216.156.138.34]:48653 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287786AbSANR3u>;
	Mon, 14 Jan 2002 12:29:50 -0500
Message-ID: <3C430802.8B8A273E@colorfullife.com>
Date: Mon, 14 Jan 2002 17:32:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rx FIFO Overrun error found
In-Reply-To: <3C40A6F2.18A8C3E6@colorfullife.com> <3C422C59.90E7D5CB@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------4BF173CC46E0F51A0DF1DA90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4BF173CC46E0F51A0DF1DA90
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> and it would be preferred to separate "add oom handling" and "fix nic
> hang" patches.
>
Attached is the patch against the nic hang. Now all rx error bits
trigger netdev_rx - it doesn't hurt and could catch further hardware
oddities.

--
	Manfred
--------------4BF173CC46E0F51A0DF1DA90
Content-Type: text/plain; charset=us-ascii;
 name="patch-natsemi-fifoonly"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-natsemi-fifoonly"

--- 2.5/drivers/net/natsemi.c	Fri Nov 23 20:35:23 2001
+++ build-2.5/drivers/net/natsemi.c	Mon Jan 14 16:56:22 2002
@@ -1508,7 +1508,7 @@
 		if (intr_status == 0)
 			break;
 
-		if (intr_status & (IntrRxDone | IntrRxIntr))
+		if (intr_status & (IntrRxDone | IntrRxIntr | RxStatusFIFOOver | IntrRxErr | IntrRxOverrun ))
 			netdev_rx(dev);
 
 		if (intr_status & (IntrTxDone | IntrTxIntr | IntrTxIdle | IntrTxErr) ) {

--------------4BF173CC46E0F51A0DF1DA90--

