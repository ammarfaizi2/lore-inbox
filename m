Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUBLDtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 22:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUBLDtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 22:49:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266134AbUBLDtP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 22:49:15 -0500
Date: Wed, 11 Feb 2004 19:49:09 -0800
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kas@informatics.muni.cz, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch] Netlink BUG() on AMD64
Message-Id: <20040211194909.0ab130cc.davem@redhat.com>
In-Reply-To: <20040212.035825.101259632.yoshfuji@linux-ipv6.org>
References: <20040205183604.N26559@fi.muni.cz>
	<20040211181113.GA2849@fi.muni.cz>
	<20040212.034537.11291491.yoshfuji@linux-ipv6.org>
	<20040212.035825.101259632.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 03:58:25 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <20040212.034537.11291491.yoshfuji@linux-ipv6.org> (at Thu, 12 Feb 2004 03:45:37 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:
> 
> > In article <20040211181113.GA2849@fi.muni.cz> (at Wed, 11 Feb 2004 19:11:14 +0100), Jan Kasprzak <kas@informatics.muni.cz> says:
> > 
> > > --- linux-2.6.2/net/ipv4/fib_rules.c.orig	2004-02-11 18:55:58.000000000 +0100
> > > +++ linux-2.6.2/net/ipv4/fib_rules.c	2004-02-11 19:03:08.319215408 +0100
> > > @@ -438,7 +438,7 @@
 ...
> > > -	skb_put(skb, b - skb->tail);
> > > +	skb_trim(skb, b - skb->data);
> --- 1.6/net/decnet/dn_rules.c	Fri May  9 01:46:11 2003
> +++ edited/net/decnet/dn_rules.c	Thu Feb 12 03:52:42 2004
> @@ -381,7 +381,7 @@
 ...
> -	skb_put(skb, b - skb->tail);
> +	skb_trim(skb, b - skb->data);

Both fixes applied, thanks guys.

I was tempted to make skb_put()'s second argument signed, but I'm in no mood
to audit the entire tree for that :-)
