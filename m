Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263236AbTCYSZ6>; Tue, 25 Mar 2003 13:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTCYSZ6>; Tue, 25 Mar 2003 13:25:58 -0500
Received: from AMarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200]:22823
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263230AbTCYSZv>; Tue, 25 Mar 2003 13:25:51 -0500
Subject: Re: [BK FBDEV] A few more updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048616901.10476.3.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
	 <1048616901.10476.3.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048617354.10476.6.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 19:35:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 19:28, Benjamin Herrenschmidt wrote:

> You "fixed" it by using GFP_ATOMIC but didn't test the result of
> kmalloc. That is very bad. GFP_ATOMIC can fail (return NULL), thus
> you will crash the kernel under high memory pressure.
> 
> I think the proper fix is, as you asked me, using a workqueue,
> that way, you can both use GFP_KERNEL allocations, and avoid
> the spinlock you added to fbmem.c, thus letting the fb_sync()
> ops on fbdev's be able to block.

Well, actually, creating a workqueue would be overhead since
it involves one kernel thread per CPU. After more thinking &
discussion, I beleive you shall rather use keventd existing
workqueue (schedule_work() will do that)

Ben.

