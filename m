Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWIKBKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWIKBKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWIKBKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:10:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:23970 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750780AbWIKBKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:10:46 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <200609101725.49234.jbarnes@virtuousgeek.org>
	 <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:10:23 +1000
Message-Id: <1157937023.31071.289.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hence my proposal of calling it pci_cpu_to_cpu_barrier() -- what it
> orders is accesses from separate CPUs.  Oh, and it's bus-specific,
> of course.

I disagree on that one, as I disagree on Jesse terminology too :)

Ordering between stores issued by different CPUs has no meaning
whatsoever unless you have locks. That is you have some kind of
synchronisation primitive between the 2 CPUs. Outside of that, the
concept of ordering doesn't make any sense.

Thus the problem is really only of MMIO stores leaking out of locks,
thus it's really a MMIO vs. lock barrier, and it's a lot easier to
understand that way imho.

Ben.


