Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUIELqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUIELqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIELqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:46:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49081 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266474AbUIELpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:45:10 -0400
Date: Sun, 5 Sep 2004 13:46:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [sched] fix sched_domains hotplug bootstrap ordering vs. cpu_online_map issue
Message-ID: <20040905114645.GA11422@elte.hu>
References: <1094246465.1712.12.camel@mulgrave> <20040903145925.1e7aedd3.akpm@osdl.org> <20040903222212.GV3106@holomorphy.com> <20040903153434.15719192.akpm@osdl.org> <20040903224507.GX3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903224507.GX3106@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> This is the whole thing; the "other half" referred to a new hunk added to
> >> the patch (identical to this one) posted in its entirety.
> 
> On Fri, Sep 03, 2004 at 03:34:34PM -0700, Andrew Morton wrote:
> > ho-hum. changelog, please?
> 
> cpu_online_map is not set up at the time of sched domain
> initialization when hotplug cpu paths are used for SMP booting. At
> this phase of bootstrapping, cpu_possible_map can be used by the
> various architectures using cpu hotplugging for SMP bootstrap, but the
> manipulations of cpu_online_map done on behalf of NUMA architectures,
> done indirectly via node_to_cpumask(), can't, because cpu_online_map
> starts depopulated and hasn't yet been populated. On true NUMA
> architectures this is a distinct cpumask_t from cpu_online_map and so
> the unpatched code works on NUMA; on non-NUMA architectures the
> definition of node_to_cpumask() this way breaks and would require an
> invasive sweeping of users of node_to_cpumask() to change it to e.g.
> cpu_possible_map, as cpu_possible_map is not suitable for use at
> runtime as a substitute for cpu_online_map.
> 
> Signed-off-by: William Irwin <wli@holomorphy.com>

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
