Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWHWOW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWHWOW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWHWOW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:22:27 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:20867 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964897AbWHWOW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:22:26 -0400
Date: Wed, 23 Aug 2006 10:22:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: gerrit@erg.abdn.ac.uk
cc: davem@davemloft.net, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] net/ipv4: UDP-Lite extensions
In-Reply-To: <200608231150.42039@strip-the-willow>
Message-ID: <Pine.LNX.4.64.0608231019010.3198@d.namei>
References: <200608231150.42039@strip-the-willow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, gerrit@erg.abdn.ac.uk wrote:

> +void __init udplite4_register(void)
> +{
> +	if (proto_register(&udplite_prot, 1))
> +		goto out_register_err;
> +
> +	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
> +		goto out_unregister_proto;
> +
> +	inet_register_protosw(&udplite4_protosw);
> +
> +	return;
> +
> +out_unregister_proto:
> +	proto_unregister(&udplite_prot);
> +out_register_err:
> +	printk(KERN_ERR "udplite4_register: Cannot add UDP-Lite protocol\n");
> +}

Other protocols & network components call panic() if they fail during boot 
initialization.  Not sure if this is a great thing, but it raises the 
issue of whether udp-lite should remain consistent here.



- James
-- 
James Morris
<jmorris@namei.org>
