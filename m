Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVHRH2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVHRH2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVHRH2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:28:13 -0400
Received: from mout2.freenet.de ([194.97.50.155]:50857 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932098AbVHRH2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:28:11 -0400
Subject: overflows in /proc/net/dev
From: Sebastian =?ISO-8859-1?Q?Cla=DFen?= 
	<Sebastian.Classen@freenet-ag.de>
Reply-To: Sebastian.Classen@freenet-ag.de
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Y428FtCqSDvpWy8AQnnp"
Date: Thu, 18 Aug 2005 09:28:10 +0200
Message-Id: <1124350090.29902.8.camel@basti79.freenet-ag.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y428FtCqSDvpWy8AQnnp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all...

in struct net_device_stats all members are defined as unsgined long. In
time of gigabit ethernet this takes not long to overflow. Are there any
plans to change these coutners to unsigned long long? I saw in ifconfig
source code the byte and packet counters are already defined as unsigned
long long.

I've tried the attached little patch which seems to work well. Are there
any good reasons against this changes?

--=20
Mit freundlichen Gr=FC=DFen / Yours sincerely

Sebastian Cla=DFen, Postmaster
freenet.de AG, Willst=E4tterstra=DFe 13, D-40549 D=FCsseldorf
Phone: +49 (0) 211 / 53087-522
----------------------------------------------------------------------
Vorsitzender des Aufsichtsrates: Prof. Dr. Helmut Thoma
Vorstand: Eckhard Spoerr (Vors.), Axel Krieger,
          Stephan Esch, Eric Berger
Amtsgericht Hamburg HRB 74048

--=-Y428FtCqSDvpWy8AQnnp
Content-Disposition: attachment; filename=proc_net_dev.diff
Content-Type: text/x-patch; name=proc_net_dev.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- include/linux/netdevice.h.orig	2005-08-17 15:28:05.000000000 +0200
+++ include/linux/netdevice.h	2005-08-17 15:27:02.000000000 +0200
@@ -107,10 +107,10 @@ struct netpoll;
  
 struct net_device_stats
 {
-	unsigned long rx_packets;		/* total packets received	*/
-	unsigned long tx_packets;		/* total packets transmitted	*/
-	unsigned long rx_bytes;		/* total bytes received 	*/
-	unsigned long tx_bytes;		/* total bytes transmitted	*/
+	unsigned long long rx_packets;		/* total packets received	*/
+	unsigned long long tx_packets;		/* total packets transmitted	*/
+	unsigned long long rx_bytes;		/* total bytes received 	*/
+	unsigned long long tx_bytes;		/* total bytes transmitted	*/
 	unsigned long rx_errors;		/* bad packets received		*/
 	unsigned long tx_errors;		/* packet transmit problems	*/
 	unsigned long rx_dropped;		/* no space in linux buffers	*/
--- net/core/dev.c.orig	2005-08-17 15:29:40.000000000 +0200
+++ net/core/dev.c	2005-08-17 15:30:53.000000000 +0200
@@ -1984,8 +1984,8 @@ static void dev_seq_printf_stats(struct 
 	if (dev->get_stats) {
 		struct net_device_stats *stats = dev->get_stats(dev);
 
-		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
-				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+		seq_printf(seq, "%6s:%8llu %7llu %4lu %4lu %4lu %5lu %10lu %9lu "
+				"%8llu %7llu %4lu %4lu %4lu %5lu %7lu %10lu\n",
 			   dev->name, stats->rx_bytes, stats->rx_packets,
 			   stats->rx_errors,
 			   stats->rx_dropped + stats->rx_missed_errors,

--=-Y428FtCqSDvpWy8AQnnp--

