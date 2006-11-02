Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWKBSrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWKBSrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWKBSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:47:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:32394 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751370AbWKBSrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:47:01 -0500
Date: Fri, 3 Nov 2006 00:16:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061102184637.GA23489@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org> <20061101233250.GA17706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101233250.GA17706@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Wed, Nov 01, 2006 at 06:32:50PM -0500, Dave Jones wrote:
> On Wed, Nov 01, 2006 at 03:09:52PM -0800, Linus Torvalds wrote:
> 
>  > Hmm. People _have_ given a damn, and I think you were even cc'd.
> 
> You're right. In my defense, that stuff arrived the day I went
> on vacation for two weeks, and I subsequently forgot all about it.
> Looking back over that thread though, a few people seemed to pick a
> number of holes in the patches, and there are some real gems in that
> thread like.

Have you looked at this patchset - http://lkml.org/lkml/2006/10/26/65 ?
This is the latest patchset posted last week and I haven't seen any 
comments on it.

>  > Really, the hotplug locking rules are fairly simple-
>  > 
>  > 1. If you are in cpu hotplug callback path, don't take any lock.
> 
> Which is just great, as afair, the cpufreq locks were there _before_
> someone liberally sprinkled lock_cpu_hotplug() everywhere.

This one has a major *cleanup* of cpufreq code including removel
of unncessary lock_cpu_hotplug() from cpufreq.

> 
> From what I can tell from looking at that thread back in August,
> it went on for a while with a number of people picking holes in the
> proposed patches, but there wasn't any reposted after that, and
> certainly nothing that ended up in -mm.
> 
> _something_ needs to be done. If someone wants to fix it, great, but
> until we see something mergable, we're left in this half-assed state
> which is freaking people out.

There are two approaches - Implicit hotplug callback order-based locking
as Andrew has done or keep the current cpu hotplug "lock" semantics
and just use a better lock (RCU-based) with cpu-local access in
the fast path. Gautham's patchset does the latter. lock_cpu_hotplug() is 
a misnomer, we should probably use get_cpu_hotplug() and 
put_cpu_hotplug() there.

Thanks
Dipankar
