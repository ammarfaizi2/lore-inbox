Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVKWU1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKWU1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKWU06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:26:58 -0500
Received: from fmr19.intel.com ([134.134.136.18]:36799 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932344AbVKWU03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:26:29 -0500
Date: Wed, 23 Nov 2005 12:26:28 -0800 (PST)
From: Andrew Grover <andrew.grover@intel.com>
X-X-Sender: agrover@isotope.jf.intel.com
To: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>
cc: john.ronciak@intel.com, <christopher.leech@intel.com>
Subject: [RFC] [PATCH 0/3] ioat: DMA engine support
Message-ID: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
ReplyTo: "Andrew Grover" <andrew.grover@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As presented in our talk at this year's OLS, the Bensley platform, which 
will be out in early 2006, will have an asyncronous DMA engine. It can be 
used to offload copies from the CPU, such as the kernel copies of received 
packets into the user buffer.

The code consists of the following sections:
1) The HW driver for the DMA engine device
2) The DMA subsystem, which abstracts the HW details from users of the 
async DMA
3) Modifications to net/ to make use of the DMA engine for receive copy 
offload:
    3a) Code to register the net stack as a "DMA client"
    3b) Code to pin and unpin pages associated with a user buffer
    3c) Code to initiate async DMA transactions in the net receive path

Today we are releasing 2, 3a, and 3b, as well as "testclient", a throwaway
driver we wrote to demonstrate the DMA subsystem API. We will be releasing
3c shortly. We will be releasing 1 (the HW driver) when the platform ships
early next year. Until then, the code doesn't really *do* anything, but we
wanted to release what we could right away, and start getting some 
feedback.

Against 2.6.14:
patch 1: DMA engine
patch 2: iovec pin/unpin code; register net as a DMA client
patch 3: testclient

overall diffstat information:
 drivers/Kconfig           |    2 
 drivers/Makefile          |    1 
 drivers/dma/Kconfig       |   40 ++
 drivers/dma/Makefile      |    5 
 drivers/dma/cb_list.h     |   12 
 drivers/dma/dmaengine.c   |  394 ++++++++++++++++++++++++
 drivers/dma/testclient.c  |  132 ++++++++
 include/linux/dmaengine.h |  268 ++++++++++++++++
 net/core/Makefile         |    3 
 net/core/dev.c            |   78 ++++
 net/core/user_dma.c       |  422 ++++++++++++++++++++++++++
 11 files changed, 1356 insertions(+), 1 deletion(-)

Regards -- Andy and Chris



