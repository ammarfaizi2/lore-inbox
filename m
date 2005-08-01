Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVHAFPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVHAFPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVHAFPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:15:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23008
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261448AbVHAFM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:12:58 -0400
Date: Sun, 31 Jul 2005 22:12:46 -0700 (PDT)
Message-Id: <20050731.221246.68159198.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
CC: laforge@gnumonks.org
Subject: Re: git-net-fixup.patch added to -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508010504.j7154m5B022440@shell0.pdx.osdl.net>
References: <200508010504.j7154m5B022440@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Sun, 31 Jul 2005 22:03:47 -0700

> From: Andrew Morton <akpm@osdl.org>
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
 ...
>  /* decrement reference count on a conntrack */
> -extern void ip_conntrack_put(struct ip_conntrack *ct);
> +static inline void
> +ip_conntrack_put(struct ip_conntrack *ct)
> +{
> +	IP_NF_ASSERT(ct);
> +	nf_conntrack_put(&ct->ct_general);
> +}

You can instead just kill the EXPORT_SYMBOL_GPL() in
ip_conntrack_standalone.c as that's the only reference outside of
ip_conntrack_core.c

Harald?

