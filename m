Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUIOS0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUIOS0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIOSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:25:57 -0400
Received: from science.horizon.com ([192.35.100.1]:17733 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S267248AbUIOSZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:25:40 -0400
Date: 15 Sep 2004 18:25:36 -0000
Message-ID: <20040915182536.20820.qmail@science.horizon.com>
From: linux@horizon.com
To: joern@wohnheim.fh-wedel.de
Subject: Re: Being more anal about iospace accesses..
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nice.
>
> But it still leaves me confused.  Before I had this code:
>
>	struct regs {
>		uint32_t status;
>		...
>	}
>
>	...
>
>	struct regs *regs = ioremap(...);
>	uint32_t status = regs->status;
>	...
> 
> So now I should do it like this:
>
>	#define REG_STATUS 0
>
>	...
>
>	void __iomem *regs = ioremap(...);
>	uint32_t status = readl(regs + REG_STATUS);
>	...
>
> But wait, that only works when long is 32bit wide.  Plus I could be
> stupid enough and "#define REG_STATUS 64" while the register space is
> just 64 bytes long.  It solves the confusion about address spaces,
> agreed, but overall I'm more confused now.  Hope it's just temporary.

No, you should do:

	struct regs {
	      uint32_t status;
	      ...
	}

	...

	struct regs __iomem *regs = ioremap(...);
	uint32_t status = ioread32(&regs->status);
