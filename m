Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKALUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKALUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKALUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:20:20 -0500
Received: from twister.ispgateway.de ([80.67.18.17]:6036 "EHLO
	twister.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750747AbVKALUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:20:20 -0500
Date: Tue, 1 Nov 2005 12:20:08 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: David R <david@unsolicited.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14 and old versions of traceroute
Message-ID: <20051101112008.GR22057@steffen-moser.de>
Mail-Followup-To: David R <david@unsolicited.net>,
	linux-kernel@vger.kernel.org
References: <fa.e5044g2.p4421e@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.e5044g2.p4421e@ifi.uio.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

* On Mon, Oct 31, 2005 at 07:30 PM (+0000), David R wrote:

> I've noticed that old versions of traceroute no longer work properly
> with the latest kernel. 2.6.13.4 is OK. I've done a bit of strace and am
> posting the differences here. These are from a 64 bit kernel using
> traceroute 0.6.2 as shipped with most versions of SuSE. 

I am experiencing exactly the same problem with traceroute-0.6.2 
running on SuSE 10.0 together with kernel 2.6.14. The whole thing
happens on a single core dual Opteron machine. I've tested this
kernel version on that machine only, yet.

I've also tried the latest traceroute version (1.0.2) from

  ftp://ftp.lst.de/pub/people/okir/traceroute/

and experienced the same behaviour.

Olaf Kirch has just sent me a patch against 2.6.14. It has also 
been discussed in NETDEV. 

This fixed it for me:

--- a/net/core/datagram.c       2005-11-01 11:38:31.000000000 +0100
+++ b/net/core/datagram.c       2005-11-01 11:38:45.000000000 +0100
@@ -213,6 +213,10 @@
 {
        int i, err, fraglen, end = 0;
        struct sk_buff *next = skb_shinfo(skb)->frag_list;
+
+       if (!len)
+               return 0;
+
 next_skb:
        fraglen = skb_headlen(skb);
        i = -1;

Bye,
Steffen
