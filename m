Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUASQZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUASQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:25:24 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:63903 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265295AbUASQZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:25:22 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 19 Jan 2004 17:05:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: caszonyi@rdslink.ro, linux-kernel@vger.kernel.org
Subject: Re: Fw: Slab coruption and oops with 2.6.1-mm4
Message-ID: <20040119160512.GB8321@bytesex.org>
References: <20040118220051.3f3d8420.akpm@osdl.org> <20040119121546.GD5498@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119121546.GD5498@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > CONFIG_PREEMPT=y
> 
> Bug reproducable with this one turned off?

Hmm, running -mm4 with CONFIG_PREEMPT now, box loaded with bttv capture
+ parallel kernel builds, no problems so far ...

> > Slab corruption: start=c57c2000, len=4096
                           ^^^^^^^^
> > 000: 6e 72 6d 71 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > bttv0: skipped frame. no signal? high irq latency? [main=b030000,o_vbi=b030018,o_field=5378000,rc=537801c]

Who is this?  Is this allocated by bttv?  Or someone else corrupts
memory here?

btcx-risc and video-buf have a "debug=1" insmod option, bttv has
"bttv_debug=1".  Those make bttv verbose (*plenty* of log, so better
don't try all three at the same time ...) and also log addresses of
(some) allocated memory blocks.

btcx-risc calls pci_alloc_consistent() and thus does PAGE_SIZE
allocations, that one likely is a good candidate to start with.

  Gerd

