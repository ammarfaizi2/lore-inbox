Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264292AbRFHR6T>; Fri, 8 Jun 2001 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264294AbRFHR57>; Fri, 8 Jun 2001 13:57:59 -0400
Received: from xorn.math.fu-berlin.de ([160.45.45.167]:3968 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S264292AbRFHR5u>;
	Fri, 8 Jun 2001 13:57:50 -0400
Date: Fri, 8 Jun 2001 19:57:19 +0200
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel headers violate RFC2553
Message-ID: <20010608195719.A4862@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

glibc works around this, but the diet libc uses the kernel headers and
thus exports the wrong API to user land.

Here is what RFC2553 mandates:

   struct ipv6_mreq {
       struct in6_addr ipv6mr_multiaddr; /* IPv6 multicast addr */
       unsigned int    ipv6mr_interface; /* interface index */
   };

...and here is what include/linux/in6.h declares:

  struct ipv6_mreq {
	  /* IPv6 multicast address of group */
	  struct in6_addr ipv6mr_multiaddr;

	  /* local IPv6 address of interface */
	  int             ipv6mr_ifindex;
  };

Note the ipv6mr_ifindex instead of the correct ipv6mr_interface.

This wrong name is only used twice in net/ipv6/ipv6_sockglue.c, so it should be
trivial to fix.

Felix
