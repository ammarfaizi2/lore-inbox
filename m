Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbRGZCFG>; Wed, 25 Jul 2001 22:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRGZCE4>; Wed, 25 Jul 2001 22:04:56 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:15572 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267524AbRGZCEw>; Wed, 25 Jul 2001 22:04:52 -0400
Importance: Normal
Subject: Subtleties of the 0.0.0.0 netmask (inet_ifa_match)
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFDE143062.D41C03AC-ON85256A95.000B439D@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Wed, 25 Jul 2001 22:04:31 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/25/2001 10:04:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

This is a load balancing specific question. We configure load balancer IP addresses (which are regular
addresses like 10.1.1.1) on the loopback interface with 0.0.0.0 netmask. The purpose is to receive
clients requests with those address, and for routing to ignore them when sending the replies.

  o Does addresses with 0.0.0.0 netmask have scope RT_SCOPE_NOWHERE?
  o and does it imply that routing would never route to them?

We also configure load balancer IP address with 255.255.255.255 netmask which should not match any
route entry except the host entry itself within the box.

  o Are there subtle differences between 0.0.0.0 and 255.255.255.255 netmasks?

The inet_ifa_match function seems to be wrong with 0.0.0.0 netmask.  Who uses it?

extern __inline__ int inet_ifa_match(u32 addr, struct in_ifaddr *ifa)
{
        return !((addr^ifa->ifa_address)&ifa->ifa_mask);
}

The 0.0.0.0 netmask matches everything! For example:
        addr=9.9.9.9  ifa_address=10.1.1.1  ifa_mask=0.0.0.0          inet_ifa_match=1
        addr=9.9.9.9  ifa_address=10.1.1.1  ifa_mask=255.255.255.255  inet_ifa_match=0

Will there be any routing problems if we use the 0.0.0.0 netmask?

Thanks for any info.
Allen Lau


