Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUBRQyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUBRQyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:54:46 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:52614 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266880AbUBRQva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:51:30 -0500
Subject: [NET] 64 bit byte counter for 2.6.3
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-/+HHfrwi0HZvDp4wlKQG"
Message-Id: <1077123078.9223.7.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 18:51:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/+HHfrwi0HZvDp4wlKQG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, Here's a patch for 64 bit byte counters for 2.6.3. For any intrested
users to try.

That means in english that the limit for RX bytes and TX bytes (in
ifconfig for example) is much higher than the old 4GB limit on 32 bit
systems.

Orginal patch by Miika Pekkarinen, ported forward from 2.5 by me.

Patch says 2.6.3-rc1, but patches cleanly on 2.6.3.

        Markus

--=-/+HHfrwi0HZvDp4wlKQG
Content-Disposition: attachment; filename=rm-ifconfig-reset-2.6.3-rc1
Content-Type: text/plain; name=rm-ifconfig-reset-2.6.3-rc1; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc1/net/core/dev.c	2004-02-08 01:07:55.000000000 +0200
+++ linux-2.6.3-rc1-b/net/core/dev.c	2004-02-07 15:29:32.000000000 +0200
@@ -2042,8 +2042,8 @@
 	if (dev->get_stats) {
 		struct net_device_stats *stats = dev->get_stats(dev);
 
-		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
-				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+		seq_printf(seq, "%6s:%14llu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
+				"%14llu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
 			   dev->name, stats->rx_bytes, stats->rx_packets,
 			   stats->rx_errors,
 			   stats->rx_dropped + stats->rx_missed_errors,
--- linux-2.6.3-rc1/include/linux/netdevice.h	2004-02-08 01:05:47.000000000 +0200
+++ linux-2.6.3-rc1-b/include/linux/netdevice.h	2004-02-07 15:21:26.000000000 +0200
@@ -103,8 +103,8 @@
 {
 	unsigned long	rx_packets;		/* total packets received	*/
 	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
+	unsigned long long rx_bytes;		/* total bytes received 	*/
+	unsigned long long tx_bytes;		/* total bytes transmitted	*/
 	unsigned long	rx_errors;		/* bad packets received		*/
 	unsigned long	tx_errors;		/* packet transmit problems	*/
 	unsigned long	rx_dropped;		/* no space in linux buffers	*/

--=-/+HHfrwi0HZvDp4wlKQG--

