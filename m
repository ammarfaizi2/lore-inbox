Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270475AbTGNAd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270474AbTGNAdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:33:44 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:58002 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270475AbTGNAdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:33:39 -0400
Date: Sun, 13 Jul 2003 17:48:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, roland@topspin.com, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-ID: <20030714004809.GB24697@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, Larry McVoy <lm@bitmover.com>,
	roland@topspin.com, alan@storlinksemi.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com> <52u19qwg53.fsf@topspin.com> <20030713160200.571716cf.davem@redhat.com> <20030713233503.GA31793@work.bitmover.com> <20030713164003.21839eb4.davem@redhat.com> <20030713235424.GB31793@work.bitmover.com> <20030713165323.3fc2601f.davem@redhat.com> <20030714002200.GA24697@work.bitmover.com> <20030713172414.5c888094.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713172414.5c888094.davem@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 05:24:14PM -0700, David S. Miller wrote:
> I can't see any part of this turning out to be expensive.

In theory, practice and theory are the same...

I think the point I'm trying to make is that the VM stuff costs something
and it shouldn't be that hard to dummy up a system call to measure it.

It was counterintuitive as hell at SGI that the VM stuff would cost that
much and the reasons are subtle.  Part of the problem turned out to be
falling out of the instruction cache - the network stack and the VM system
didn't fit and that left no room at all for the app.  

If you are trading instruction cache misses for data misses, err, dude,
I think that might be a problem.  The point is to process all the data
with less, not more, cache misses, right?  In fact, if we agree on that
then that leads you to considering the various ways you could do this
and maybe your way is the right way but maybe there is a less cache 
intensive way.

If you're right you're right, so peace.  But I'd like the definition of
"right" to be "less cache misses to do the same thing".  In fact, if
I managed to communicate only one thing in my entire set of rants and
it was "pay attention to cache misses", hey, that'd be cool with me.
That's how you make things go fast and I like fast.

Think about it, a 3GHz machine is a .3ns clock cycle and the suckers are
super scalar and hyper threaded and all that crud.  Memory is about 133ns
away.  That's 400 clocks of stall for each cache miss.  Lotta code can run
in 400 clocks of super scalar/hyper threaded/fully buzzword enabled processors.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
