Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUJGVal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUJGVal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJGV3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:29:12 -0400
Received: from smtp08.auna.com ([62.81.186.18]:54226 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S268213AbUJGVZx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:25:53 -0400
Date: Thu, 07 Oct 2004 21:25:41 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
In-Reply-To: <20041007114040.GV9106@holomorphy.com> (from wli@holomorphy.com
	on Thu Oct  7 13:40:40 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097184341l.10532l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.07, William Lee Irwin III wrote:
> Nick Sanders <sandersn@btinternet.com> wrote:
> >> I get the following oops when booting and it also stops kde
> >> (artswrapper) from starting with the same call trace. USB seems to
> >> be working which is good.
> 
> On Thu, Oct 07, 2004 at 02:50:07AM -0700, Andrew Morton wrote:
> > Could you please do
> > cd /usr/src/linux
> > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
> > patch -R -p1 < optimize-profile-path-slightly.patch
> > and retest?
...
> 
> Here is a more likely correct patch for what that was trying to do,
> however misguided that may be. Untested, uncompiled, vs. 2.6.9-rc3-mm3
> without the bad patch:
> 
...
> +static inline void profile_tick(int type, struct pt_regs *regs)
> +{
> +	extern cpumask_t prof_cpu_mask;
> +

This conflicts with kernel/irq/proc.c:

	unsigned long prof_cpu_mask = -1;

Shouldn't this be:

	cpumask_t prof_cpu_mask = CPU_MASK_NONE;

This will show problems when NR_CPUS > sizeof(long)....

Hope this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm2 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


