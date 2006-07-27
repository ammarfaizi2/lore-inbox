Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWG0Jbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWG0Jbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWG0Jbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:31:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1666
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751032AbWG0Jbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:31:36 -0400
Date: Thu, 27 Jul 2006 02:31:56 -0700 (PDT)
Message-Id: <20060727.023156.61758783.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060727085812.GA24529@2ka.mipt.ru>
References: <20060727074902.GC5490@2ka.mipt.ru>
	<20060727.010255.87351515.davem@davemloft.net>
	<20060727085812.GA24529@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Thu, 27 Jul 2006 12:58:13 +0400

> Btw, according to DMA allocations - there are some problems here too.
> Some pieces of the world can not dma behind 16mb, and someone can do it
> over 4gb.

I think people take this "DMA" in Ulrich's interface names too
literally.  It is logically something different, although it could be
used directly for this purpose.

View it rather as memory you have by some key based ID, but need to
explicitly map to access directly.

> Those physical pages can be managed within kernel and userspace can map
> them. But there is another possibility - replace slab allocation for
> network devices with allocation from premapped pool.
> That naturally allows to manage that pool for AIO needs and have
> zero-copy sending and receiving support. That is what I talked in
> netchannel topic when question about allocation/freeing cost in atomic
> context arised. I work on that solution, which can be used both for
> netchannels (and full userspace processing) and usual networking code.

Interesting idea, and yes I have been watching you stress test your
AVL tree code :))
