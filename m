Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWGEALB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGEALB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGEALB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:11:01 -0400
Received: from ozlabs.org ([203.10.76.45]:222 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932359AbWGEALA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:11:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17579.907.4437.189054@cargo.ozlabs.ibm.com>
Date: Wed, 5 Jul 2006 10:10:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@sgi.com>, jes@sgi.com, torvalds@osdl.org,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
In-Reply-To: <20060703234134.786944f1.akpm@osdl.org>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
	<21169.1151991139@kao2.melbourne.sgi.com>
	<20060703234134.786944f1.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> But I think it'd be better to do just a single raw_smp_processor_id() for
> this entire function:
> 
>   static void bh_lru_install(struct buffer_head *bh)
>   {
> 	struct buffer_head *evictee = NULL;
> 	struct bh_lru *lru;
> +	int cpu;
> 
> 	check_irqs_on();
> 	bh_lru_lock();
> +	cpu = raw_smp_processor_id();
> -	lru = &__get_cpu_var(bh_lrus);
> +	lru = per_cpu(bh_lrus, cpu);

Better still, use the __raw_get_cpu_var() that I introduced.

Paul.
