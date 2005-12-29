Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVL2W6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVL2W6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVL2W6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:58:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751080AbVL2W6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:58:21 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <20051229224839.GA12247@elte.hu>
References: <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
	 <20051229224839.GA12247@elte.hu>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 23:58:12 +0100
Message-Id: <1135897092.2935.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some data from an x86-64 allyesconfig build.

Below is a *rough* estimate of savings that could be achieved by
uninlining specific functions. The estimate is rough in the sense that it assumes
that no "trick" allows the uninlined version to be significantly smaller
than the inlined version, which for certain functions is not a valid
assumption (kmalloc comes to mind as an obvious one).

The saving is estimated at (count-1) * (size-6), eg the estimate for a
function call is 6 bytes as well and the estimate for the size something 
takes as inlined is the same as the uninline size. 


These are the top items only; a more complete list can be gotten 
from http://www.fenrus.org/savings

Est saving       function name                   count   uninline size
----------------------------------------------------------------------
95940            down                            [2461]  <45>
84392            skb_put                         [1097]  <83>
50932            kfree_skb                       [1499]  <40>
44880            init_waitqueue_head             [881]   <57>
34840            lowmem_page_address             [537]   <71>
25573            cfi_build_cmd                   [108]   <245>
19825            skb_push                        [326]   <67>
17992            aic_outb                        [347]   <58>
17434            module_put                      [380]   <52>
16318            ahd_outb                        [399]   <47>
16035            kmalloc                         [3208]  <11>
14040            netif_wake_queue                [361]   <45>
13266            dev_kfree_skb_irq               [202]   <72>
12078            signal_pending                  [672]   <24>
11979            ahc_outb                        [364]   <39>
11603            down_interruptible              [284]   <47>
11552            ahd_inb                         [305]   <44>
11310            dst_release                     [175]   <71>
11275            netif_stop_queue                [452]   <31>
11165            down_write                      [320]   <41>
11107            ahc_inb                         [384]   <35>
10807            usb_fill_bulk_urb               [102]   <113>
10508            ahd_set_modes                   [72]    <154>
10266            skb_queue_head_init             [178]   <64>


