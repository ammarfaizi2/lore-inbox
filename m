Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTIASHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIASHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263181AbTIASHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:07:48 -0400
Date: Mon, 1 Sep 2003 15:10:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64 bit jiffies for 2.4.23-pre2
In-Reply-To: <Pine.LNX.4.33.0308311241300.19402-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.44.0309011509270.6008-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Aug 2003, Tim Schmielau wrote:

> Hi Marcelo,
> 
> this patch makes the jiffies wrap after 497 days transparent to the user.
> While it allows uptimes of more than 497 days to be displayed, it's main
> use is to keep 'ps aux' output correct after the wrap. Without this patch,
> ps output will look very messy then with processes being reported as
> having started in the future.
> 
> For minimal intrusiveness it does not touch jiffies itself but introduces
> a (2.6 compatible) get_jiffies_64() function that keeps a private counter
> of the upper 31 bits, updated by a timer. user, nice, system, and idle
> times are handled similarely if the /proc filesystem is present.
> Process start time is extended to 64 bits.
> The patch should collapse to a no-op on 64 bit systems except for
> extending the per_cpu_user, per_cpu_nice, and per_cpu_system variables in
> struct kernel_stat to 64 bits (needed even there for correct display after
> 497 days).
> 
> The patch has been around for almost two years, discussed extensivly on
> lkml, tested with simulated uptime, and recently got its first real life
> success report (thanks Willy!).
> I think it's the most appropriate solution for 2.4. But you need to decide
> whether you take this, whether someone should backport the (intrusive and
> architecture-dependent) 2.6 fix, or whether you drop it completly and let
> people just upgrade to 2.6.

Sincerely, I prefer people use 2.6. 

Thanks

