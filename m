Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbUKQBgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUKQBgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUKQBgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:36:36 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:2568 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262153AbUKQBge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:36:34 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dubu0874@uidaho.edu (Thomas DuBuisson)
Subject: Re: XFRM / DF Flag / Fragmentation Needed
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <Pine.GSO.4.56.0411161447340.7679@hurricane.csrv.uidaho.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CUEk6-00036P-00@gondolin.me.apana.org.au>
Date: Wed, 17 Nov 2004 12:36:18 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas DuBuisson <dubu0874@uidaho.edu> wrote:
>
> After A establishes an SSH connection with C and tries to transfer the
> patches the size of a packet from A destined for C is quickly reaches 1500
> while the MTU
> to A is ~1400.  At this point A sends an ICMP 'Fragmentation Needed'
> packet to its self (see xfrm_output.c xfrm4_tunnel_check_size(...)).  It
> seems this packet is never acted on - it just disappears into the
> loopback interface.  The proper mtu trial/error process never takes
> place.

There is a known problem in xfrm4_tunnel_check_size if your underlying
path MTU is a multiple of 8.  So if your path MTU is 1480, you'll need
to lower it to 1476 before it will work.

You can query the path MTU using "ip r g <remote-gateway>".  If it
is a multiple of 8, you can change it by doing

ip r a <remote-gateway> ... mtu <current-mtu - 4>
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
