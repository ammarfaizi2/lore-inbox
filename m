Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbTCLBSF>; Tue, 11 Mar 2003 20:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbTCLBSF>; Tue, 11 Mar 2003 20:18:05 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:18664
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261694AbTCLBSE>; Tue, 11 Mar 2003 20:18:04 -0500
Date: Tue, 11 Mar 2003 20:25:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-net@vger.kernel.org>
Subject: Re: [PATCH] (5/8) Eliminate brlock from netfilter
In-Reply-To: <1047428094.15872.105.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.50.0303112016580.6957-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
 <1047428094.15872.105.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Stephen Hemminger wrote:

>  void nf_unregister_hook(struct nf_hook_ops *reg)
>  {
> -	br_write_lock_bh(BR_NETPROTO_LOCK);
> +	spin_lock_bh(&nf_lock);
>  	list_del(&reg->list);
> -	br_write_unlock_bh(BR_NETPROTO_LOCK);
> +	spin_unlock_bh(&nf_lock);
> +
> +	synchronize_kernel();
>  }

Won't that have to be list_del_rcu there?

	Zwane
-- 
function.linuxpower.ca
