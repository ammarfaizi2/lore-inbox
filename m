Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTHSVxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTHSVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:53:34 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20882 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261556AbTHSVx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:53:29 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 23:53:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: richard@aspectgroup.co.uk, davem@redhat.com, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819235326.2920dacf.skraw@ithnet.com>
In-Reply-To: <1061320099.30567.55.camel@dhcp23.swansea.linux.org.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<1061320099.30567.55.camel@dhcp23.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 20:08:20 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > 	But if I was to do this in the other direction (arp -d 172.20.240.1;
> > ping -I 172.24.0.1 172.20.240.1) then I'd lose connectivity over my default
> > route because 172.20.240.1 won't accept ARP packets from IP numbers not on
> > the connected subnet. The <incomplete> ARP entry will block any further ARP
> > requests from valid IP numbers.
> 
> One thing I agree with you about is that an ARP resolution for an
> address via one path should not block a resolution for it by another
> path since to begin with the two paths may be to different routers
> one of which is down.

Sounds logical.

Can you explain to me why there should be a difference in the source ip of an
arp request originated by an ip packet from another address of the same host
compared to a forwarded packet from another host, coming in on some secondary
interface?
If I understood David correctly the first case will do an arp request with
source ip equal to source ip of the packet (originated locally).
In the second case (the box has to forward some foreign packet) for sure its
interface address will be used, correct? Or does that read: _some_ interface
address will be used?
Why this difference? The destination host cannot distinguish between these two
cases, so they can be as well handled just the same. But it seems obvious that
a foreign IP cannot be used as a source for an arp request.
And overall, looking at an arp table, what is visible is: interface, MAC and
corresponding IP. So as soon as an arp request is successfully completed the
box doesn't even remember the source ip of the former arp request, right?

Regards,
Stephan
