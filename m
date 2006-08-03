Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWHCQcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWHCQcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWHCQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:32:12 -0400
Received: from thunk.org ([69.25.196.29]:64989 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964833AbWHCQcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:32:10 -0400
Date: Thu, 3 Aug 2006 12:32:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
       mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803163204.GB20603@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, mchan@broadcom.com
References: <20060803075704.GC27835@thunk.org> <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:00:35PM +1000, Herbert Xu wrote:
> Theodore Tso <tytso@mit.edu> wrote:
> > 
> > I'm sending this on mostly because it was a bit of a pain to track down,
> > and hopefully it will save time if anyone else hits this while playing
> > with the -rt kernel.  It is NOT the right way to fix things, so please
> > don't even think of applying this patch (unless you need it, in your own
> > local tree :-).
> > 
> > One of these days when we have time to breath we'll look into fixing
> > this the right way, if someone doesn't beat us to it first.  :-)
> 
> You probably should resend the patch to netdev and Michael Chan
> <mchan@broadcom.com>.  He might have ideas on how this could be
> avoided.

This only shows up with the real-time kernel where timer softirq's run
in their own processes, and a high priority process preempts the timer
softirq.  I don't really consider this a networking bug, or even
driver bug, although it does seem unfortunate that Broadcom hardware
locks up and goes unresponsive if the OS doesn't tickle it every tenth
of a second or so.  (Definitely a bad idea if the tg3 gets used on any
laptops, from a power usage perspective.)  But that seems like a
(lame) hardware bug, not a driver bug....

						- Ted

