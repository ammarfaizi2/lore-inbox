Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTHQNVh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTHQNVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:21:37 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:6664 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270237AbTHQNVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:21:33 -0400
Message-ID: <200308171516090038.0043F977@192.168.128.16>
In-Reply-To: <200308171509570955.003E4FEC@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
 <20030728213933.F81299@coredump.scriptkiddie.org>
 <200308171509570955.003E4FEC@192.168.128.16>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Sun, 17 Aug 2003 15:16:09 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "Carlos Velasco" <carlosev@newipnet.com>,
       "Lamont Granquist" <lamont@scriptkiddie.org>,
       "Bill Davidsen" <davidsen@tmr.com>
Cc: "David S. Miller" <davem@redhat.com>, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So,

According to RFC 1027:
http://www.ietf.org/rfc/rfc1027.txt

===
2.4  Sanity checks
    If the IP networks of the source and target hosts of an ARP request
    are different, an ARP subnet gateway implementation should not
    reply.  This is to prevent the ARP subnet gateway from being used
to
    reach foreign IP networks and thus possibly bypass security checks
    provided by IP gateways.
===

According to RFC 985:
http://www.ietf.org/rfc/rfc0985.txt?number=985

===
   A.3.  ARP datagram

      An ARP reply is discarded if the destination IP address does not
      match the local host address.  An ARP request is discarded if the
      source IP address is not in the same subnet.  It is desirable
that
      this test be overridden by a configuration parameter, in order to
      support the infrequent cases where more than one subnet may
      coexist on the same cable (see RFC-925 for examples).  An ARP
      reply is generated only if the destination protocol IP address is
      reachable from the local host (as determined by the routing
      algorithm) and the next hop is not via the same interface.  If
the
      local host functions as a gateway, this may result in ARP replies
      for destinations not in the same subnet.
===

Linux is doing the things _WRONG_ and on its own way without any switch
to change its behaviour.

Regards,
Carlos Velasco


