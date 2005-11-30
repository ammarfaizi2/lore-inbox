Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVK3AIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVK3AIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVK3AIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:08:31 -0500
Received: from amdext4.amd.com ([163.181.251.6]:55174 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751418AbVK3AIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:08:30 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Date: Tue, 29 Nov 2005 18:50:49 -0600
User-Agent: KMail/1.8
cc: "Nicholas Miell" <nmiell@comcast.net>,
       "Stephane Eranian" <eranian@hpl.hp.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
References: <200511291056.32455.raybry@mpdtxmail.amd.com>
 <1133306966.3271.36.camel@entropy>
 <20051129233920.GW19515@wotan.suse.de>
In-Reply-To: <20051129233920.GW19515@wotan.suse.de>
MIME-Version: 1.0
Message-ID: <200511291850.49853.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 30 Nov 2005 00:01:23.0663 (UTC)
 FILETIME=[338F35F0:01C5F541]
X-WSS-ID: 6F9234522XK324636-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 17:39, Andi Kleen wrote:
> > Well, if that's all you want them to use RDPMC 0 for, why not just make
> > PMCs programmable from userspace?
>
> First we need to have a cycle counter PMC anyways for the NMI watchdog.
> So it can as well be used for other purposes.
>

Yes, but that assumes having the NMI watchdog around is more important to you 
than having 4 performance counters available.    I'm perfectly willing to 
have the NMI watchdog around by default, since it seems to be useful in most 
cases.    But if my measurement study needs 4 PMC's to do its job and I am 
willing to forgo use of the NMI watchdog for that period of time, why 
shouldn't I be allowed to do that?   We have few enough PMCs anyway, I just 
don't like the idea of giving one up forever.    I'd much prefer to make that 
decision myself rather than have it enforced by the OS.    Let me make the 
tradeoffs about which is the most valuable in my particular situation, 
please.

Furthermore, if I know what I am doing, I can still make use of the RDTSC to 
do timing.   Yes, I have to pin the process to the current cpu and yes I have 
to force the power state to a known setup, and oh yeah, we have to turn off 
the halt in the idle loop, etc., etc., but after doing it works quite nicely, 
thank you.    And you've got a tremendous education problem to get people not 
to use the RDTSC and lots of existing programs that have to be modified.

So, sure, allow RDPMC from ring 3.    For people who want to use RDPMC and 
performance counter 0 for timing, let them do that.

The real issue here is that there needs to be a defined kernel interface to 
allow user programs to allocate and use PMCs and that is part of what this 
whole discussion on the perfctr-devel mailing list has been about.    Let's 
get that defined and then if a user requests PMC0 and insists on using it, 
then perhaps the NMI watchdog will simply have to go away until PMC0 is 
available to the kernel again.

I'm also not sure what the performance tradeoff between RDTSC/P and RDPMC is 
across processor implementations, now and future.     That's something that 
needs to be looked at.

> And using virtual performance counters adds a large cost the
> context switch for changing the MSRs around. An always running counter
> avoids this problem.
>
> -Andi

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

