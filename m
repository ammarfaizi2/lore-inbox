Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271665AbRICKhz>; Mon, 3 Sep 2001 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271672AbRICKhq>; Mon, 3 Sep 2001 06:37:46 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:49932 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271665AbRICKh2>;
	Mon, 3 Sep 2001 06:37:28 -0400
Message-ID: <20010903144442.A32332@castle.nmd.msu.ru>
Date: Mon, 3 Sep 2001 14:44:42 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxy support in 2.4 - revisited
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il> <20010608014443.A28407@saw.sw.com.sg> <20010903131240.A9791@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010903131240.A9791@leeor.math.technion.ac.il>; from "Nadav Har'El" on Mon, Sep 03, 2001 at 01:12:40PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 03, 2001 at 01:12:40PM +0300, Nadav Har'El wrote:
> A few months ago, I asked on this list why the transparent proxy feature
> (CONFIG_IP_TRANSPARENT_PROXY) that was supported in Linux 2.2 is no longer
> supported in Linux 2.4:
> 
[snip]
> Andrey Savochkin wrote a useful reply, on how to make the connect work():
> 
> > To make a custom kernel where you can use non-local addresses more freely,
> > find source address checks in ip_route_output_slow() and get rid of all of
> > them except considering
> > 	MULTICAST(saddr) || BADCLASS(saddr) || ZERONET(saddr) ||
> > 		saddr == htonl(INADDR_BROADCAST)
> > as invalid.
> 
> I did that, and indeed now connect() works, and sends out (when considering
> TCP) the appropriate SYN packet.
> 
> Unfortunately, that's not enough. When the return SYN-ACK packet carrying a
> non-local destination address is received (in practice, the transparent
> proxy machine is acting as a default gateway to the other machine), this
> packet is either ignored or forwarded out (depending on ip_forward), but is
> never accepted as a local packet and transfered to the appropriate socket
> as it should.

Right.
In 2.2 kernel you also needed to configure which incoming packets you want to
handle locally.

If you want to handle locally all packets destined to a specific IP address,
just add local route.
If you want some complex matching rules, check iptables, there was something
about "redirects" there.  Alternatively, you may set up policy routing, but
it'll be considerably more difficult.

You seemed to start to solve your problems from the wrong end.
First of all, decide how to handle incoming packets.
Then consider outgoing.

	Andrey
