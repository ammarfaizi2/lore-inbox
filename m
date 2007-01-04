Return-Path: <linux-kernel-owner+w=401wt.eu-S932214AbXADAui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXADAui (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbXADAui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:50:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36486 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbXADAuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:50:37 -0500
Date: Wed, 3 Jan 2007 16:50:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Simplify some code to use the container_of() macro.
Message-Id: <20070103165034.13935d8a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
References: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006 15:55:22 -0500 (EST)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

> --- a/net/ipv4/netfilter/nf_nat_core.c
> +++ b/net/ipv4/netfilter/nf_nat_core.c
> @@ -168,7 +168,7 @@ find_appropriate_src(const struct nf_conntrack_tuple *tuple,
> 
>  	read_lock_bh(&nf_nat_lock);
>  	list_for_each_entry(nat, &bysource[h], info.bysource) {
> -		ct = (struct nf_conn *)((char *)nat - offsetof(struct nf_conn, data));
> +		ct = container_of(nat, struct nf_conn, data);

This one isn't right.  Please always carefully compile-test these things.
