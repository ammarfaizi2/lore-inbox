Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUC0PRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUC0PRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:17:39 -0500
Received: from waste.org ([209.173.204.2]:11490 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261786AbUC0PRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:17:38 -0500
Date: Sat, 27 Mar 2004 09:17:29 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/22] /dev/random: kill batching of entropy mixing
Message-ID: <20040327151728.GA6248@waste.org>
References: <21.524465763@selenic.com> <22.524465763@selenic.com> <20040327135245.GD21884@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327135245.GD21884@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 01:52:45PM +0000, Jamie Lokier wrote:
> Matt Mackall wrote:
> > Rather than batching up entropy samples, resulting in longer lock hold
> > times when we actually process the samples, mix in samples
> > immediately. The trickle code should eliminate almost all the
> > additional interrupt-time overhead this would otherwise incur, with or
> > without locking.
> 
> What do you mean by "the trickle code"?  I didn't see anything in your
> patch set which makes the interrupt-time overhead faster.

This code which is in the existing driver to prevent pathological lock
contention on large SMP:

        /* if over the trickle threshold, use only 1 in 4096 samples
	*/
        if ( input_pool.entropy_count > trickle_thresh &&
             (__get_cpu_var(trickle_count)++ & 0xfff))
                return;

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
