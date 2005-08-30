Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVH3Ub0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVH3Ub0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVH3Ub0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:31:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28995
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932439AbVH3UbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:31:25 -0400
Date: Tue, 30 Aug 2005 22:31:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830203120.GX8515@g5.random>
References: <194B303F2F7B534594F2AB2D87269D9F06EFAE48@orsmsx408>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06EFAE48@orsmsx408>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:08:38AM -0700, Wilkerson, Bryan P wrote:
> they're work, I'm not sure I'd trust or use the data unless it was
> somehow authenticated.  

I doubt many testers would be willing to register on yet another website
just for this. So I doubt adding authentication is a good idea.

However if you really want to authenticate I could add an email based
authentication method similar to the CPUShare authentication method that
is already implemented and fully secure.

Then I can add a button to hide all not authenticated users from the
listing. Things will be substantially more complicated on the server
side, so I'd rather prefer that we solve the below points first.

> 2. Some of us sit behind corporate firewalls and proxies that have
> oppressive rules that would have made Stalin proud.  The solution must
> be proxy aware and if it used HTTP, even better because it's more likely
> to work anywhere.  The proxy settings could also be a .config thing.  

I can easily add a second entry point to the server that can pass
through the proxy no problem.

> 3. Again security; I haven't cleared this with my corporate superiors
> but I'm not sure they'll like the fact that anyone could intercept the
> data and compute how many people in the company are running Linux test
> kernels.  I know this almost sounds anti-open but we're breaking them in
> slowly to the model and I don't think they are ready for this one just
> yet. :)

Sure I understand, KLive wasn't thought in terms of corporate firewalls
that must hide anything behind the firewall (I wonder how the proxy
prevents the people to search in google though, I bet a few of the
cleartext search queries and the syn and tcp timestamp sequence numbers
will reveal much more than whatever could ever be sent to klive in
cleartext ;).

Then I guess all you need is that I use a https instead of http for the
secondary entry point discussed above (assuming your proxy lets you do
https).

Still the routing points of the internet could count the syn packets
that you send to klive.cpushare.com and by watching the statistics with
many computers coming from the same host md5-sum they may be able to
guess which is the "host" that corresponds to the IP that is sending
the many syns.

So before I add features for your special needs I'd rather make sure
that you can live with this worst case condition of the "syn" guessing
coming from your proxy and with destination klive.cpushare.com.

Thanks a lot!
