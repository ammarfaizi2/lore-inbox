Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVAJCnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVAJCnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAJCnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:43:31 -0500
Received: from waste.org ([216.27.176.166]:27045 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261890AbVAJCn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:43:28 -0500
Date: Sun, 9 Jan 2005 18:43:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvads@osdl.org, akpm@osdl.org, jlan@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Move accounting function calls out of critical vm code paths
Message-ID: <20050110024320.GD2995@waste.org>
References: <Pine.LNX.4.58.0501051651140.10377@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501051651140.10377@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 04:55:14PM -0800, Christoph Lameter wrote:

> One disadvantage is that rss etc may now peak between stime
> increments without being noticed. But I think we are mostly
> interested in prolonged memory use rather than accurate data on the
> max rss ever reached.

This has the downside that applications may die well after the event
that caused the excess. Also, I can see situations in RT where strict
limits are put in place to ensure that particular apps are never
starved so strict accounting is occassionally desireable.

Perhaps we could do the accounting on the fly iff we have an rlimit in
the first place and we're already over half of it? Such strict
accounting could triggered by a process flag turned off and on inside
acct_update_integrals.

One also wonders if once per timer tick is more processing for compute
intensive workloads.

Finally, do { } while (0); is a bit of cargo cult. The compilers no
longer warn for empty statements so a null #define is fine.

-- 
Mathematics is the supreme nostalgia of our time.
