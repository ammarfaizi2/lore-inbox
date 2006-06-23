Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFWOzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFWOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFWOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:55:25 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:26102 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750812AbWFWOzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:55:23 -0400
Message-ID: <449C00EB.6050800@acm.org>
Date: Fri, 23 Jun 2006 09:55:39 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
References: <20060613233521.GO22999@asteria.noreply.org> <44962116.70302@acm.org> <20060619093851.GL27377@asteria.noreply.org> <449AA320.3060700@acm.org> <20060623025649.GE15027@lists.us.dell.com>
In-Reply-To: <20060623025649.GE15027@lists.us.dell.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
I think that will only happen if there are other things to run that are
higher priority, and you want those to run, anyway.  This doesn't affect
the processes priority like yield() would.

-Corey
