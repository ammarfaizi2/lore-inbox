Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVLPUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVLPUFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVLPUFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:05:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17829 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750803AbVLPUFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:05:10 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, arjan@infradead.org, Diego Calleja <diegocg@gmail.com>
In-Reply-To: <200512161723.19965.mbuesch@freenet.de>
References: <20051215212447.GR23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	 <200512161723.19965.mbuesch@freenet.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Dec 2005 20:02:50 +0000
Message-Id: <1134763370.28761.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-16 at 17:23 +0100, Michael Buesch wrote:
> Now, I want to test bcm43xx on 4k stacks. But only have a
> ppc32 machine with such a broadcom card. ppc32 has 8k stacks.
> How am I supposed to test the driver for 4kstack conformance?

Unless you've been writing fairly careless code putting a lot of objects
on stack a driver is going to work fine with 4K stacks.

> Given this, why aren't there people working on 4kstacks for
> ppc32? Is it not needed there, or did simply nobody care to
> do this now?

AFAIK nobody is working on 4K stack for PPC32. I've no idea myself if it
is needed or useful there. In terms of debugging if your code exceeds a
4K stack you'll find out quite rapidly from x86 users. One thing the
seperate IRQ stacks mean is that stack overflows generally show up as
overflows and consistently rather than as weird crashes when timing
co-incides between your heavy stack usage and IRQ heavy stack usage, at
which point the mess is rarely repeatable or debuggable

