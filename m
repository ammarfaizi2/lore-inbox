Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWHGPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWHGPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWHGPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:00:57 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:58346 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750930AbWHGPA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:00:56 -0400
Date: Mon, 7 Aug 2006 17:00:29 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
Message-ID: <20060807170029.3e8c829d@cad-250-152.norway.atmel.com>
In-Reply-To: <1154682379.31031.190.camel@shinybook.infradead.org>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	<1154680798.31031.179.camel@shinybook.infradead.org>
	<20060804105220.6d125976@cad-250-152.norway.atmel.com>
	<1154682379.31031.190.camel@shinybook.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 17:06:19 +0800
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2006-08-04 at 10:52 +0200, Haavard Skinnemoen wrote:
> > It is actually a CFI chip. But I couldn't figure out how to install
> > the fixup in the other patch in the CFI code. The AT49BV6416 chip
> > identifies itself as using the AMD command set, so the fixup must be
> > installed based on the jedec ID... 
> 
> Er, note that the _correct_ answer is to advertise the availability of
> the lock functionality in the CFI 'extended query' information. Did
> the hardware designer screw that up?

I can't find any information about the softlock feature in the PRI
block. However, the AT49BV6416 is obsolete, and the replacement chip,
AT49BV642D, does not power up locked. We'll be using AT49BV642D for new
designs, but in order to support the AT32STK1000 development board, we
need to install a fixup for AT49BV6416.

Another issue is that Atmel uses a different PRI block than AMD. I can
work around this by installing a CFI fixup that converts the Atmel PRI
block to look like an AMD block.

Alternatively, we could define a vendor-independent format with just
the information we need and select different readers/parsers based on
the JEDEC manufacturer ID. Do you know if there are other vendors using
the AMD command set but a different PRI format?

Haavard
