Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSKEUSb>; Tue, 5 Nov 2002 15:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265194AbSKEUSb>; Tue, 5 Nov 2002 15:18:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1430 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265192AbSKEUS3>; Tue, 5 Nov 2002 15:18:29 -0500
Subject: Re: [BK PATCH 1/4] remove NGROUPS hard limit (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: thockin@sun.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211052002.gA5K25705723@scl2.sfbay.sun.com>
References: <200211052002.gA5K25705723@scl2.sfbay.sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 20:47:13 +0000
Message-Id: <1036529233.6757.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +void
> +qsort(void *a, size_t n, size_t es, cmp_t *cmp)
> +{
> +	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;

A recursive algorithm fed user controlled input that dictates how much
it recurses, in a kernel with a stack limit. Oh and since qsort is
O(N^2) worst case and the user controls the input thats another concern.

> +	if ((r = pb - pa) > es)
> +		qsort(a, r / es, es, cmp);
> +	if ((r = pd - pc) > es) {
> +		/* Iterate rather than recurse to save stack space */


I find it hard to believe that a simple bucket sort wouldnt perform as
well in real life and with a defined time/space, or even something like
shell metzner if you want trivial with good typical behaviour.

Alternatively you could just do a merge pass when a new set of groups is
added.

