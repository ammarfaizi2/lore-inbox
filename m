Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266921AbUGVTfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUGVTfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGVTfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:35:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:7496 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261378AbUGVTe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:34:58 -0400
Date: Thu, 22 Jul 2004 12:34:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [RFC] Patch for isolated scheduler domains
Message-Id: <20040722123437.1f0398db.pj@sgi.com>
In-Reply-To: <20040722164126.GB13189@sgi.com>
References: <20040722164126.GB13189@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should double check my logic, but I think a couple of the cpumask
calculations can be tightened up, as follows.

Dimitri Sivanich <sivanich@sgi.com> wrote:
> 
> +	cpumask_t cpu_nonisolated;
> +
> +	cpus_and(cpu_nonisolated, cpu_possible_map, isol_cpumask);
> +	cpus_complement(cpu_nonisolated, cpu_nonisolated);
> +	cpus_and(cpu_nonisolated, cpu_nonisolated, cpu_possible_map);

	cpumask_t cpu_nonisolated;
	cpus_andnot(cpu_nonisolated, cpu_possible_map, isol_cpumas);



> +		cpumask_t tmp = node_to_cpumask(i);
> +		cpumask_t nodemask;
> +		...
> +		cpus_and(nodemask, tmp, cpu_nonisolated);

		cpumask_t nodemask;
		...
		cpus_and(nodemask, node_to_cpumask(i), cpu_nonisolated);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
