Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVHKXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVHKXdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVHKXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:33:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:27550 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751033AbVHKXdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:33:16 -0400
Date: Fri, 12 Aug 2005 01:33:02 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 3/8] [PATCH] x86_64: Fixing smpboot timing problem
Message-ID: <20050811233302.GA8974@wotan.suse.de>
References: <20050811225445.404816000@localhost.localdomain> <20050811225609.058881000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811225609.058881000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void __cpuinit tsc_sync_wait(void)
>  {
>  	if (notscsync || !cpu_has_tsc)
>  		return;
> -	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
> -			boot_cpu_id);
> -	sync_tsc();
> +	sync_tsc(boot_cpu_id);

I actually found a bug in this today. This should be sync_tsc(0), not sync_tsc(boot_cpu_id)
Can you just fix it in your tree or should I submit a new patch? 

-Andi
