Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319316AbSHVKnc>; Thu, 22 Aug 2002 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319317AbSHVKnc>; Thu, 22 Aug 2002 06:43:32 -0400
Received: from samar.sasken.com ([164.164.56.2]:20971 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S319316AbSHVKnb>;
	Thu, 22 Aug 2002 06:43:31 -0400
Date: Thu, 22 Aug 2002 16:19:36 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: IPv6 interface problem 
Message-ID: <Pine.LNX.4.33.0208221612180.904-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am trying to setup a simple IPv6 network with two machines directly
connected. I am using linux-2.4.19-stable on these machines. Then I tried
to check the connectivity using ping6.

When I do normal ping6, it worked in both the directions. When I tried to
increase the packet size to something greater than 1500, on one machine I
get the replies properly for the all the packets sent. On the other
machine, I get the following error:

ping: recvmsg: No route to host

When ping6 works perfectly fine for small packets, why does it fail for
large packets. And why does it fail in only one direction?

The interface types I have been using are EtherExpressPro/100 (This is on
the machine on which ping6 for large packets is failing) and DECchip Tulip
(dc21x4x).

I traced a few steps and found out that -

* the value returned by csum_partial() function in
  skb_copy_and_csum_datagram_iovec() (net/core/datagram.c) is such that
  the sum of the two 16 bit words in that is coming to 0x10080 where as
  for correct packets, it is coming to 0xffff.
* Because of this csum_fold() is returning non-zero value and
  skb_copy_and_csum_datagram_iovec () is returning -EINVAL and
  rawv6_recvmsg() is returning -EHOSTUNREACH.

Does this 0x10080 have some significance or is it just a junk error? I
don't have any understanding of the code for physical and datalink layers.
Could someone help?

regards
Madhavi.


