Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWIKIkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWIKIkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIKIkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:40:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49578 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751270AbWIKIkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:40:05 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1157933531.31071.274.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
	 <1157933531.31071.274.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 10:02:52 +0100
Message-Id: <1157965372.23085.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 10:12 +1000, ysgrifennodd Benjamin Herrenschmidt:
>  - writel/readl are fully synchronous (minus mmiowb for spinlocks)
>  - we provide __writel/__readl with some barriers with relaxed ordering
> between memory and MMIO (though still _precise_ semantics, not arch
> specific)

I'd rather they were less precise than your later proposal but that
reflects the uses I'm considering perhaps.

>  * Option B:
> 
>  - The driver decides at ioremap time wether it wants a fully ordered
> mapping or not using

That is expensive because writel/readl end up full of if() while at the
moment they are often 1 instruction.


