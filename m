Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSFNDfr>; Thu, 13 Jun 2002 23:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSFNDfq>; Thu, 13 Jun 2002 23:35:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30729 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317876AbSFNDfq>;
	Thu, 13 Jun 2002 23:35:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206140335.g5E3ZhF370974@saturn.cs.uml.edu>
Subject: Re: Bandwidth 'depredation' revisited
To: afu@fugmann.dhs.org (Anders Fugmann)
Date: Thu, 13 Jun 2002 23:35:43 -0400 (EDT)
Cc: raul@pleyades.net (DervishD), linux-kernel@vger.kernel.org (Linux-kernel)
In-Reply-To: <3D060FF6.5000409@fugmann.dhs.org> from "Anders Fugmann" at Jun 11, 2002 04:57:58 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann writes:

> The best solution would be to install some sort of traffic shaping on 
> the remove side (you ISP), but that is often(/always) not a possible 
> solution.
> 
> The second best solution is to simple drop packets comming in too 
> quickly from the interface. By this, the sending machine will slow down 
> transmission. The idea is to keep the queues at you ISP empty.
>
> To do this you can use ingress scheduler.
>
> Something like:
> tc qdisc add dev eth0 handle ffff: ingress
> tc filter add dev etc0 parent ffff: protocol ip prio 50 u32 \
>          match ip src 0.0.0.0/0 police \
>          rate 232kbit burst 10k drop flowid :1

Rather than dropping packets, causing retransmits that
eat into your bandwidth, you could try the new ECN bits.
If you're downloading from a Linux box, it ought to slow
down a bit when you claim to be suffering congestion.

ftp://ftp.isi.edu/in-notes/rfc3168.txt
http://www.faqs.org/rfcs/rfc3168.html
http://www.aciri.org/floyd/ecn.html
http://gtf.org/garzik/ecn/
http://www.tux.org/lkml/#s14-2

