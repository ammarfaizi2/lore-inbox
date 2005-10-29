Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVJ2Bdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVJ2Bdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVJ2Bdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:33:40 -0400
Received: from ozlabs.org ([203.10.76.45]:46008 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750863AbVJ2Bdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:33:39 -0400
Subject: Re: [PATCH] sched hardcode non-smp set_cpus_allowed
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051027085346.27658.76262.sendpatchset@sam.engr.sgi.com>
References: <20051027085346.27658.76262.sendpatchset@sam.engr.sgi.com>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 11:33:37 +1000
Message-Id: <1130549617.7615.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 01:53 -0700, Paul Jackson wrote:
> @@ -945,7 +945,7 @@ extern int set_cpus_allowed(task_t *p, c
>  #else
>  static inline int set_cpus_allowed(task_t *p, cpumask_t new_mask)
>  {
> -	if (!cpus_intersects(new_mask, cpu_online_map))
> +	if (!cpu_isset(0, new_mask))
>  		return -EINVAL;
>  	return 0;
>  }

Hmm, I do slightly prefer the former, since it is exactly the same as
the SMP case, and doesn't hardcode 0.  Perhaps worth making
cpu_online_map a literal "1" for the UP case, which will help
everywhere.  With our include web, however, that might be tricky.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

