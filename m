Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVJCNw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVJCNw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVJCNw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:52:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:13018 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932231AbVJCNw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:52:28 -0400
Date: Mon, 3 Oct 2005 19:30:32 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: Ok to change cpuset flags for sched domains? (was [PATCH 1/3] CPUMETER ...)
Message-ID: <20051003140032.GA6629@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050908225539.0bc1acf6.pj@sgi.com> <20050909.203849.33293224.taka@valinux.co.jp> <20050909063131.64dc8155.pj@sgi.com> <20050910.161145.74742186.taka@valinux.co.jp> <20050910015209.4f581b8a.pj@sgi.com> <20050926093432.9975870043@sv1.valinux.co.jp> <20050927013751.47cbac8b.pj@sgi.com> <20050927113902.C78A570046@sv1.valinux.co.jp> <20050927084905.7d77bdde.pj@sgi.com> <20051002000159.3f15bf7a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002000159.3f15bf7a.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been wanting to follow the cpumeter discussion more closely,
but currently am tied up. I hope to have more time towards the end of
this week.

I had a few queries below, though

On Sun, Oct 02, 2005 at 12:01:59AM -0700, Paul Jackson wrote:
> Dinikar,
> 
> How much grief will it cause you if I make the following incompatible
> change to the special boolean files in each cpuset directory?
> 
> I think I goofed in encouraging you to overload "cpu_exclusive"
> with defining dynamic scheduler domains.  I should have asked for a
> separate flag to be added for that, say "sched_domain", which would
> require "cpu_exclusive=1" as a precondition.  Other attributes that
> require cpu_exclusive or mem_exclusive are showing up, and it makes
> more sense for each of them to get their own boolean, and leave the
> "*_exclusive" flags to specify just the exclusive (no overlap with
> sibling) attribute.


One of the reasons for overloading the cpu_exclusive flag was to
ensure that the rebalance code does not try to pull tasks unnecessarily

With the scheme that you are proposing that is a possibility if
you turn on the cpu_exclusive and meter_cpu for example and not
turn on sched_domain. Is there a reason why we would want to have
exclusive cpusets not attached to sched domains at all?

I am not entirely convinced that we can compare sched_domains and 
meter_cpus.

However I am still open if there is a convincing reason to have
exclusive cpusets that dont form sched domains.

	-Dinakar
