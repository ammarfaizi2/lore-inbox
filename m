Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGILV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbTGILV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:21:28 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:6103 "EHLO gaston")
	by vger.kernel.org with ESMTP id S265976AbTGILV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:21:27 -0400
Subject: Re: [Linux-fbdev-devel] fbdev and power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057750557.514.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 13:35:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No patches at this time. I need to learn the new power management code. 
> Where are the docs for them ? 

The PM code in radeonfb is probably only useful for Mac laptops where
we have to manually put the chip in D2 state. I don't think x86 laptops
use D2...

Note that I have a patch adding some basic PM support to fbdev in 2.5
that I need to send you for review. The PM is always initiated by the
low level driver which gets notified of PM events by its parent bus,
what I added is a way for the driver to "broadcast" that to clients
like fbcon so fbcon can stop touching the framebuffer while the chip
is potentially off, and can restore the display on wakeup.

I'll send that to you asap. 

Note: The Power Management isn't well implemented in 2.5 yet. The
infrastructure is mostly there, but the driver side semantics are
still wrong. Patrick Mochel has a new implementation that is much
better, but he didn't merge it upstream yet. I expect this will
happen around Kernel Summit / OLS.

Ben.

