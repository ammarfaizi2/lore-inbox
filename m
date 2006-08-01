Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWHARZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWHARZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWHARZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:25:59 -0400
Received: from mail.tmr.com ([64.65.253.246]:60644 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751692AbWHARZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:25:58 -0400
Message-ID: <44CF9221.90902@tmr.com>
Date: Tue, 01 Aug 2006 13:40:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Alexandre Oliva <aoliva@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>	<20060730124139.45861b47.akpm@osdl.org>	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br> <17613.16090.470524.736889@cse.unsw.edu.au>
In-Reply-To: <17613.16090.470524.736889@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>[linux-raid added to cc.
> Background: patch was submitted to remove the current hard limit
> of 127 partitions that can be auto-detected - limit set by 
> 'detected_devices array in md.c.
>]
>
>My first inclination is not to fix this problem.
>
>I consider md auto-detect to be a legacy feature.
>I don't use it and I recommend that other people don't use it.
>However I cannot justify removing it, so it stays there.
>Having this limitation could be seen as a good motivation for some
>more users to stop using it.
>
>Why not use auto-detect?
>I have three issues with it.
>
> 1/
>    It just isn't "right".  We don't mount filesystems from partitions
>    just because they have type 'Linux'.  We don't enable swap on
>    partitions just because they have type 'Linux swap'.  So why do we
>    assemble md/raid from partitions that have type 'Linux raid
>    autodetect'? 
>  
>

I rarely think you are totally wrong about anything RAID, but I do 
believe you have missed the point of autodetect. It is intended to work 
as it does now, building the array without depending on some user level 
functionality. The name "autodetect" clearly differentiates this type 
from the others you mentioned, there is no implication that swap or 
Linux partitions should do anything automatically.

This is not a case of my using a feature and defending it, I don't use 
it currently. for all of the reasons you enumerate. That doesn't mean 
that I haven't used the autodetect in the past or that I won't in the 
future, particularly with embedded systems.

> 2/ 
>    It can cause problems when moving devices.  If you have two
>    machines, both with an 'md0' array and you move the drives from one
>    on to the other - say because the first lost a powersupply - and
>    then reboot the machine that received the drives, which array gets
>    assembled as 'md0' ?? You might be lucky, you might not. This
>    isn't purely theoretical - there have been pleas for help on
>    linux-raid resulting from exactly this - though they have been
>    few. 
>
> 3/ 
>    The information redundancy can cause a problem when it gets out of
>    sync.  i.e. you add a partition to a raid array without setting
>    the partition type to 'fd'.  This works, but on the next reboot
>    the partition doesn't get added back into the array and you have
>    to manually add it yourself.
>    This too is not purely theory - it has been reported slightly more
>    often than '2'.
>
>So my preferred solution to the problem is to tell people not to use
>autodetect.  Quite possibly this should be documented in the code, and
>maybe even have a KERN_INFO message if more than 64 devices are
>autodetected. 
>  
>
I don't personally see the value of autodetect for putting together the 
huge number of drives people configure. I see this as a way to improve 
boot reliability, if someone needs 64 drives for root and boot, they 
need to read a few essays on filesystem configuration. However, I'm 
aware that there are some really bizarre special cases out there.

Maybe the limit should be in KCONFIG, with a default of 16 or so.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

