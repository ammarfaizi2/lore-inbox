Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUIXLR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUIXLR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUIXLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:17:27 -0400
Received: from barclay.balt.net ([195.14.162.78]:41695 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S268683AbUIXLRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:17:16 -0400
Date: Fri, 24 Sep 2004 14:15:53 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Patrick McHardy <kaber@trash.net>
Cc: Mathieu B?rard <Mathieu.Berard@crans.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops with racoon and linux-2.6.9-rc2-mm1
Message-ID: <20040924111553.GA17057@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <41520074.3080706@crans.org> <41524CEE.2020508@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41524CEE.2020508@trash.net>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

just verified 2.6.9-rc2-bk8 + patch below no more oopsing. IPsec is
working fine. Please apply.

> # 
> diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> --- a/net/xfrm/xfrm_state.c	2004-09-23 06:07:23 +02:00
> +++ b/net/xfrm/xfrm_state.c	2004-09-23 06:07:23 +02:00
> @@ -592,7 +592,6 @@
>  		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
>  			if (x->km.seq == seq) {
>  				xfrm_state_hold(x);
> -				spin_unlock_bh(&xfrm_state_lock);
>  				return x;
>  			}
>  		}

