Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTBRTrG>; Tue, 18 Feb 2003 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267955AbTBRTrG>; Tue, 18 Feb 2003 14:47:06 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:268 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S267954AbTBRTrE>;
	Tue, 18 Feb 2003 14:47:04 -0500
Date: Tue, 18 Feb 2003 21:57:01 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@l
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <ja@ssi.bg>
Subject: Re: sendmsg and IP_PKTINFO
Message-ID: <Pine.LNX.4.44.0302182055450.3668-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Neil Brown wrote:

> Note that the in_pktinfo is described as "some information about the
> incoming packet".  In particular ipi_ifindex is "the unique index of
> the interface the packets was received on".
>
> i.e. it is more about the incoming than the outgoing packet.

	Yes, because when set as socket option you can receive
pktinfo with recvmsg. But IP_PKTINFO can be used also with sendmsg.
Just forget about interfaces, i.e. use something like this in cmsg:

.ipi = {
	.ipi_ifindex = 0,
	.ipi_spec_dst = local_ip,
},

	Such code is needed when your UDP socket is not
connected (preferred) nor bound (with bind). In such case
it is essential to provide sendmsg with the local IP address
used for proper routing. Playing with interfaces should be
avoided if possible. If is a common error UDP users not to
provide the routing with local IP address.

Regards

--
Julian Anastasov <ja@ssi.bg>

