Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUHMKFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUHMKFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUHMKFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:05:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46793 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265232AbUHMKFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:05:06 -0400
Date: Fri, 13 Aug 2004 12:05:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: bcollins@debian.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [2.6 patch] let IEEE1394 select NET
Message-ID: <20040813100501.GR13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firewire support with CONFIG_NET=n fails with the following error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x3e67d5): In function `hpsb_alloc_packet':
: undefined reference to `alloc_skb'
drivers/built-in.o(.text+0x3e73e7): In function `hpsb_send_packet':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0x3e8106): In function `abort_requests':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0x3e822e): In function `queue_packet_complete':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0x3e82b2): In function `hpsbpkt_thread':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0x3e82e2): In function `hpsbpkt_thread':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0x3e6890): In function `hpsb_free_packet':
: undefined reference to `__kfree_skb'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue by letting IEEE1394 select NET:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full-3.4/drivers/ieee1394/Kconfig.old	2004-08-13 12:02:48.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full-3.4/drivers/ieee1394/Kconfig	2004-08-13 12:03:04.000000000 +0200
@@ -5,6 +5,7 @@
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
 	depends on PCI || BROKEN
+	select NET
 	help
 	  IEEE 1394 describes a high performance serial bus, which is also
 	  known as FireWire(tm) or i.Link(tm) and is used for connecting all

