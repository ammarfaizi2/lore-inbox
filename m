Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTJVAI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTJVAI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 20:08:28 -0400
Received: from holomorphy.com ([66.224.33.161]:28818 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263171AbTJVAI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 20:08:27 -0400
Date: Tue, 21 Oct 2003 17:08:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: (1/4) [PATCH] cpuset -- 2.6.0-test8
Message-ID: <20031022000808.GA14431@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr> <20031021162019.7089cee4.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021162019.7089cee4.shemminger@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 04:20:19PM -0700, Stephen Hemminger wrote:
> +static const int N = (8*sizeof(cpumask_t));
> +/* mask must NOT be ZERO ! */
> +/* this is a cyclic version of next_cpu */
> +static inline void _next_cpu(const cpumask_t mask, int * index)
> +{
> +	for(;;) {
> +		if (++*index >= N) *index = 0;
> +		if (cpu_isset(*index, mask)) return;
> +	}
> +}

Best not to insist NR_CPUS % BITS_PER_LONG == 0.


On Tue, Oct 21, 2003 at 04:20:19PM -0700, Stephen Hemminger wrote:
> +/* When a cpuset with attached processes is being realloc'ed CPUs
> + * update the processes' masks and migrate them
> + */
> +static void migrate_cpuset_processes(struct cpuset * cs)
> +{		
> +	struct task_struct *g, *p;
> +	/* This should be a RARE use of the cpusets.
> +	 * therefore we'll prefer an inefficient operation here
> +	 * (searching the whole process list)
> +	 * than adding another list_head in task_t
> +	 * and locks and list_add for each fork()
> +	 */

Unfair rwlocks can take boxen out when abused by quadratic algorithms.


-- wli
