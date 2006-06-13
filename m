Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWFMXdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWFMXdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWFMXdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:33:43 -0400
Received: from waste.org ([64.81.244.121]:12516 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964798AbWFMXdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:33:42 -0400
Date: Tue, 13 Jun 2006 18:22:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Mark Lord <lkml@rtr.ca>
Cc: David Miller <davem@davemloft.net>, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
Message-ID: <20060613232255.GA8325@waste.org>
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org> <448F0344.9000008@rtr.ca> <448F0D4B.30201@rtr.ca> <20060613.142603.48825062.davem@davemloft.net> <448F32E1.8080002@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F32E1.8080002@rtr.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 05:49:21PM -0400, Mark Lord wrote:
> 
> 
> David Miller wrote:
> >..
> >First, you are getting window scaling by default with the older
> >kernel too.  It's just a smaller window scale, using a shift
> >value of say 1 or 2.
> >
> >What these broken middle boxes do is ignore the window scale
> >entirely.
> >
> >So they don't apply a window scale to the advertised windows in each
> >packet.  Therefore, they think a smaller amount of window space is
> >being advertised than really is.  So they will silently drop packets
> >they think is outside of this bogus window they've calculated.
> >
> >Now, when the window scale is smaller, the connection can still limp
> >along, albeit slowly, making forward progress even in the face of such
> >broken devices because half or a quarter of the window is still
> >available.  It will retransmit a lot, and the congestion window won't
> >grow at all.
> >
> >When the window scale is larger, this middle box bug makes it such
> >that not even one packet can fit into the miscalculated window and
> >things wedge.  The box thinks that your window is "94" instead of
> >"94 << WINDOW_SCALE".
> ..
> 
> Unilaterally following the standard is all well and good
> for those who know how to get around it when a site becomes
> inaccessible, but not for Joe User.

We had very similar issues with ECN. But unlike ECN, window scaling is
not something we can just shrug our shoulders and say "oh well" about.
We will have to deal with it eventually. It might as well be sooner.

-- 
Mathematics is the supreme nostalgia of our time.
