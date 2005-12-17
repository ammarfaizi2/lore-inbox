Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVLQXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVLQXRy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVLQXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 18:17:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33976
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965002AbVLQXRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 18:17:53 -0500
Date: Sat, 17 Dec 2005 15:05:35 -0800 (PST)
Message-Id: <20051217.150535.122244453.davem@davemloft.net>
To: rth@twiddle.net
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051217223824.GA16736@twiddle.net>
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
	<20051216.145306.132052494.davem@davemloft.net>
	<20051217223824.GA16736@twiddle.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Henderson <rth@twiddle.net>
Date: Sat, 17 Dec 2005 14:38:24 -0800

> You might consider just beginning your loops like
> 
> 	mov	zero, old
> 	cas	[mem], zero, old
> 
> to do the initial read, since old will now contain the 
> contents of the memory, and we havn't changed the memory.

CAS is 32 cycles minimum on sparc64 even on a cache hit, so I think
the prefetch+load will be faster :-)  But it deserves checking out,
that's for sure.

Either way, that is a clever use of CAS :)
