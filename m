Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137085AbREKJmM>; Fri, 11 May 2001 05:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137087AbREKJmC>; Fri, 11 May 2001 05:42:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57238 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137085AbREKJlu>;
	Fri, 11 May 2001 05:41:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.46041.778542.342635@pizda.ninka.net>
Date: Fri, 11 May 2001 02:41:45 -0700 (PDT)
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4 linearize UDP RPC requests using GFP_KERNEL...
In-Reply-To: <15099.43446.132871.699151@charged.uio.no>
In-Reply-To: <15099.43446.132871.699151@charged.uio.no>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trond Myklebust writes:
 >   IMHO allocating the buffer using GFP_ATOMIC is a mistake. As I said
 > we're in a thread context, so sleeping in GFP_KERNEL is safe. In
 > addition, the cost of dropping the request if we can't allocate the
 > buffer is heavy in that the client has to wait for a timeout, and then
 > retry.
 > 
 > I'd therefore like to propose the following change.
 ...
 > --- linux-2.4.4/net/sunrpc/svcsock.c.orig	Fri Apr 27 23:15:01 2001
 > +++ linux-2.4.4/net/sunrpc/svcsock.c	Fri May 11 10:08:36 2001
 ...
 > -		if (skb_linearize(skb, GFP_ATOMIC) != 0) {
 > +		if (skb_linearize(skb, GFP_KERNEL) != 0) {

No arguments here.

Later,
David S. Miller
davem@redhat.com
