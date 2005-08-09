Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVHITjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVHITjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHITjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:39:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32251 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932249AbVHITjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:39:36 -0400
Message-ID: <42F905DA.4070308@mvista.com>
Date: Tue, 09 Aug 2005 12:36:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com>
In-Reply-To: <20050807165833.GA13918@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> 
>>Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen 
>>with further code cleanups. Are were there yet?
> 
> 
> Con,
> 	I am afraid until SMP correctness is resolved, then this is not
> in a position to go in (unless you want to enable it only for UP, which
> I think should not be our target). I am working on making this work 
> correctly on SMP systems. Hopefully I will post a patch soon.
> 
> Another observation I have made regarding dynamic tick patch is that PIT is 
> being reprogrammed whenever the CPUs are coming out of sleep state (because of 
> an interrupt say). This can happen at any arbitary time, not necessarily on 
> jiffy boundaries. As a result, there will be an offset between when jiffy 
> interrupts will now occur vs when they would have originally occured had PIT 
> never been stopped. Not sure if having this offset is good, but atleast one 
> necessary change that I foresee if zeroing delay_at_last_interrupt when 
> disabling dynamic tick.  For that matter, it may be easier to disable the PIT 
> timer by just masking PIT interrupts (instead of changing its mode).

IMNOHO, this is the ONLY way to keep proper time.  As soon as you 
reprogram the PIT you have lost track of the time.

My VST patch just turns masks the interrupt.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
