Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319541AbSIMHfe>; Fri, 13 Sep 2002 03:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319545AbSIMHfe>; Fri, 13 Sep 2002 03:35:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24072
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319541AbSIMHfd>; Fri, 13 Sep 2002 03:35:33 -0400
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Cole <elenstev@mesatop.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Steven Cole <scole@lanl.gov>
In-Reply-To: <1031902595.4433.125.camel@phantasy>
References: <Pine.LNX.4.44.0209130914190.28568-100000@localhost.localdomain> 
	<1031902595.4433.125.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 03:40:25 -0400
Message-Id: <1031902825.4429.130.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 03:36, Robert Love wrote:

> -	if (unlikely(in_atomic()))
> -		BUG();
> +	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
> +		printk(KERN_ERROR "schedule() called while non-atomic!\n");
> +		show_stack(NULL);
> +	}

Actually, looking at this again, we probably want to still BUG() if
in_interrupt() but _not_ if in_atomic().

	Robert Love

