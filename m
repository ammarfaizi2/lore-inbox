Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUJHJx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUJHJx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 05:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUJHJx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 05:53:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:54689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268311AbUJHJx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 05:53:56 -0400
Date: Fri, 8 Oct 2004 02:50:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Erich Focht <efocht@hpce.nec.com>
Cc: mbligh@aracnet.com, pj@sgi.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041008025034.3deedac5.akpm@osdl.org>
In-Reply-To: <200410081123.45762.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20041007105425.02e26dd8.pj@sgi.com>
	<1344740000.1097172805@[10.10.2.4]>
	<200410081123.45762.efocht@hpce.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht <efocht@hpce.nec.com> wrote:
>
>  May I translate the first sentence to: the requirements and usage
>  models described by Paul (SGI), Simon (Bull) and myself (NEC) are
>  "fairly obscure" and the group of users addressed (those mainly
>  running high performance computing (AKA HPC) applications) is "very
>  limited"? If this is what you want to say then it's you whose view is
>  very limited.

Martin makes a legitimate point.  We're talking here about a few tens or
hundreds of machines world-wide, yes?  And those machines are very
high-value so it is a relatively small cost for their kernel providers to
add such a highly specialised patch as cpusets.

These are strong arguments for leaving cpusets as an out-of-kernel.org
patch, for those who need it.

On the other hand, the impact is small:

 25-akpm/fs/proc/base.c            |   19 
 25-akpm/include/linux/cpuset.h    |   63 +
 25-akpm/include/linux/sched.h     |    7 
 25-akpm/init/Kconfig              |   10 
 25-akpm/init/main.c               |    5 
 25-akpm/kernel/Makefile           |    1 
 25-akpm/kernel/cpuset.c           | 1550 ++++++++++++++++++++++++++++++++++++++
 25-akpm/kernel/exit.c             |    2 
 25-akpm/kernel/fork.c             |    3 
 25-akpm/kernel/sched.c            |    8 
 25-akpm/mm/mempolicy.c            |   13 
 25-akpm/mm/page_alloc.c           |   13 
 25-akpm/mm/vmscan.c               |   19 

So it's a quite cheap patch for the kernel.org people to carry.

So I'm (just) OK with it from that point of view.  My main concern is that
the CKRM framework ought to be able to accommodate the cpuset function,
dammit.  I don't want to see us growing two orthogonal resource management
systems partly because their respective backers have no incentive to make
their code work together.

I realise there are technical/architectural problems too, but I do fear
that there's a risk of we-don't-have-a-business-case happening here too.

I don't think there are any architectural concerns around cpusets - the
major design question here is "is CKRM up to doing this and if not, why
not?".  From what Hubertus has been saying CKRM _is_ up to the task, but
the cpuset team may decide that the amount of rework involved isn't
worthwhile and they're better off carrying an offstream patch.

But we're not there yet - we're still waiting for the design dust to
settle.

