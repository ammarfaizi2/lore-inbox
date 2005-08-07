Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752349AbVHGQ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbVHGQ54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbVHGQ54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:57:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49608 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752348AbVHGQ54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:57:56 -0400
Date: Sun, 7 Aug 2005 22:28:33 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Message-ID: <20050807165833.GA13918@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508071512.22668.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen 
> with further code cleanups. Are were there yet?

Con,
	I am afraid until SMP correctness is resolved, then this is not
in a position to go in (unless you want to enable it only for UP, which
I think should not be our target). I am working on making this work 
correctly on SMP systems. Hopefully I will post a patch soon.

Another observation I have made regarding dynamic tick patch is that PIT is 
being reprogrammed whenever the CPUs are coming out of sleep state (because of 
an interrupt say). This can happen at any arbitary time, not necessarily on 
jiffy boundaries. As a result, there will be an offset between when jiffy 
interrupts will now occur vs when they would have originally occured had PIT 
never been stopped. Not sure if having this offset is good, but atleast one 
necessary change that I foresee if zeroing delay_at_last_interrupt when 
disabling dynamic tick.  For that matter, it may be easier to disable the PIT 
timer by just masking PIT interrupts (instead of changing its mode).

Will keep you posted of my progress with dynamic tick patch.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
