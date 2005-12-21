Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVLUFRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVLUFRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVLUFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:17:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:35469 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751093AbVLUFRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:34 -0500
Subject: [RFC][PATCH 0/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:30 -0800
Message-Id: <1135142250.13781.17.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:33.0038 (UTC) FILETIME=[D8DCE0E0:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on the I/OAT patches that Andy posted on Nov 23, these
address some of the style concerns, add descriptive comments (kdoc
style) to many functions, remove some dead code, and most importantly
include our TCP recv offload changes.
This patch set does not include the driver for the I/OAT DMA hardware.

There are 5 patches

1) DMA subsystem
2) Networking subsystem DMA client
3) sk_buff to iovec copy helper functions
4) structure changes for TCP recv copy offload
5) main TCP recv copy offload changes

As always, comments are welcome and encouraged.  I'm continuing to work
on incorporating suggestions, including the comments Deepak Saxena
posted to lkml earlier today.

The class code hasn't changed since the previous code postings, but I
think I'm making progress in figuring that out :)

I'm also looking at simplifying the DMA subsystem by removing DMA
devices in favor of only working with channels.  The idea of having
devices which provide multiple channels can be managed within drivers,
without complicating the client API.  That should reduce the length of
some of the dereference chains.


Chris Leech <christopher.leech@intel.com>
I/O Acceleration Technology Software Development
LAN Access Division / Digital Enterprise Group

---
 drivers/Kconfig             |    2 
 drivers/Makefile            |    1 
 drivers/dma/Kconfig         |   34 +++
 drivers/dma/Makefile        |    3 
 drivers/dma/dmaengine.c     |  391 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h   |  220 +++++++++++++++++++++++
 include/linux/skbuff.h      |    5 
 include/linux/tcp.h         |    9 
 include/net/tcp.h           |   10 +
 net/core/Makefile           |    3 
 net/core/dev.c              |   97 ++++++++++
 net/core/skbuff.c           |    1 
 net/core/user_dma.c         |  410 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c              |  177 ++++++++++++++----
 net/ipv4/tcp_input.c        |   63 ++++++
 net/ipv4/tcp_ipv4.c         |   20 ++
 net/ipv4/tcp_minisocks.c    |    1 
 net/ipv6/tcp_ipv6.c         |    1 
 18 files changed, 1397 insertions(+), 51 deletions(-)

