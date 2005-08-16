Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVHPNUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVHPNUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVHPNU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:20:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52963 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965212AbVHPNU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:20:26 -0400
Date: Tue, 16 Aug 2005 18:49:42 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, akpm@osdl.org,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org, ak@muc.de,
       george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050816131942.GD8608@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508141018.29668.kernel@kolivas.org> <20050815153541.GA4731@in.ibm.com> <200508160230.52860.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508160230.52860.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 02:30:51AM +1000, Con Kolivas wrote:
> Time definitely was lost the longer the machine was running.

I think I found the reason for time drift. Basically cur_timer->mark_offset
doesnt expect to be called from non-timer interrupt handler. Hence it drops
one jiffy from the lost count. I fixed this in some "crude" fashion and time
has not drifted so far or is pretty much close to what it was in pre-smp 
version.  Will find a neat way to fix this and post a patch soon.

> You mean disable it at runtime or not compile it in at all? Disabling it at 
> runtime caused what I described to you as PIT mode (long stalls etc).

I think I have recreated this on a machine here. Disabling 
CONFIG_DYN_TICK_APIC at compile-time didnt seem to make any difference. Will 
look at this problem next.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
