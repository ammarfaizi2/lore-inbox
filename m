Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVD0Ags@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVD0Ags (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVD0Ags
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:36:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20730 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261791AbVD0Agr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:36:47 -0400
Message-ID: <426EDE19.3030600@mvista.com>
Date: Tue, 26 Apr 2005 17:34:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: ganzinger@mvista.com, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: del_timer_sync needed for UP  RT systems.
References: <426ED1EC.80500@mvista.com>	 <1114559749.12773.67.camel@dhcp153.mvista.com>	 <426ED97B.4050204@mvista.com> <1114561446.12772.71.camel@dhcp153.mvista.com>
In-Reply-To: <1114561446.12772.71.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Tue, 2005-04-26 at 17:14, George Anzinger wrote:
> 
> 
>>The problem here is that the reference is to timr, a pointer to something which 
>>has been deleted.  The memory may well be used elsewhere by this time which will 
>>make the test of it_process wrong.  It also means we could mess with someone 
>>elses memory in the memset above.
> 
> 
> Bottom line, you can use sys_timer_delete() on a timer, and trigger the
> same timer your deleting .. Those operations should be serialized, which
> they currently aren't .. 

I agree.  The change to do this is to use the del_timer_sync() or the 
del_singleshot_timer() code.

It is possible and desirable to be able to delete a running timer.  We don't 
want to take it away from the timer call back routine, however, as that leads to 
"bad things".  That is why these two del_* routines were written.
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
