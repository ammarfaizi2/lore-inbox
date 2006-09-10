Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWIJU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWIJU6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWIJU6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:58:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49059 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964933AbWIJU6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:58:36 -0400
Date: Mon, 11 Sep 2006 02:28:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: rcu_do_batch: rcu_data->qlen is not irq safe
Message-ID: <20060910205827.GD4690@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060910150820.GA7433@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910150820.GA7433@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 07:08:20PM +0400, Oleg Nesterov wrote:
> rcu_do_batch() decrements rdp->qlen with irqs enabled.
> This is not good, it can also be modified by call_rcu()
> from interrupt.
> 
> So, is it worth fixing? The problem is mostly theoretical.

I think we should fix it even though the problem is theoritical.

> If yes, is it ok to use local_t ? Iirc, the were some
> problems with local_t on some arches. Sometimes it is
> just atomic_t ...

AFAIK, x86 local_t is atomic. Not good.

> 
> Otherwise, we can update ->qlen after the main loop,
> 
> 	local_irq_disable();
> 	rdp->qlen -= count;
> 	local_irq_enable();
> 
> What dou you think?

We should do this.

Thanks
Dipankar
