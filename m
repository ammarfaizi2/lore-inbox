Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWHQO4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWHQO4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWHQO4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:56:44 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:19649 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932110AbWHQO4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:56:42 -0400
Date: Thu, 17 Aug 2006 10:56:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: gerrit@erg.abdn.ac.uk
cc: netdev@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port
 code
In-Reply-To: <200608171325.47349@strip-the-willow>
Message-ID: <Pine.LNX.4.64.0608171054560.19149@d.namei>
References: <200608171325.47349@strip-the-willow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, gerrit@erg.abdn.ac.uk wrote:

> -			if (inet2->num == snum &&
> -			    sk2 != sk &&
> -			    !ipv6_only_sock(sk2) &&
> -			    (!sk2->sk_bound_dev_if ||
> -			     !sk->sk_bound_dev_if ||
> -			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&


> +		sk_for_each(sk2, node, head)
> +			if (inet_sk(sk2)->num == snum                        &&
> +			    sk2 != sk                                        &&
> +			    (!sk2->sk_reuse        || !sk->sk_reuse)         &&
> +			    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if
> +			     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&


Doesn't this change the behavior for IPV6_V6ONLY sockets ?


- James
-- 
James Morris
<jmorris@namei.org>
