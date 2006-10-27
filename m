Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946143AbWJ0DhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946143AbWJ0DhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWJ0DhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:37:17 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:34054 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1946143AbWJ0DhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:37:15 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: lkml@newipnet.com (Carlos Velasco)
Subject: Re: Networking messed up, bad checksum, incorrect length
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <454166A6.1090905@newipnet.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GdIWp-0002qX-00@gondolin.me.apana.org.au>
Date: Fri, 27 Oct 2006 13:37:07 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Velasco <lkml@newipnet.com> wrote:
> 
> 03:12:22.484863 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
> (0x0800), length 12546: 192.168.128.182.59061 > 193.147.150.12.25: .
> 68786:81266(12480) ack 228 win 40 <nop,nop,timestamp 9644391 425655748>
> 
> LENGTH: 12546 !!

> But still worse, I wrote the full sniffer traces to a file for further
> analysis with Ethereal, and there I see that not only these long packets
> are above MTU, all they have bad TCP checksums.

These packets look like normal TSO packets.  Linux will send a
packet containing more data than fits in a packet to the NIC.  The
NIC will then segment the packet for us.

In order to see what really goes out, you'll need to run a packet
dump beyond the NIC.

If that is not possible, you can try disabling TSO with ethtool -K.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
