Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHYXpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHYXpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHYXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:45:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266242AbUHYXof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:44:35 -0400
Date: Wed, 25 Aug 2004 16:44:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: Linux 2.6.9-rc1
Message-Id: <20040825164401.12259308.davem@redhat.com>
In-Reply-To: <20040825203206.GS5824@sunbeam.de.gnumonks.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	<412CDFEE.1010505@triplehelix.org>
	<20040825203206.GS5824@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 22:32:06 +0200
Harald Welte <laforge@netfilter.org> wrote:

Harald, a question about this fix.

> +__ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
> +{
> +	return LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
> +}
> +
> +struct ip_nat_helper *
>  ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
>  {
>  	struct ip_nat_helper *h;
>  
>  	READ_LOCK(&ip_nat_lock);
> -	h = LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
> +	h = __ip_nat_find_helper(tuple);
>  	READ_UNLOCK(&ip_nat_lock);
>  

So we're converting over to using __ip_nat_find_helper().

> +EXPORT_SYMBOL(ip_nat_find_helper);

And adding an export of ip_nat_find_helper (ie. without the two underscore
prefix).  Why?

If we need to export one, then we need to export both.
