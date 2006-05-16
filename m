Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWEPRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEPRPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEPRPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:15:46 -0400
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:49075 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932161AbWEPRPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:15:45 -0400
Date: Tue, 16 May 2006 19:15:42 +0200
Message-ID: <443CC7420003BDBB@ms003msg.mail.fw>
From: maurizio.gladioro@fastwebnet.it
Subject: Dropped packets with bridge + ip_conntrack module
To: linux-kernel@vger.kernel.org
Cc: maurizio.gladioro@fastwebnet.it
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
Hello,

I'm using netfilter with the l7-filter patch, and a 2.6.13 kernel.

I had to create a bridge interface in order to enable the listening
interface in promiscous mode and to classify the traffic mirrored to
that (I touch eth1 to br1 interface).

So, the problem is that I'm seeing many dropped packets on the bridge,
and I cannot understand why.

If I don't add the ip_conntrack module, the whole traffic going through
the ethernet interface eth1 is passed to the bridge; but, if I add
ip_conntrack some packets don't cross the bridge interface.

Following, I show you the output of "netstat -i":
  without module ip_conntrack (before sending packets)
Kernel Interface table
Iface MTU Met RX-OK RX-ERR RX-DRP RX-OVR TX-OK TX-ERR TX-DRP TX-OVR
Flg
br1 1500 0 6576580 0 0 0 5 0 0 0
BMRU
eth1 1500 0 16105342 25606 0 25606 13 0 0 0

  after sending packets
olmo:/home/maurizio# netstat -i
Kernel Interface table
Iface MTU Met RX-OK RX-ERR RX-DRP RX-OVR TX-OK TX-ERR TX-DRP TX-OVR
Flg
br1 1500 0 8220973 0 0 0 5 0 0 0
BMPRU
eth1 1500 0 17749735 25606 0 25606 13 0 0 0
BMPRU


difference eth1 1644393
difference br1 1644393
than NO DROPPED PACKETS

with ip_conntrack (before sending packets)

Kernel Interface table
Iface MTU Met RX-OK RX-ERR RX-DRP RX-OVR TX-OK TX-ERR TX-DRP TX-OVR
Flg
br1 1500 0 4932660 0 0 0 5 0 0 0
BMPRU
eth1 1500 0 14460948 25606 0 25606 13 0 0 0
BMPRU


  with ip_conntrack (after sending packets)
olmo:/home/maurizio# netstat -i
Kernel Interface table
Iface MTU Met RX-OK RX-ERR RX-DRP RX-OVR TX-OK TX-ERR TX-DRP TX-OVR
Flg
br1 1500 0 6576579 0 0 0 5 0 0 0
BMPRU

eth1 1500 0 16105341 25606 0 25606 13 0 0 0
BMPRU


difference eth1 1644393
difference br1 1643919
than there are 474 DROPPED PACKETS

May be someone can help me?
I have read about some similar problems with Kernel 2.6.16 and
fragmented IP packets.

Thank you very much, regards,
	


