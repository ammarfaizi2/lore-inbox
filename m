Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUK1WHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUK1WHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUK1WHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:07:07 -0500
Received: from ozlabs.org ([203.10.76.45]:19389 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261161AbUK1WHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:07:01 -0500
Subject: Re: getting rid of inter_module_xx
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098635275.24241.7.camel@localhost.localdomain>
References: <9e473391041022100835da7baf@mail.gmail.com>
	 <20041023094413.GA30137@infradead.org>
	 <1098635275.24241.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 09:06:57 +1100
Message-Id: <1101679617.25347.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 17:27 +0100, Alan Cox wrote:
> On Sad, 2004-10-23 at 10:44, Christoph Hellwig wrote:
> > not at all.  Everything else in the kernel is compile-time depencies.
> > Just make the agp backend module mandatory if CONFIG_AGP is set, you'll
> > lose tons of complexity at a minimum amount of used memory, and as an
> > added benefit look like the rest of the kernel.
> 
> Thats completely stupid
> 
> CONFIG_AGP enables the building of AGP modules, it does not disable the
> ability to run that kernel on non AGP setups, or to use non AGP video
> cards.
> 
> The relationship is dynamic and you'd need to fix the various drivers
> that support both PCI and AGP mode by compiling them twice so you can
> load them with or without agp support.
> 
> Yuck yuck yuck. It would instead be much saner to fix the module loader
> to support weak symbols.

Well, we do support weak symbols, and we also support dynamic symbol
resolution using symbol_get (or symbol_request which probes for the
module if CONFIG_KMOD) and symbol_put.

It's just the inter_module* mechanism which I dislike.
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

