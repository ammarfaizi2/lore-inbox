Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272639AbTHSSB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272619AbTHSSAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:00:22 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:8433 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S272335AbTHSR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:56:21 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB5C@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'David S. Miller'" <davem@redhat.com>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 18:56:18 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > 	When a HOST sends out an ARP request, it's NOT associated with a
> > single connection, it's associated with the host. Why 
> should it pick a
> > "random" IP number to send as the source address?
> 
> It's not "random", it is using the IP address it intends
> to use as the source in packets it will output once the
> ARP completes.
> 
> In fact, if you look at the code in arp_solicit(), the source address
> is coming directly from the packet we are trying to output.
> 
	Which nicely sums up the bug, really.

1) The ARP response (or lack thereof) will be used for more than that
connection, using a single packet's source IP address is meaningless and
just a little aribtrary.

2) Depending on which ARP request or reply gets seen first, packets may get
routed over different interfaces or not sent out at all.

3) The code is over-complex. There must already be perfectly good code to
pick up the interface's IP address as this would HAVE to be the case when a
packet has been routed from another host.

	This sort of randomness is not acceptable in a reliable network.

		Richard
