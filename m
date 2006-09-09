Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWIICEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWIICEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWIICEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:04:14 -0400
Received: from ozlabs.org ([203.10.76.45]:32143 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750993AbWIICEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:04:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
Date: Sat, 9 Sep 2006 12:03:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org, davem@davemloft.net
Subject: Opinion on ordering of writel vs. stores to RAM
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

An issue has come up in the tg3 ethernet driver, where we are seeing
data corruption on ppc64 machines that is attributable to a lack of
ordering between writes to normal RAM and writes to an MMIO register.
Basically the driver does writes to RAM and then a writel to an MMIO
register to trigger DMA, and occasionally the device then reads old
values from memory.

Do you have an opinion about whether the MMIO write in writel() should
be ordered with respect to preceding writes to normal memory?

Currently we have a sync instruction after the store in writel() but
not one before.  The sync after is to keep the writel inside
spinlocked regions and to ensure that the store is ordered with
respect to the load in readl() and friends.

Paul.
