Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLWQRS>; Sat, 23 Dec 2000 11:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLWQRJ>; Sat, 23 Dec 2000 11:17:09 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:29575 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129267AbQLWQQ7>;
	Sat, 23 Dec 2000 11:16:59 -0500
Message-Id: <m149qsR-000OXQC@amadeus.home.nl>
Date: Sat, 23 Dec 2000 16:46:31 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: Arjan Filius <iafilius@xs4all.nl>
Subject: Re: "undefined reference" atm_lane_init & atm_mpoa_init with test13-pre4
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com> <Pine.LNX.4.30.0012231600450.17383-100000@sjoerd.sjoerdnet>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0012231600450.17383-100000@sjoerd.sjoerdnet> you wrote:
> net/network.o(.text+0x3ff92): undefined reference to `atm_lane_init'
> net/network.o(.text+0x40039): undefined reference to `atm_mpoa_init'

Hi,

The patch below should fix that.

Greetings,
   Arjan van de Ven

--- linux/net/atm/Makefile	Fri Dec 22 18:22:15 2000
+++ ../0/linux/net/atm/Makefile	Fri Dec 22 19:01:03 2000
@@ -37,6 +37,11 @@
 obj-$(CONFIG_ATM) += lec.o lane_mpoa_init.o
 endif
 
+ifeq ($(CONFIG_ATM_LANE),m)
+obj-$(CONFIG_ATM) += lane_mpoa_init.o
+obj-m += lec.o 
+endif
+
 ifeq ($(CONFIG_ATM_MPOA),y)
 obj-$(CONFIG_ATM) += mpoa.o
 endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
