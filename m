Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVI1Qbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVI1Qbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVI1Qby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:31:54 -0400
Received: from ns2.limegroup.com ([66.92.115.81]:24472 "EHLO ns2.limegroup.com")
	by vger.kernel.org with ESMTP id S1751392AbVI1Qbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:31:52 -0400
Date: Wed, 28 Sep 2005 12:31:33 -0400 (EDT)
From: Ion Badulescu <lists@limebrokerage.com>
X-X-Sender: ion@ionlinux.tower-research.com
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050902183656.GA16537@yakov.inr.ac.ru>
Message-ID: <Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
 <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <20050902183656.GA16537@yakov.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Fri, 2 Sep 2005, Alexey Kuznetsov wrote:

> Anyway, ignoring this puzzle, the following patch for 2.4 should help.
>
>
> --- net/ipv4/tcp_input.c.orig	2003-02-20 20:38:39.000000000 +0300
> +++ net/ipv4/tcp_input.c	2005-09-02 22:28:00.845952888 +0400
> @@ -343,8 +343,6 @@
> 			app_win -= tp->ack.rcv_mss;
> 		app_win = max(app_win, 2U*tp->advmss);
>
> -		if (!ofo_win)
> -			tp->window_clamp = min(tp->window_clamp, app_win);
> 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
> 	}
> }

I'm very happy to report that the above patch, applied to 2.6.12.6, seems 
to have cured the TCP window problem we were experiencing. I've been 
testing it extensively over the last 4 weeks, and I have yet to see any 
repeats of the previous behavior.

The TCP window now usually settles to around 4k (unscaled, 16k scaled),
which is smallish but good enough for our purposes.

Thanks,
-Ion
