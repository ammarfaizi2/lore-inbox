Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbTHVVNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTHVVNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:13:07 -0400
Received: from [213.187.195.158] ([213.187.195.158]:37871 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP id S265553AbTHVVNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:13:00 -0400
To: Junio C Hamano <junkio@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: PPPoE Oops with 2.4.22-rc
References: <fa.fl74mr0.184m51s@ifi.uio.no> <fa.k5266bj.136mf8l@ifi.uio.no>
	<7v7k559zu5.fsf@assigned-by-dhcp.cox.net>
From: Marcus Sundberg <marcus@ingate.com>
Date: 22 Aug 2003 23:12:56 +0200
In-Reply-To: <7v7k559zu5.fsf@assigned-by-dhcp.cox.net>
Message-ID: <vebruhz99j.fsf@inigo.ingate.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> >>>>> "MS" == Marcus Sundberg <marcus@ingate.com> writes:
> 
> MS> this patch fixes one crash in pppoe_connect():
> 
> --- linux-2.4.21-rc2/drivers/net/pppoe.c~	Wed May 14 00:08:52 2003
> +++ linux-2.4.21-rc2/drivers/net/pppoe.c	Wed May 14 00:18:47 2003
> @@ -606,7 +606,8 @@
>  		/* Delete the old binding */
>  		delete_item(po->pppoe_pa.sid,po->pppoe_pa.remote);
>  
> -		dev_put(po->pppoe_dev);
> +		if (po->pppoe_dev)
> +			dev_put(po->pppoe_dev);
>  
>  		memset(po, 0, sizeof(struct pppox_opt));
>  		po->sk = sk;
> 
> Could you explain when/how pppoe_connect gets called with
> (pppoe_dev == NULL) but with an old binding?

I triggered it by doing 'ifconfig down' on the underlying ethernet
device. It's possible there are other ways to trigger it also. When
I made the fix I just looked at where the oops occured.

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
