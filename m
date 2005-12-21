Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLUVZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLUVZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:25:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750745AbVLUVZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:25:48 -0500
Date: Wed, 21 Dec 2005 13:25:27 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: mikukkon@iki.fi
Cc: bridge@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BRIDGE: Fix faulty check in
 br_stp_recalculate_bridge_id()
Message-ID: <20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
In-Reply-To: <20051221195527.GA24213@localhost.localdomain>
References: <20051221195527.GA24213@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 21:55:27 +0200
mikukkon@iki.fi wrote:

> I did a compile with extra gcc warnings, and found a bug in
> net/bridge/br_stp_if.c function br_stp_recalculate_bridge_id():
> compare_ether_addr() returns 0 if match, positive if not, so
> checking it for negative is wrong. 
> 
> Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>
> 
> ---
> 
>  net/bridge/br_stp_if.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index ac09b6a..08c52c2 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
>  
>  	list_for_each_entry(p, &br->port_list, list) {
>  		if (addr == br_mac_zero ||
> -		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
> +		    compare_ether_addr(p->dev->dev_addr, addr))
>  			addr = p->dev->dev_addr;
>  
>  	}

Actually that compare_ether_addr needs to be replaced by memcmp again.
Because for bridge id calc it wants the min() of all the device addresses.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
