Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRK1L1t>; Wed, 28 Nov 2001 06:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282079AbRK1L1i>; Wed, 28 Nov 2001 06:27:38 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:33553 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S281880AbRK1L1Y>;
	Wed, 28 Nov 2001 06:27:24 -0500
Date: Wed, 28 Nov 2001 12:26:51 +0100
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200111281126.MAA13610@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: ip_queue_xmit2 inconsistency regarding skb->sk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I posted a kernel oops related to netfilter/REDIRECT. It seems like 
ip_queue_xmit2 crashes on (skb->sk == NULL) in calling

    ip_dont_fragment(sk, &rt->u.dst) 

which can't handle the (sk == NULL) situation. Of course there is the matter of
why (sk == NULL) in the first place. Haven't figured that out yet, nf_hook_slow
may cause do this somehow.

The other matter however is wether or not ip_queue_xmit2 should be able to 
handle the (skb->sk == NULL) situation. The code is not consistent on that
subject.

It seems like the if statement:

    if (skb_headroom(skb) < dev->hard_header_len && dev->hard_header) {

handles the (sk == NULL) situation, given the line "if (sk)". Other parts of
ip_queue_xmit2 seem to assume (sk != NULL), like the ip_dont_fragment call
or lines like "skb->priority = sk->priority".

OK, this is not the answer on the why of the kernel oops. I hope however that
this question is related and helps in finding the answer

Rolf
