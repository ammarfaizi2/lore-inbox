Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbTCPJfo>; Sun, 16 Mar 2003 04:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbTCPJfo>; Sun, 16 Mar 2003 04:35:44 -0500
Received: from holomorphy.com ([66.224.33.161]:30165 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262635AbTCPJfn>;
	Sun, 16 Mar 2003 04:35:43 -0500
Date: Sun, 16 Mar 2003 01:46:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316094613.GF20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030316083609.GE20188@holomorphy.com> <16504.1047806371@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16504.1047806371@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 20:24:57 -0800, William Lee Irwin III wrote:
>> That was a bit too braindead of a translation, yes. But it is x86 arch
>> code so it shouldn't be that large of an issue for big MIPS boxen etc.
>> I'll search & replace for stuff of this kind and wipe it out anyway.

William Lee Irwin III <wli@holomorphy.com> wrote:
> Good, it lets us optimize for 1/32/64/lots of cpus.  NR_CPUS > 8 *
> sizeof(unsigned long) is the interesting case, it needs arrays.

Well, I did the arrays and used them for everything but UP. The whole
bitmap stuff is there to back-end the thing. Perhaps excess generality,
but there's actually an eventual follow-on to this, which is nodemasks.
Those I probably can't do for my own machines, but I'm hoping if this
goes anywhere that someone can use the bitmap ADT for them.

As it turns out small SMP can probably still use the stuff I designated
as UP-only, and UP can probably be made even more lightweight. I'm sort
of turned off by all the special-casing, though. It was mostly a hack
to avoid messing too much with the preexisting UP special-cased smp.h
If I absolutely _have_ to special case, well...


On Sun, 16 Mar 2003 00:36:09 -0800, 
>> This suggests a "cpumask strategy". Care to share more, like your take
>> on such things as
>> 	p = req->task;
>> 	cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
>> 	rq_dest = cpu_rq(cpu_dest);
>> in kernel/sched.c?

On Sun, Mar 16, 2003 at 08:19:31PM +1100, Keith Owens wrote:
> That definitely needs encapsulation to handle cpus_allowed etc. being
> arrays.  A function to generate the logical and of p->cpus_allowed and
> cpu_online_map and return cpumask_t * is easy.  Doing ffs on that
> result will not work, it assumes NR_CPUS fits in a word.  Add
> ffs_cpumask(cpumask_t *).

Okay, that's more or less what the patch I did does, it has cpus_and(),
and just s/ffs_cpumask/first_cpu/. I was mostly wondering if you had
higher-level arch wrappers in mind, e.g. cpus_restrict_online() etc.


-- wli
