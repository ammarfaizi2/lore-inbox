Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319061AbSHMSRS>; Tue, 13 Aug 2002 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319095AbSHMSRS>; Tue, 13 Aug 2002 14:17:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23310 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319061AbSHMSRR>; Tue, 13 Aug 2002 14:17:17 -0400
Date: Tue, 13 Aug 2002 11:23:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208132004190.5990-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131121310.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
>
> think about it - we have the *very same* problem in kernel-space, and we
> had it for years. People wanted to get rid of parent notification in
> helper processes for ages.

So add the capability to mark the child for proper exit semantics.

That's what I said: if you wan tto do this, you need to mark it at 
_create_ time. Exactly so that the proper exit semantics can be done 100% 
reliably, instead of just "sometimes". THAT is why _any_ interface that 
depends on exit_xxxx() must die - because it is inherently broken for 
accidental deaths, and does not leave the parent any way to recover 
sanely.

		Linus

