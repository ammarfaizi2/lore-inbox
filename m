Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTE0AEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTE0AEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:04:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5519 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262379AbTE0AEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:04:00 -0400
Date: Mon, 26 May 2003 17:15:27 -0700 (PDT)
Message-Id: <20030526.171527.35691510.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527000639.GA3767@dualathlon.random>
References: <20030526233446.GZ3767@dualathlon.random>
	<20030526.164300.88501443.davem@redhat.com>
	<20030527000639.GA3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 02:06:39 +0200

   On Mon, May 26, 2003 at 04:43:00PM -0700, David S. Miller wrote:
   > softirq load?  How much weight will softirq load get compared to
   
   normally the softirq runs after the hardirq (commoncase) and you want to
   run those softirq computations on the idle cpu too (i.e. no userspace
   running so offload hardirq and in turn softqirq to it) No difference.
   softirq is like hardirq just longer and with hardirq enabled. One more
   reason to offload it to an idle cpu.

One hardirq can equate to thousands of packets worth of softirq load,
especially with NAPI.  And you cannot even know what this ratio is
(packets processed per hardware IRQ load).  It can be anywhere from
1 to 1000.  And you absolutely do not want to behave identically
for all such values.

How can you even claim to be taking this into account in a logical
manner if you cannot even tell me how you will determine how much
softirq load is created by a hardware irq?
