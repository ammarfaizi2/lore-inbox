Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbULVLQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbULVLQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbULVLQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:16:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19871 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261965AbULVLQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:16:47 -0500
Date: Wed, 22 Dec 2004 12:16:43 +0100
From: Jens Axboe <axboe@suse.de>
To: "M. Edward Borasky" <znmeb@cesmail.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Negative "ios_in_flight" in the 2.4 kernel
Message-ID: <20041222111642.GD12463@suse.de>
References: <1103691937.23157.14.camel@DreamGate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103691937.23157.14.camel@DreamGate>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21 2004, M. Edward Borasky wrote:
> I've been looking at some "iostat" data from a 2.4.26 machine. The
> device utilizations are 100 percent, even when the disk is idle, which
> is mathematically impossible. By doing some digging, I discovered this
> is a kernel bug, caused by "hd->ios_in_flight" going negative. The
> relevant code appears to my untrained eyes to be in
> drivers/block/ll_rw_blk.c, specifically
> 
> 
> static inline void down_ios(struct hd_struct *hd)
> {
>         disk_round_stats(hd);
>         --hd->ios_in_flight;
> }
> 
> static inline void up_ios(struct hd_struct *hd)
> {
>         disk_round_stats(hd);
>         ++hd->ios_in_flight;
> }
> 
> Question: wouldn't a simple refusal to decrement ios_in_flight in
> "down_ios" if it's zero fix this, or am I missing something?

That would paper over the real bug, but it will work for you.

-- 
Jens Axboe

