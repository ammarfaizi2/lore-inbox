Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTIVIYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbTIVIYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 04:24:23 -0400
Received: from [80.80.104.119] ([80.80.104.119]:34432 "EHLO ns.ugavia.ru")
	by vger.kernel.org with ESMTP id S263053AbTIVIYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 04:24:22 -0400
Message-ID: <3F6EAFF2.9080303@isfera.ru>
Date: Mon, 22 Sep 2003 12:16:50 +0400
From: Diadon <diadon@isfera.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: David Miller <davem@redhat.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
References: <20030921144013.GA22223@sunbeam.de.gnumonks.org>
In-Reply-To: <20030921144013.GA22223@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That patch is not work, after patching the kernel problem is not 
disappeared!

Patch by Patrick is working fine and fix this problem


Harald Welte wrote:

>Hi Dave!
>
>Some people use REJECT in the OUTPUT chain (rejecting locally generated
>packets).  This didn't work anymore starting with some fixes we did in 2.4.22. 
>A dst_entry for a local source doesn't contain pmtu information - and
>thus the newly-created packet would instantly be dropped again.
>
>I'll send you a 2.6.x merge for this later.
>
>Please apply the following fix, thanks
>
>  
>
>------------------------------------------------------------------------
>
>diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c' --exclude '*~' linux-2.4.22/net/ipv4/netfilter/ipt_REJECT.c linux-2.4.22-rejectfix/net/ipv4/netfilter/ipt_REJECT.c
>--- linux-2.4.22/net/ipv4/netfilter/ipt_REJECT.c	2003-08-25 13:44:44.000000000 +0200
>+++ linux-2.4.22-rejectfix/net/ipv4/netfilter/ipt_REJECT.c	2003-09-21 16:39:25.000000000 +0200
>@@ -186,8 +186,8 @@
> 	nskb->nh.iph->check = ip_fast_csum((unsigned char *)nskb->nh.iph, 
> 					   nskb->nh.iph->ihl);
> 
>-	/* "Never happens" */
>-	if (nskb->len > nskb->dst->pmtu)
>+	/* dst->pmtu can be zero because it is not set for local dst's */
>+	if (nskb->dst->pmtu && nskb->len > nskb->dst->pmtu)
> 		goto free_nskb;
> 
> 	connection_attach(nskb, oldskb->nfct);
>  
>
>------------------------------------------------------------------------
>
>Scanned by evaliation version of Dr.Web antivirus Daemon 
>http://drweb.ru/unix/
>
>  
>


