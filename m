Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVBAVO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVBAVO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBAVO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:14:28 -0500
Received: from waste.org ([216.27.176.166]:5837 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262125AbVBAVOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:14:25 -0500
Date: Tue, 1 Feb 2005 13:14:05 -0800
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 2/6 introduce helper infrastructure
Message-ID: <20050201211405.GA17460@waste.org>
References: <20050127101117.GA9760@infradead.org> <20050127101228.GC9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101228.GC9760@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:12:28AM +0000, Arjan van de Ven wrote:
> 
> 
> The patch below introduces get_random_int() and randomize_range(), two
> helpers used in later patches in the series. get_random_int() shares the
> tcp/ip random number stuff so the CONFIG_INET ifdef needs to move slightly,
> and to reduce the damange due to that, secure_ip_id() needs to move inside
> random.c

Sorry I'm a bit behind on the list, but this is going to conflict with
the random.c changes in -mm, where all the network-specific bits were
moved off to net/.

I'm not against adding a generic fast PRNG here, but this way is
backwards. Let's instead make a new function get_prng_int() and
convert the network bits to use it.

-- 
Mathematics is the supreme nostalgia of our time.
