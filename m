Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLQHl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLQHl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVLQHl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:41:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932105AbVLQHl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:41:27 -0500
Date: Fri, 16 Dec 2005 23:40:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: jbarnes@virtuousgeek.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <20051216.231056.124758189.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512162336210.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
 <20051216.145306.132052494.davem@davemloft.net> <200512161641.49571.jbarnes@virtuousgeek.org>
 <20051216.231056.124758189.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, David S. Miller wrote:
> 
> If there is some test guarding the CAS, yes.
> 
> But if there isn't, for things like atomic increment and
> decrement, where the CAS is unconditional, you'll always
> eat the two bus transactions without the prefetch for write.

Side note: there may be hardware cache protocol _scheduling_ reasons why 
some particular hw platform might prefer to go through the "Shared" state 
in their cache protocol.

For example, you might have hardware that otherwise ends up being very 
unfair, where the two-stage lock aquire might actually allow another node 
to come in at all. Fairness and balance often comes at a cost, both in hw 
and in sw.

Arguably such hardware sounds pretty broken, but the point is that these 
things can certainly depend on the platform around the CPU as well as on 
what the CPU itself does.

I'm not saying that that is necessarily what Jesse was arguing about, but 
lock contention behaviour can be "interesting".

			Linus
