Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWEPPyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWEPPyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWEPPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:54:07 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:41420 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751279AbWEPPyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:54:06 -0400
Date: Tue, 16 May 2006 11:54:04 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
In-Reply-To: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0605161149540.16379@d.namei>
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Alexey Dobriyan wrote:

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Hmm, I'm certain this was tested (perhaps on a BE machine, though). In any 
case skb->protocol should definitely be network byte order.

Acked-by: James Morris <jmorris@namei.org>



> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3231,7 +3231,7 @@ static int selinux_socket_sock_rcv_skb(s
>  		goto out;
>  
>  	/* Handle mapped IPv4 packets arriving via IPv6 sockets */
> -	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))
> +	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
>  		family = PF_INET;
>  
>   	read_lock_bh(&sk->sk_callback_lock);
> 

-- 
James Morris
<jmorris@namei.org>
