Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVD0Auy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVD0Auy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVD0Auy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:50:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18430 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261869AbVD0Aut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:50:49 -0400
Subject: Re: del_timer_sync needed for UP  RT systems.
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: george@mvista.com
Cc: ganzinger@mvista.com, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <426EDE19.3030600@mvista.com>
References: <426ED1EC.80500@mvista.com>
	 <1114559749.12773.67.camel@dhcp153.mvista.com>
	 <426ED97B.4050204@mvista.com>
	 <1114561446.12772.71.camel@dhcp153.mvista.com>
	 <426EDE19.3030600@mvista.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1114563040.12772.85.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Apr 2005 17:50:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 17:34, George Anzinger wrote:
> I agree.  The change to do this is to use the del_timer_sync() or the 
> del_singleshot_timer() code.
> 
> It is possible and desirable to be able to delete a running timer.  We don't 
> want to take it away from the timer call back routine, however, as that leads to 
> "bad things".  That is why these two del_* routines were written.


I'll defer to you on that, since I don't really know what timer people
need.. 

After reviewing, del_timer_sync() I don't think that will stop this
race. Because the wakeup happens before posix_timer_fn() is called in
__run_timers() .

Daniel

