Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279272AbRJWIkJ>; Tue, 23 Oct 2001 04:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279320AbRJWIj7>; Tue, 23 Oct 2001 04:39:59 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:51468 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S279272AbRJWIjq>;
	Tue, 23 Oct 2001 04:39:46 -0400
Message-ID: <20011023124759.A3949@castle.nmd.msu.ru>
Date: Tue, 23 Oct 2001 12:47:59 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <Pine.LNX.4.33.0110201937020.23322-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.33.0110201937020.23322-100000@u.domain.uli>; from "Julian Anastasov" on Sat, Oct 20, 2001 at 07:56:47PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 20, 2001 at 07:56:47PM +0000, Julian Anastasov wrote:
> 
> Andrey Savochkin wrote:
> 
> > Well, what I want is to make the host an arp "proxy" on all interfaces for
> > all addresses reachable through devX.  I do not want to mess with how
> > customer configures all other interfaces.
> > Right now all routes to devX are /32, for all of them proxy arp entries are
> > created by the same script, and all are happy.
> >
> > How can it be done better?
> > New mechanism of fine-grained control over proxy arp? :-)
> 
> 	I can tell you what Alexey and Andrey will answer on netdev :)
> Make proxyarp a route flag. When arp_filter is not suitable for filtering

I may end up doing it, but I don't share Alexey's enthusiasm about
removing the options from ip and moving to some fine-grained control over
proxy arp.

I certainly prefer simpler solutions.
Solutions based on static configuration, without dynamic resolution
protocols, are simpler.
That is what I have now: I add entries, which I want to expose and to be used
for answering arp requests, one by one by `ip proxy neigh add'.
Simpler solutions are less error-prone and more easy to debug.

	Andrey

> non-local input routes you can also solve the problem with the route's
> noarp flag (known in netdev). The proxyarp flag for route can allow
> the feature to work even on one device (indev==outdev) may be for NAT
> purposes), probably running send_redirects=0 (send_redirects is another
> candidate for a route flags). Of course, the target hosts should filter
> these ARP probes with a simple rp_filter policy, only our box should
> reply. We need only space for route flags and imagination :)
