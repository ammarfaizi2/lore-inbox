Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSGXCTu>; Tue, 23 Jul 2002 22:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSGXCTu>; Tue, 23 Jul 2002 22:19:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316567AbSGXCTu>; Tue, 23 Jul 2002 22:19:50 -0400
Date: Tue, 23 Jul 2002 19:24:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: trond.myklebust@fys.uio.no, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 fix potential spinlocking race.
In-Reply-To: <20020723.190903.50511601.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207231922020.6943-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jul 2002, David S. Miller wrote:
>
>    In case of socket transmission errors etc. kfree_skb(), and hence
>    xprt_write_space() can potentially get called outside of a bh-safe
>    context.
>
> kfree_skb must occur within a BH context or better context.

I think you're talking past each other.

Trond noticed that kfree_skb() can be called from a _non_ bh context, ie
process context. So it needs to protect itself against other bh's on this
CPU (which it wouldn't need to do if it was only called from a bh
context).

So it's exactly your "better context" that is at stake here.

		Linus

