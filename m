Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVK3Vgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVK3Vgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVK3Vgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:36:40 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:33713 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750857AbVK3Vgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:36:40 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Wed, 30 Nov 2005 13:36:38 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051130195053.713ea9ef.vwool@ru.mvista.com>
In-Reply-To: <20051130195053.713ea9ef.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511301336.38613.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 8:50 am, Vitaly Wool wrote:

> However, there also are some advantages of our core compared to David's I'd like to mention

I'd also be interested in your responses to the comparison I wrote up last week.
(Post dated 23-November to that spi-devel list...)


> - it can be compiled as a module

Which as I pointed out would be a rather minor patch to mine.  There's a
bit of code to manage the board-specific SPI tables, which _can't_ be
a module.  Then there's something less than 2KB of code (ARM .text) that
could live in a module.  I can't get excited about making that live in
a module, but I'd take a patch to change that.


> - it is DMA-safe

Which as I pointed out is incorrect.  The core API (async) has always
been fully DMA-safe.  And a **LOT** lower overhead than yours, which
allocates buffers behind the back of drivers, and encourages lots of
memcpy rather than just doing DMA directly to/from the buffers that
are provided by the SPI protocol drivers.


> - it is priority inversion-free
> - it can gain more performance with multiple controllers
> - it's more adapted for use in real-time environments

You'd have to explain what you mean by all of these.  I could guess
based on what you've said before (disagree!), but that won't help.


> - it's not so lightweight, but it leaves less effort for the bus driver developer.

Whereas in my previous comments about your framework, I think I've
pointed out that imposing needless and restrictive policies on how
the controller drivers work is a Bad Thing.

- Dave

