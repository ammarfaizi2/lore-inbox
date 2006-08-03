Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWHCR2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWHCR2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWHCR2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:28:45 -0400
Received: from thunk.org ([69.25.196.29]:5042 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964802AbWHCR2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:28:44 -0400
Date: Thu, 3 Aug 2006 13:28:36 -0400
From: Theodore Tso <tytso@mit.edu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803172836.GF20603@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, mchan@broadcom.com
References: <20060803075704.GC27835@thunk.org> <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au> <20060803163204.GB20603@thunk.org> <20060803094917.8280f5ff.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803094917.8280f5ff.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 09:49:17AM -0700, Randy.Dunlap wrote:
> Interesting.  On my Dell D610 notebook with tg3 and vpn,
> I have to ping a server on the vpn to keep it alive, otherwise
> it disappears soon and I have to restart the vpn.  Of course,
> this could just be the vpn or some other software problem
> instead of a tg3 problem.

That sounds almost certainly like a VPN problem.  The tg3_timer() code
wakes up every second or tenth of a second (depending on which mode
you're in) and takes care of keeping the tg3 hardware mollified.  On a
standard kernel, this shouldn't ever be an issue.  For the -rt kernel,
this problem only shows up if you have enough tasks running at
rtprio's above the rtprio of the softirq-timer for long enough that
tg3 chip gets angry....

						- Ted
