Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752009AbWCHCPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWCHCPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCHCPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:15:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752009AbWCHCPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:15:06 -0500
Date: Tue, 7 Mar 2006 18:13:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add
 percpu_counter_mod_bh
Message-Id: <20060307181301.4dd6aa96.akpm@osdl.org>
In-Reply-To: <20060308015934.GB9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> +static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
>  +{
>  +	local_bh_disable();
>  +	percpu_counter_mod(fbc, amount);
>  +	local_bh_enable();
>  +}
>  +

percpu_counter_mod() does preempt_disable(), which is redundant in this
context.  So just do fbc->count += amount; here.


