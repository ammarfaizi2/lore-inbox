Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752343AbWKCMV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbWKCMV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWKCMV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:21:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11217 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752343AbWKCMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:21:56 -0500
Subject: Re: __alloc_pages() failures reported due to fragmentation
From: Arjan van de Ven <arjan@infradead.org>
To: Larry Woodman <lwoodman@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454B3282.3010308@redhat.com>
References: <454B3282.3010308@redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 03 Nov 2006 13:21:54 +0100
Message-Id: <1162556514.14530.163.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.6.18.noarch/net/core/sock.c.orig
> +++ linux-2.6.18.noarch/net/core/sock.c
> @@ -1154,7 +1154,7 @@ static struct sk_buff *sock_alloc_send_p
>  			goto failure;
>  
>  		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
> -			skb = alloc_skb(header_len, sk->sk_allocation);
> +			skb = alloc_skb(header_len, gfp_mask);
>  			if (skb) {
>  				int npages;
>  				int i;

Hi,

this is not actually right though... sk_allocation is very possible to
have a restricting mask compared to the one passed in (say "no highmem"
or even GFP_DMA) and you now discard this... probably better would be to
calculate a set of "transient" flags that you then or into the
sk_allocation mask at this time...

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

