Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIOXMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIOXMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:09:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:57058 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267751AbUIOXJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:09:09 -0400
Date: Wed, 15 Sep 2004 16:09:04 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915230904.GA19450@plexity.net>
Reply-To: dsaxena@plexity.net
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915222157.GA17284@plexity.net> <Pine.LNX.4.58.0409151540260.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151540260.2333@ppc970.osdl.org>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15 2004, at 15:46, Linus Torvalds was caught saying:
> Quite frankly, of your two suggested interfaces, I would select neither. 
> I'd just say that if your bus is special enough, just write your own 
> drivers, and use
> 
> 	cookie = ixp4xx_iomap(dev, xx);
> 	...
> 	ixp4xx_iowrite(val, cookie + offset);
> 
> which is perfectly valid. You don't have to make these devices even _look_ 
> like a PCI device. Why should you?

Problem is that some of those devices are not that special. For example,
the on-board 16550 is accessed using readb/writeb in the 8250.c driver.
I don't think we want to add that level of low-level detail to that
driver and instead should just hide it in the platform code. I look
at it from the point of view that the driver should not care about how
the access actually occurs on the bus. It just says, write data foo at
location bar regardless of whether bar is ISA, PCI, on-chip, RapidIO,
etc and that writing of the data is hidden in the implementation of
the accessor API.

~Deepak


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
