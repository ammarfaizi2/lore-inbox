Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268949AbRHFTNE>; Mon, 6 Aug 2001 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268942AbRHFTMy>; Mon, 6 Aug 2001 15:12:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39685 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268941AbRHFTMp>; Mon, 6 Aug 2001 15:12:45 -0400
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
To: walters@cis.ohio-state.edu (Colin Walters)
Date: Mon, 6 Aug 2001 20:14:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <873d75janh.church.of.emacs@space-ghost.verbum.org> from "Colin Walters" at Aug 06, 2001 02:39:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TppS-0001bj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't a udelay(1) always take one microsecond, regardless of
> hardware optimizations?

A udelay(1) should always take 1 microsecond or a bit longer. There are some
funnies with PCI posting to beware of - notably

	writel(0x1, foo->reg);
	udelay(1);
	writel(0x0, foo->reg)

Does _not_ guarantee the two writes hit the PCI device with a 1 uS delay 
where its PCI access timing that matters you need to do

	writel(0x1, foo->reg)
	readl(foo->somethingthatdoesnothing);
	udelay(1);
	writel(0x0, foo->reg)

