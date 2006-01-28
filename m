Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWA1AlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWA1AlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWA1AlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:41:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030354AbWA1AlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:41:21 -0500
Date: Fri, 27 Jan 2006 16:43:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: kiran@scalex86.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127164308.1ea4c3e5.akpm@osdl.org>
In-Reply-To: <43DABAA4.8040208@cosmosbay.com>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<43DAA586.5050609@cosmosbay.com>
	<20060127151635.3a149fe2.akpm@osdl.org>
	<43DABAA4.8040208@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> > 
> > An advantage of retaining a spinlock in percpu_counter is that if accuracy
> > is needed at a low rate (say, /proc reading) we can take the lock and then
> > go spill each CPU's local count into the main one.  It would need to be a
> > very low rate though.   Or we make the cpu-local counters atomic too.
> 
> We might use atomic_long_t only (and no spinlocks)

Yup, that's it.

> Something like this ?
> 

It'd be a lot neater if we had atomic_long_xchg().

