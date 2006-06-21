Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWFUEK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWFUEK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWFUEK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:10:58 -0400
Received: from rtr.ca ([64.26.128.89]:11243 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750938AbWFUEK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:10:57 -0400
Message-ID: <4498C6CF.3080206@rtr.ca>
Date: Wed, 21 Jun 2006 00:10:55 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: js@linuxtv.org, pavel@ucw.cz, p.lundkvist@telia.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
References: <20060520130326.GA6092@localhost>	<20060520103728.6f3b3798.akpm@osdl.org>	<20060520225018.GC8490@elf.ucw.cz>	<20060520171244.4399bc54.akpm@osdl.org>	<20060616212410.GA6821@linuxtv.org>	<4496C5AC.3030809@rtr.ca>	<4498BF51.5090204@rtr.ca> <20060620205415.d808ace9.akpm@osdl.org>
In-Reply-To: <20060620205415.d808ace9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 20 Jun 2006 23:38:57 -0400
> Mark Lord <lkml@rtr.ca> wrote:
> 
>>> I just gave it a try here.  With or without a suspend/resume cycle after 
>>> boot,
>>> the "sync" time is much quicker.  But the Dirty count in /proc/meminfo
>>> still shows very huge (eg. 600MB) values that never really get smaller
>>> until I type "sync".  But that subsequent "sync" only takes a couple
>>> of seconds now, rather than 10-20 seconds like before.
>> ..
>>
>> Yup, behaviour is *definitely* much better now.  I'm not sure why
>> the /proc/meminfo "Dirty" count lags behind reality, but the disk
>> is being kept much more up-to-date than without this patch.
> 
> Are you able to come up with a foolproof set of steps which would allow the
> laggy-dirtiness to be reproduced by yours truly?

Heh.. don't I wish!

The best is still as described originally:

http://lkml.org/lkml/2006/2/6/170

Basically, "cat" a ton of huge files together into a single new one,
and then watch /proc/meminfo to see what happens.  For me, the count
there still just hangs at some big number like 500MB until I type "sync",
at which point it (nearly) instantly now goes to zero.

Previous to this patch, the "sync" actually resulted in a ton of disk writes,
but now those happen on the tail end of the "cat" command, as they should.

My kernel .config is available from http://rtr.ca/dell_i9300/kernel/latest/

Cheers
