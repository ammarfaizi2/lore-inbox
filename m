Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272453AbTHSR7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTHSRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:07:51 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:27780 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272671AbTHSQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:52:22 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 18:52:19 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819185219.116fd259.skraw@ithnet.com>
In-Reply-To: <20030819085717.56046afd.davem@redhat.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 08:57:17 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 19 Aug 2003 17:07:51 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > Hm, what rule is broken by the remote host, then?
> 
> It means that systems (like Linux) that make IP addresses owned by the
> host instead of specific interfaces cannot correctly interoperate with
> such remote systems.
> 
> It is also the case that a host cannot possibly be aware of all
> subnets present on a given LAN, therefore is should be liberal in it's
> replies to ARP requests.
> 
> Finally, it violates the most basic rule of IP networking:
> 
> "Be liberal in what you accept, and conservative in what you send"
> -Jon Postel

If I understood what Richard said in this thread Jon just shot you down. The
conservative way to _request_ arp would definitely be to request it from the
"correct" subnet, because as a sender you ought to give credit to knowing that
"bad" boxes out there won't answer if you do otherwise. There can be no doubt
what "conservative" means here.
Additionally, the remote box is not really bad behaving:

<quote RFC-985>
   A.3.  ARP datagram

      An ARP reply is discarded if the destination IP address does not
      match the local host address.  An ARP request is discarded if the
      source IP address is not in the same subnet.  It is desirable that
      this test be overridden by a configuration parameter, in order to
      support the infrequent cases where more than one subnet may
      coexist on the same cable (see RFC-925 for examples).

</quote>

This means the remote box is completely ok if not answering to a request with
source ip from another subnet.
So from what I read here requesting arp should really only happen with a source
ip from the same subnet.

Regards,
Stephan
