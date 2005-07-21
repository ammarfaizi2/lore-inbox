Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVGULq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGULq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGULq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:46:28 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:32763 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261752AbVGULpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:45:49 -0400
Date: Thu, 21 Jul 2005 07:45:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12 PREEMPT_RT && PPC
In-reply-to: <42DF293A.4050702@timesys.com>
To: linux-kernel@vger.kernel.org
Cc: john cooper <john.cooper@timesys.com>, Ingo Molnar <mingo@elte.hu>
Message-id: <200507210745.57120.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507200816.11386.kernel@kolivas.org>
 <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 July 2005 00:48, john cooper wrote:
>Ingo,
>     Attached is a patch for 51-28 which brings PPC
>up to date for 2.6.12 PREEMPT_RT.  My goal was to
>get a more recent vintage of this work building and
>minimally booting for PPC.  Yet this has been stable
>even under our internal stress tests.  We now have
>this running on 8560 and 8260 PPC targets with a few
>others in the pipe.
>
>Remaining are a few known BUG asserts to address,
>but as we've historically been chasing seemingly
>PPC-specific (or perhaps usage-specific) problems in
>a fairly old code base it seemed high time to move
>forward.  I've also applied the same patch to 51-33
>which not being very far from 51-28 did apply clean,
>builds, boots, and appears equally stable as 51-28.
>
>In the process of producing the patch I stumbled
>across a change introduced in 51-15 where in the
>case of PREEMPT_RT it appears hw_irq_controller.end()
>is never being called at the end of do_hardirq().
>This appears to be an oversight in the code and
>the existing PPC openpic code does register a end()
>handler which it expects to be called in order to
>terminate the interrupt.  Otherwise interrupts at
>the current level are effectively disabled.

Humm, I wondering out loud if this is the video dma failure in tvtime?
Anyway, it applied cleanly over -33, and is building now, set for 
mode=4.

Rebooted, running it now, and no, this wasn't it, tvtime still has a 
BSOD with good audio.  However, where before I got about 4-6 cx88 
interrupts for a short run of tvtime each time I ran it, now I'm 
showing only 4 regardless.  Even if I leave it runnng, the count is 
stuck at 4.

I wonder if those 4 are associated with the initial insmod?
I've rmmod cx8800 cx88-dvb, then modprobe cx88-dvb which then shows 
the cx8800 module (unused) in an lsmod, but a cat of /proc/interrupts 
now shows 2 of them:

17:          4  IO-APIC-level  [........../  0]  cx88[0], cx88[0]

But I'll run this for a bit & see what else falls off on the 
curves. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
