Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVE0CJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVE0CJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVE0CJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:09:09 -0400
Received: from ozlabs.org ([203.10.76.45]:63963 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261416AbVE0CJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:09:03 -0400
Subject: Re: Hotplug CPU printk issue
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
In-Reply-To: <17046.9315.652129.602688@napali.hpl.hp.com>
References: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	 <1117076334.4086.11.camel@linux-hp.sh.intel.com>
	 <20050525204828.70acc1b5.akpm@osdl.org>
	 <1117086211.7657.10.camel@linux-hp.sh.intel.com>
	 <20050525225204.68bf0684.akpm@osdl.org>
	 <17046.9315.652129.602688@napali.hpl.hp.com>
Content-Type: text/plain
Date: Fri, 27 May 2005 12:08:44 +1000
Message-Id: <1117159724.1392.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 12:32 -0700, David Mosberger wrote:
> >>>>> On Wed, 25 May 2005 22:52:04 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> Shaohua Li <shaohua.li@intel.com> wrote:
> 
>   >> > Please confirm that we in fact do not want to allow downed CPUs to
>   >> > print things, then send a patch.
>   >> Yep. In the cpu hotplug case, per-cpu data possibly isn't initialized
>   >> even the system state is 'running'. As the comments say in the original
>   >> code, some console drivers assume per-cpu resources have been allocated.
>   >> radeon fb is one such driver, which uses kmalloc. After a CPU is down,
>   >> the per-cpu data of slab is freed, so the system crashed when printing
>   >> some info.
> 
>   Andrew> hm, that certainly sounds sane, but I do recall there were
>   Andrew> reasonable-sounding reasons why the ia64 guys wanted
>   Andrew> printk-on-a-down-CPU to work.  Hopefully David can remember
>   Andrew> what the problem was so we can find a more thorough fix.
> 
> I don't recall having submitted such a patch.  According to the bk
> log, it was Rusty who added the !system_running check (which was later
> changed to system_state != SYSTEM_RUNNING).
> 
> The changelog only says:
> 
>  "- Allow printk on down cpus once system is running"

IIRC it was a great aid to debugging hotplug CPU, and there seemed no
reason to ban it.  I mean, you have to be running code on a down CPU,
which implies you're in arch code or you've done something wrong... I
don't have religious attachment to it, however!

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

