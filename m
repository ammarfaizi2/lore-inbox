Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUIOWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUIOWsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIOWsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:48:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:52354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267740AbUIOWqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:46:32 -0400
Date: Wed, 15 Sep 2004 15:46:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <20040915222157.GA17284@plexity.net>
Message-ID: <Pine.LNX.4.58.0409151540260.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915222157.GA17284@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Deepak Saxena wrote:
> 
> Since we are on the subject of io-access, I would like a
> clarification/opinion on the read*/write* & in*/out* accessors 
> (and now the ioread/write equivalents). Are these functions only meant 
> to be used for PCI memory-mapped devices or _any_ memory mapped devices? 

It really depends on the bus architecture.

At some point, if the bus is different enough from a "normal" setup, you 
should just use your own accessor functions. Trying to overload 
"readl/writel" is just too painful.

However, at that point you should also realize that you can't re-use _any_ 
of the existing chip drivers, and you'll have to write your own. If the 
bus is exotic enough, that's not a problem, and you'd have to do that 
anyway. But there really aren't all that many "exotic" buses around any 
more.

Quite frankly, of your two suggested interfaces, I would select neither. 
I'd just say that if your bus is special enough, just write your own 
drivers, and use

	cookie = ixp4xx_iomap(dev, xx);
	...
	ixp4xx_iowrite(val, cookie + offset);

which is perfectly valid. You don't have to make these devices even _look_ 
like a PCI device. Why should you?

		Linus
