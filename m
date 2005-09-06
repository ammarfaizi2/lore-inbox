Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVIFKq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVIFKq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVIFKq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:46:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62624 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964801AbVIFKq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:46:56 -0400
Date: Tue, 6 Sep 2005 16:16:03 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, s0348365@sms.ed.ac.uk, kernel@kolivas.org,
       tytso@mit.edu, cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick calculation in timer_pm.c
Message-ID: <20050906104603.GA17654@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe> <20050906103232.GA22278@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906103232.GA22278@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:32:32PM +0200, Pavel Machek wrote:
> Try running this from userspace (and watch for time going completely
> crazy). Try it in mainline, too; it broke even vanilla some time
> ago. Need to run as root. 

Note that kernel relies on some backing time source (like TSC/PM)
to recover lost ticks (& time). And these backing time source have 
their own limitation on how many max lost ticks you can recover,
which in turn means how long you can have interrupts blocked.
In case of TSC, since only 32-bit previous snapshot is maintained (in x86
atleast) it allows for ticks to be lost only upto a second (if I remember
correctly), while the 24-bit ACPI PM timer allows for upto 3-4
seconds. 

I found that the while loop below takes 3.66 seconds running
on a 1.8GHz P4 CPU. That may be too much if kernel is using
(32-bit snapshot of) TSC to recover ticks, while maybe just
at the max limit allowed for ACPI PM timer.

I will test this code with the lost-tick recovery fixes
for ACPI PM timer that I sent out and let you know
how it performs!

>                 for (i=0; i<1000000000; i++)
>                         asm volatile("");

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
