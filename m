Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUHMKRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUHMKRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUHMKRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:17:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12745 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269049AbUHMKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:17:24 -0400
Date: Fri, 13 Aug 2004 12:17:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let W1 select NET
Message-ID: <20040813101717.GS13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1=y and Net=n fails with the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x5efa38): In function `w1_alloc_dev':
: undefined reference to `netlink_kernel_create'
drivers/built-in.o(.text+0x5efac1): In function `w1_alloc_dev':
: undefined reference to `sock_release'
drivers/built-in.o(.text+0x5efb31): In function `w1_free_dev':
: undefined reference to `sock_release'
drivers/built-in.o(.text+0x5f0014): In function `w1_netlink_send':
: undefined reference to `alloc_skb'
drivers/built-in.o(.text+0x5f00cd): In function `w1_netlink_send':
: undefined reference to `netlink_broadcast'
drivers/built-in.o(.text+0x5f0131): In function `w1_netlink_send':
: undefined reference to `skb_over_panic'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The patch below fixes this issue by letting W1 select NET.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full-3.4/drivers/w1/Kconfig.old	2004-08-13 12:00:05.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full-3.4/drivers/w1/Kconfig	2004-08-13 12:11:31.000000000 +0200
@@ -2,6 +2,7 @@
 
 config W1
 	tristate "Dallas's 1-wire support"
+	select NET
 	---help---
 	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
 	  such as iButtons and thermal sensors.

