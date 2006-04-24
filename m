Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWDXXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWDXXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDXXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:11:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751011AbWDXXL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:11:26 -0400
Date: Mon, 24 Apr 2006 16:09:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       schwidefsky@de.ibm.com, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-Id: <20060424160943.4bbdb788.akpm@osdl.org>
In-Reply-To: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> @@ -485,6 +485,14 @@ int rcu_pending(int cpu)
>  		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
>  }
>  
> +int rcu_soon_pending(int cpu)
> +{
> +	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
> +
> +	return (!!rdp->curlist || !!rdp_bh->curlist);
> +}

This patch sets my nerves a-jangling.

What are the units of soonness?  It's awfully waffly.  Can we specify this
more tightly?

Neither rcu_pending() nor rcu_soon_pending() are commented or documented. 
Pity the poor user trying to work out what they do, and how they differ. 
They're global symbols and they form part of the RCU API - they should be
kernel docified, please.

There's probably a reason why neither of these symbols are exported to
modules.  Once they're actually documented I mught be able to work out what
that reason is ;)

