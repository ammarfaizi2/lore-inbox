Return-Path: <linux-kernel-owner+w=401wt.eu-S932591AbXAGPvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXAGPvP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbXAGPvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:51:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37884 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932577AbXAGPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:51:14 -0500
Date: Sun, 7 Jan 2007 16:48:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <npiggin@suse.de>, Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH 2.6.20] tasks cannot run on cpus onlined after boot
Message-ID: <20070107154804.GB3865@elte.hu>
References: <20070107084955.GD7654@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107084955.GD7654@localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Lynch <ntl@pobox.com> wrote:

> Commit 5c1e176781f43bc902a51e5832f789756bff911b ("sched: force
> /sbin/init off isolated cpus") sets init's cpus_allowed to a subset of
> cpu_online_map at boot time, which means that tasks won't be scheduled
> on cpus that are added to the system later.
> 
> Make init's cpus_allowed a subset of cpu_possible_map instead.  This 
> should still preserve the behavior that Nick's change intended.
> 
> Thanks to Giuliano Pochini for reporting this and testing the fix:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029397.html
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

nicely spotted!

> -	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
> +	cpus_andnot(non_isolated_cpus, cpu_possible_map, cpu_isolated_map);

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
