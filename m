Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVBYDCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVBYDCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 22:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVBYDCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 22:02:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:32473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262599AbVBYDCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 22:02:18 -0500
Date: Thu, 24 Feb 2005 19:02:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
Message-ID: <20050225030208.GV15867@shell0.pdx.osdl.net>
References: <20050225021209.GU15867@shell0.pdx.osdl.net> <200502250216.j1P2GJrL016564@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502250216.j1P2GJrL016564@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> > Yeah, it fixes the issue, but opens the door to larger consumption of
> > pending signals.  Roland, what was your final preference?  I'm kind of
> > leaning towards Jeremy's original patch.
> 
> It's not a matter of preference.  As I said in the first place, without my
> patch we are violating POSIX, and delivering unreliable results to users.

Right, and as you also mentioned, it's identical case to exhausting
atomic pool, in either case we're out of resources, and in both cases the
machine may recover and be functional.  And sneaking around the rlimit
can cost ~4k per-process, which is why I'd consider the edge case a
reasonable loss.  (heck, maybe 4k is fine considering task size, and
mlock limits, etc).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
