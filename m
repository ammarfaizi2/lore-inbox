Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbULBWcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbULBWcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbULBWcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:32:18 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:49314 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261782AbULBWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:32:15 -0500
Date: Thu, 2 Dec 2004 23:31:46 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041202223146.GA31508@zaphods.net>
References: <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202210348.GD20771@mail.muni.cz>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 10:03:48PM +0100, Lukas Hejtmanek wrote:
> > > I found out that 2.6.6-bk4 kernel is OK. 
> > That kernel didn't have the TSO thing.  Pretty much all of these reports
> > have been against e1000_alloc_rx_buffers() since the TSO changes went in.
> > Did you try disabling TSO, btw?
> I did it. Allocation failure is still there :(
I had no luck with/without TSO either but on tg3.
I disabled the on-disk-caching component of the application and it now runs
without page allocation errors. Currently it is running smoothly at ~500mbit/s
and ~80kpps in each direction at ~44k interrupts/s, so the problematic
combination seems to be many open files, high i/o transaction rate or
troughput and heavy networking load. (tso currently on)
Caching on ext2-fs in general seemed to generate less page allocation errors
than on xfs and none of the traces i looked over so far showed involvement
of the filesystem i.e. were all triggered by alloc_skb.

	Stefan
