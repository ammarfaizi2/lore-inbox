Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266577AbRG1Lne>; Sat, 28 Jul 2001 07:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266579AbRG1LnX>; Sat, 28 Jul 2001 07:43:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36744 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266577AbRG1LnN>;
	Sat, 28 Jul 2001 07:43:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15202.42320.389679.847561@pizda.ninka.net>
Date: Sat, 28 Jul 2001 04:43:12 -0700 (PDT)
To: Roberto Arcomano <berto@fatamorgana.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] net/ipv4/arp.c, kernel 2.4.6 - PROXY_ARP bug on shaper device
In-Reply-To: <01072812012201.01311@berto.casa.it>
In-Reply-To: <01072812012201.01311@berto.casa.it>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Roberto Arcomano writes:
 > Solution: The patch investigates about the shaper device 
 >           (it compares string with "shaper"): if yes, we 
 > 	  search the real interface attached to shaper
 > 	  (we read value of priv->dev) and we use that to
 > 	   make the classic proxy arp devices compare.
 > 
 > Problems: The patch uses routine "strncmp" which is not the
 >           best thing (I guess).

This is gross, make a device flag and have shaper set that
flag during shaper device init, then have ARP test it.

Make the name of the flag reflect what the attribute is that shaper
has (and potentially other devices could have) which makes this ARP
special case necessary.  Ie. don't name the flag NETIF_F_SHAPER :-)

Later,
David S. Miller
davem@redhat.com
