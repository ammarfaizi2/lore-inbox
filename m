Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263287AbTCYUAK>; Tue, 25 Mar 2003 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbTCYUAK>; Tue, 25 Mar 2003 15:00:10 -0500
Received: from AMarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200]:49959
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263287AbTCYUAJ>; Tue, 25 Mar 2003 15:00:09 -0500
Subject: Re: [BK FBDEV] A few more updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303251947020.6228-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303251947020.6228-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048623026.10476.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 21:10:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 20:48, James Simmons wrote:

> > Well, actually, creating a workqueue would be overhead since
> > it involves one kernel thread per CPU. After more thinking &
> > discussion, I beleive you shall rather use keventd existing
> > workqueue (schedule_work() will do that)
> 
> Done. Can you look over this patch and test it. I tested it and it worked 
> fine.

I don't have a test config at hand right now. The patch looks better,
though you didn't remove the spinlock and replace it with some
"softer" sync. primitives.

Note that if fbcon is ever to be rmmod'ed, you need to properly
remove the timer and make sure all pending work queues have completed
(and make sure the timer won't be re-scheduled by one).

Ben.

