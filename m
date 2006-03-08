Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWCHCQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWCHCQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWCHCQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:16:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752029AbWCHCQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:16:42 -0500
Date: Tue, 7 Mar 2006 18:14:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 2/4] net: percpufy frequently used vars -- struct
 proto.memory_allocated
Message-Id: <20060307181422.3e279ca1.akpm@osdl.org>
In-Reply-To: <20060308020118.GC9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308020118.GC9062@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> -	if (atomic_read(sk->sk_prot->memory_allocated) < sk->sk_prot->sysctl_mem[0]) {
>  +	if (percpu_counter_read(sk->sk_prot->memory_allocated) <
>  +			sk->sk_prot->sysctl_mem[0]) {

Bear in mind that percpu_counter_read[_positive] can be inaccurate on large
CPU counts.

It might be worth running percpu_counter_sum() to get the exact count if we
think we're about to cause something to fail.

