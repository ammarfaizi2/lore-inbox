Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSF0SOo>; Thu, 27 Jun 2002 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSF0SOn>; Thu, 27 Jun 2002 14:14:43 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:37577 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S316900AbSF0SOn>; Thu, 27 Jun 2002 14:14:43 -0400
Date: Thu, 27 Jun 2002 12:16:19 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: zero-copy networking & a performance drop
Message-ID: <Pine.LNX.4.44.0206271146280.9500-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please Cc me in replies. I'm an archive lurker.

Howdy-

I've been working to isolate (and fix ;) a receive-side performance 
bottleneck in the IP implementation used over the Quadrics Interconnect. 
For those "not in the know," quadrics is a high speed (3.2 gbit) low 
latency propreitary interconnect, used primarily in supercomputing 
applications. It provides a shared memory architecture, and most of the 
communication is handled by the NICs.

Previous tests have show that we can transmit IP packets easily at around
1.4 Gbit, but we can only receive at about 0.9 Gbit. We suspect there is a 
memory copy somewhere either in the quadrics IP driver (covered by an NDA, 
sorry), or in the IP stack after netif_rx() is called. I've looked at the 
driver, and, upon a (good) cursory inspection, it looks good.

Now, here is my direct question: has a zero-copy TCP stack been introduced
after 2.4.3 (which we're running)? I believe the answer is yes, but I've
not been able to find direct confirmation. If the answer is yes, does
anything special need to be done (in terms of allocating/working with
skbs, or passing the packets up to higher levels) in order to use the
zero-copy implementation.

>From what I've read/determined, fixing this performance drop might be as
simple as upgrading the kernel and recomiling our IP module. It is
unfortunately the case that I can't play around with our test cluster-
it's become a production cluster, so even upgrading kernel versions will
be a hard sell. I need to be certain that what I want to do is the Right
Thing(tm) before I propose it.

For the curious (and possibly advice-offering): neither fragmentation nor
checksums should be an issue with this hardware. The IP data is sent via
the hardware's link level protocol, which performs fragmentation and error
checking/correcting transparent to the OS (which, btw, is sometimes a real
pain).

Cheers,
--Gus

