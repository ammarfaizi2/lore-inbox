Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRC2NJ7>; Thu, 29 Mar 2001 08:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRC2NJt>; Thu, 29 Mar 2001 08:09:49 -0500
Received: from pheniscidae.satimex.tvnet.hu ([195.38.97.245]:64781 "EHLO
	pheniscidae.satimex.tvnet.hu") by vger.kernel.org with ESMTP
	id <S132686AbRC2NJl>; Thu, 29 Mar 2001 08:09:41 -0500
Date: Thu, 29 Mar 2001 15:08:51 +0200
From: SZALAY Attila <sasa@pheniscidae.satimex.tvnet.hu>
To: linux-kernel@vger.kernel.org
Subject: udp <-> tcp connect
Message-ID: <20010329150851.D11306@pheniscidae.satimex.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I want to bind to non-local IP and send/receive UDP packets.

But when I try to connect to remote end I get an error (although bind itself
is successful).

I examined the udp_connect and tcp_v4_connect and I found an
interesting difference between them.

In udp_connect:
err = ip_route_connect(&rt, usin->sin_addr.s_addr, sk->saddr,
                       sk->ip_tos|sk->localroute, sk->bound_dev_if);
                       ^^^^^^^^^^^
                         (1)

but in tcp_v4_connect:
        tmp = ip_route_connect(&rt, nexthop, sk->saddr,
              RT_TOS(sk->ip_tos)|RTO_CONN|sk->localroute, sk->bound_dev_if);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        (2)

If I see it right, this difference is used only in the ip_route_output_slow
function when it checks whether I can connect or not.

The question is whether there will be any problem if I rewrite (1) to (2)? I
tried doing this and seems to work fine.

Is there any reason not to do this?

Any help is appreciated.

-- 
PGP ID 0x8D143771, /C5 95 43 F8 6F 19 E8 29  53 5E 96 61 05 63 42 D0
GPG ID   ABA0E8B2, 45CF B559 8281 8091 8469  CACD DB71 AEFC ABA0 E8B2

              The best things in life are free, but the
                expensive ones are still worth a look.
