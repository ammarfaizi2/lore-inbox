Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUEAWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUEAWgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUEAWgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:36:32 -0400
Received: from holomorphy.com ([207.189.100.168]:48259 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262450AbUEAWgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:36:31 -0400
Date: Sat, 1 May 2004 15:35:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040501223505.GA1445@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501211704.GY1445@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
> +static inline void rcu_set_need_switch_cpumask(cpumask_t cpumask)
> +{
> +	int cpu;
> +	for_each_cpu_mask(cpu, cpumask)
> +		atomic_set(&per_cpu(rcu_data, cpu).need_switch, 1);
> +}

needs to be:
	for_each_online_cpu(cpu)
		atomic_set(&per_cpu(rcu_data, cpu).need_switch, !!cpu_isset(cpu, cpumask));


-- wli
