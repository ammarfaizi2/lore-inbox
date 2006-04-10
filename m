Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWDJFqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDJFqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDJFqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:46:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37295
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750871AbWDJFqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:46:18 -0400
Date: Sun, 09 Apr 2006 22:45:59 -0700 (PDT)
Message-Id: <20060409.224559.124326025.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] deinline a few large functions in vlan code
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604100828.20994.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
	<20060407.132511.09521964.davem@davemloft.net>
	<200604100828.20994.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Mon, 10 Apr 2006 08:28:20 +0300

> IOW: shouldn't calls to these functions sit in
> #if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> block? For example, typhoon.c:
> 
>                 spin_lock(&tp->state_lock);
> +#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
>                 if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
>                         vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
>                                                  ntohl(rx->vlanTag) & 0xffff);
>                 else
> +#endif
>                         netif_receive_skb(new_skb);
>                 spin_unlock(&tp->state_lock);
> 
> Same for s2io.c, chelsio/sge.c, etc...

Very likely yes.  tp->vlgrp will never be non-NULL in such situations
so it's not a correctness issue, but rather an optimization :-)
