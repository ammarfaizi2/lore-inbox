Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbREXXS1>; Thu, 24 May 2001 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbREXXSR>; Thu, 24 May 2001 19:18:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9097 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262511AbREXXSK>;
	Thu, 24 May 2001 19:18:10 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15117.38563.622597.223968@pizda.ninka.net>
Date: Thu, 24 May 2001 16:17:55 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: engler@csl.Stanford.EDU (Dawson Engler), linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <E1533qI-0005jT-00@the-village.bc.nu>
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
	<E1533qI-0005jT-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > > [BUG]  seems possible --- or is some precondition guarenteed?
 > > /u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv6/udp.c:438:udpv6_recvmsg: ERROR:FREE:453:438: WARN: Use-after-free of "skb"! set by 'kfree_skb':453
 > 
 > Looks right. Left for DaveM

It's wrong, in the MSG_PEEK case skb->users is incremented by
skb_recv_datagram, so to truly get rid of it we do indeed need to
unlink it from the receive_queue then free it twice :-)

Later,
David S. Miller
davem@redhat.com
