Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWHDV2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWHDV2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161488AbWHDV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:28:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18105 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161483AbWHDV23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:28:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Suspend on Dell D420
Date: Fri, 4 Aug 2006 23:27:38 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060804162300.GA26148@uio.no>
In-Reply-To: <20060804162300.GA26148@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608042327.38280.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 18:23, Steinar H. Gunderson wrote:
> [Please Cc me on any followups]
> 
> Hi,
> 
> Suspend-to-RAM works fine on my new Dell Latitude D420 (with Core Duo) in
> 2.6.16, but it broke in 2.6.17 -- the machine suspends just fine, but when it
> resumes, the disk never spins up, the screen stays black and it just hangs.
> Bisecting shows that the following commit is where it broke:
> 
> commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Wed Mar 22 00:08:16 2006 -0800
>  
>     [PATCH] on_each_cpu(): disable local interrupts
>  
>     When on_each_cpu() runs the callback on other CPUs, it runs with local
>     interrupts disabled.  So we should run the function with local interrupts
>     disabled on this CPU, too.
>  
>     And do the same for UP, so the callback is run in the same environment on both
>     UP and SMP.  (strictly it should do preempt_disable() too, but I think
>     local_irq_disable is sufficiently equivalent).
>  
>     Also uninlines on_each_cpu().  softirq.c was the most appropriate file I could
>     find, but it doesn't seem to justify creating a new file.
>  
>     Oh, and fix up that comment over (under?) x86's smp_call_function().  It
>     drives me nuts.
> 
> Applying the patch in reverse against 2.6.17 (it doesn't apply cleanly, but
> I've done what seems to be the moral equivalent) makes the suspend work
> again.
> 
> Any ideas? It does not work with the latest git checkout as of today.

I guess the patch may interfere with the CPU hotplug badly.  Could you please
check if you can take CPU1 offline/online?

Rafael
