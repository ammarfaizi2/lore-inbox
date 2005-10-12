Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVJLB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJLB0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJLB0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:26:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbVJLB0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:26:38 -0400
Date: Tue, 11 Oct 2005 18:26:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
Message-Id: <20051011182600.4a5ce224.akpm@osdl.org>
In-Reply-To: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
References: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> 
> The per cpu nmi watchdog timer is based on an event counter.  
> idle cpus don't generate events so the NMI watchdog doesn't fire
> and the test to see if the watchdog is working fails.
> 
> - Add nmi_cpu_busy so idle cpus don't mess up the test.
> - kmalloc prev_nmi_count to keep kernel stack usage bounded.
> - Improve the error message on failure so there is enough
>   information to debug problems.
> 
> ...
>
>  static int __init check_nmi_watchdog(void)
>  {
> -	unsigned int prev_nmi_count[NR_CPUS];
> +	volatile int endflag = 0;

I don't think this needs to be declared volatile?
