Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWAKSKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWAKSKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAKSKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:10:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:14767 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932413AbWAKSKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:10:36 -0500
Subject: Re: [IPV6]: Set skb->priority in ip6_output.c
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Patrick McHardy <kaber@trash.net>, davem@davemloft.net
In-Reply-To: <200601100009.k0A09dlx021099@hera.kernel.org>
References: <200601100009.k0A09dlx021099@hera.kernel.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:10:25 +0000
Message-Id: <1137003025.4196.114.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 16:09 -0800, Linux Kernel Mailing List wrote:
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -226,6 +226,8 @@ int ip6_xmit(struct sock *sk, struct sk_
>         ipv6_addr_copy(&hdr->saddr, &fl->fl6_src);
>         ipv6_addr_copy(&hdr->daddr, first_hop);
>  
> +       skb->priority = sk->sk_priority;
> +

This function is called with NULL sk from tcp_v6_send_ack() and
tcp_v6_send_reset() ... and now oopses.

-- 
dwmw2

