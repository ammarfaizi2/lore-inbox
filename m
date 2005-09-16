Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVIPRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVIPRZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbVIPRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:25:05 -0400
Received: from [139.30.44.2] ([139.30.44.2]:18180 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1030472AbVIPRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:25:02 -0400
Date: Fri, 16 Sep 2005 19:25:00 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tim Bird <tim.bird@am.sony.com>
cc: jesper.juhl@gmail.com, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
In-Reply-To: <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.61.0509161920370.31820@gans.physik3.uni-rostock.de>
References: <9a87484905091515495f435db7@mail.gmail.com> <432AFB01.3050809@am.sony.com>
 <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Tim Schmielau wrote:

> So, one jump (probably the first) happens when time_init sets use_tsc.
> Do we understand the other jump as well?

OK, looking at the numbers we have just one time-jump:

> [4294667.296000] CPU 0 irqstacks, hard=c03d2000 soft=c03d1000
> [4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
> [    0.000000] Detected 1400.279 MHz processor.
> [   27.121583] Using tsc for high-res timesource
> [   27.121620] Console: colour dummy device 80x25
> [   27.122909] Dentry cache hash table entries: 131072 (order: 7, 524288

The "Detected 1400.279 MHz processor." line just happens to be written
_during_ time_init, when use_tsc is already set, but cycles_2_ns is not
yet initialized.

So I think everything is well-understood. It's just a matter of whether 
it's worth fixing.

Tim
