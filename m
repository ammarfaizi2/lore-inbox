Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVKJUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVKJUNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKJUNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:13:38 -0500
Received: from webcluster-node1.tg-solutions.de ([82.100.233.121]:14563 "EHLO
	mailgate.tg-solutions.de") by vger.kernel.org with ESMTP
	id S1751210AbVKJUNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:13:37 -0500
From: Kostja Siefen <kostja@siefen.de>
To: linux-kernel@vger.kernel.org
Subject: Ethernet bridge leaking memory
Date: Thu, 10 Nov 2005 21:13:27 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511102113.28334.kostja@siefen.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a strange problem with ethernet bridging in 2.6.13 which leads to heavy 
slab allocation until memory is completely filled up.

My setup:

HP nx7000 Laptop running Kernel 2.6.13
- RTL 8139 network interface on board (module 8139too)
- PC Card Wired LAN Network Interface (module pcnet_cs)

After modprobing bridge and calling

brctl addbr br0
brctl addif br0 eth0 (RTL 8139)
brctl addif br0 eth2 (PC Card Wired LAN)

the bridge is up and running and works like a charm. Sending some traffic (1 
MB/s is enough) through that bridge leads to massive kernel memory 
allocation. slabtop reports, that "skbuff_head_cache" and "size-2048" eat up 
all the memory (256 MB). This looks like a memory leak to me.

Even unloading the network modules does not free any memory, a reboot is 
required.

Any ideas? 

Yours,

Kostja

