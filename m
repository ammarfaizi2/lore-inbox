Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVJCQ0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVJCQ0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJCQ0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:26:51 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:3274 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751107AbVJCQ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:26:51 -0400
X-ORBL: [69.107.75.50]
Date: Mon, 03 Oct 2005 09:26:46 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com
Subject: Re: [PATCH] SPI
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003162646.17F09EE8D2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>It'd be fine if for example your PNX controller driver worked that way
> >>>internally.  But other drivers shouldn't be forced to allocate kernel
> >>>threads when they don't need them.
> ...
> FYI in brief: for PREEMPT_RT case all the interrupt handlers are working 
> in a separate thread each unless explicitly specified otherwise.

I'm fully aware of that; not that it matters much for folk who aren't
building and deploying systems with PREEMPT_RT.


> We will definitely have less SPI busses => less kernel threads, so I 
> doubt there's a rationale in your opinion.

The rationale is simple:  you're trying to force one implementation
strategy.  Needlessly forcing one strategy, even when others may be
better (I already gave three examples), is a bad idea.  QED.  :)


> >Well "prevent" may be a bit strong, if you like hopping levels in
> >the software stack.  I don't; without such hopping (or without a
> >separate out-of-band mechanism like device tables), I don't see
> >a way to solve that problem.
>
> Aren't the tables you're suggesting also kinda out-of-band stuff?

I just described them that way; yes.  They're not layer hopping though;
they preserve the distinctions in roles and responsibilities which help
keep components from interfering with each other.

One general point is that when hardware doesn't support autoconfiguration,
something out-of-band is required to plug that hole.  In this case,
those tables can be segmented to handle SPI devices on both mainboards
and add-on boards.  Ditto for SPI controllers, but that mostly matters
for developer tools like parport adapters.

- Dave


