Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274881AbTHSRNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTHSRMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:12:36 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:26245 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S274820AbTHSRKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:10:13 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 19:10:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: richard@aspectgroup.co.uk, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819191010.43d83b79.skraw@ithnet.com>
In-Reply-To: <20030819095105.2cb9acc1.davem@redhat.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB5B@post.pc.aspectgroup.co.uk>
	<20030819095105.2cb9acc1.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 09:51:05 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 19 Aug 2003 17:54:26 +0100
> Richard Underwood <richard@aspectgroup.co.uk> wrote:
> 
> > 	When a HOST sends out an ARP request, it's NOT associated with a
> > single connection, it's associated with the host. Why should it pick a
> > "random" IP number to send as the source address?
> 
> It's not "random", it is using the IP address it intends
> to use as the source in packets it will output once the
> ARP completes.
> 
> In fact, if you look at the code in arp_solicit(), the source address
> is coming directly from the packet we are trying to output.

Well, then you have a problem, at least with RFC-985 as quoted in my other
email.
If your host has two interfaces on two different pyhsical nets and host A from
net A shall be contacted by a service bound to your interface on net B you will
obviously send an arp request with a source ip from wrong subnet.
I did not read the code, I take your code explanation as true, of course.
It is very likely you will not receive a valid answer in this case:

<quote RFC-985>
An ARP request is discarded if the source IP address is not in the same subnet.
</quote>

Regards,
Stephan

