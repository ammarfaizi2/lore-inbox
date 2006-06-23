Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWFWXod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFWXod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWFWXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 19:44:33 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:29654 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750779AbWFWXoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 19:44:32 -0400
Message-ID: <449C7CF0.4000002@acm.org>
Date: Fri, 23 Jun 2006 18:44:48 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Peter Palfrader <peter@palfrader.org>,
       openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
References: <20060613233521.GO22999@asteria.noreply.org>	<44962116.70302@acm.org>	<20060619093851.GL27377@asteria.noreply.org>	<449AA320.3060700@acm.org> <20060623025649.GE15027@lists.us.dell.com>
In-Reply-To: <20060623025649.GE15027@lists.us.dell.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also had a report from Matt that running the driver full-bore caused
the mouse to go haywire.  I did some testing and the mouse didn't go
haywire, but my keyboard did.  I changed the udelay(1) to schedule() and
kipmi0 is running at 100% as I type right now, and things seem to be
running smoothly.  Testing the performance, I got 4.5ms per message for
a get device id, which was the same as I saw before the change.  So I
think this change is a good idea.

I'll let Peter test it out when he gets his machines back, and if it all
looks good I'll do a patch.

Thanks,

-Corey

Matt Domsch wrote:
> On Thu, Jun 22, 2006 at 09:03:12AM -0500, Corey Minyard wrote:
>   
>> Peter, can you make a code change for me and try something out?
>>
>> If possible, could you change the call to udelay(1) in the function
>> ipmi_thread() in drivers/char/ipmi_si_intf.c to be a call to schedule()
>> instead?  I'm guessing that will fix this problem.
>>     
>
> won't that cause the thread to be scheduled out for at least one timer
> tick (1-10ms depending on HZ), especially as it's at nice 19?  This
> will cause the commands to be quite slow, which was the primary reason
> for the kthread here in the first place.
>
> Thanks,
> Matt
>
>   

