Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSJWB5P>; Tue, 22 Oct 2002 21:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSJWB5P>; Tue, 22 Oct 2002 21:57:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62477 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262602AbSJWB5N>;
	Tue, 22 Oct 2002 21:57:13 -0400
Message-ID: <3DB60363.8040104@pobox.com>
Date: Tue, 22 Oct 2002 22:03:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, andrea <andrea@suse.de>, ak@muc.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>, Jeff Dike <jdike@karaya.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.44_vsyscall_A1
References: <1035336629.954.90.camel@cog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	Here is the next rev of the i386 vsyscall gettimeofday port I sent
> earlier. I've added a fix for the linker trouble in the last one, as
> well as wrapped the whole thing in CONFIG_VSYSCALL. 
> 
> 	This patch implements gettimeofday in a user readable page, allowing
> for calls to gettimeofday to execute completely in userspace, giving a
> significant performance boost. 
>         
> 	Changes to glibc are unnecessary, because users that want to use the
> vsyscall can do so by LD_PRELOADING a library which alias gettimeofday
> before executing their application. This will not affect any other
> application and allows the backward compatibility issue to be ignored.
> I've created an example library (to be attached in a following email)
> and ran a quick performance test w/ and w/o the preloaded library,
> giving the following results:
>         
> Normal gettimeofday
> gettimeofday ( 1403307us / 1000000runs ) = 1.403306us
> vsyscall LD_PRELOAD gettimeofday
> gettimeofday ( 285423us / 1000000runs ) = 0.285423us
> 
> Since this code uses the TSC for calculating time of day, this patch
> will not help systems that suffer from TSC skew (ie: many NUMA systems,
> etc). However, for UP and SMP boxes this is a pretty major win.
> Alternative methods to use the cyclone/HPET registers for NUMA boxes are
> also feasible in the future. 
> 
> Please let me know your thoughts about 2.5 integration. 



In terms of implementation, I think it's way too x86-specific...  some 
of the vsyscall infrastructure can be more generic, making it easier for 
other arches to implement the same functionality.  Also use of TSC isn't 
a terribly good idea...

Overall the idea has existed for a while, and I think it's a good one... 
  gettimeofday(2) is very definitely a performance bottleneck in 
databases, in apache [if nothing's changed in that area...], etc.

	Jeff



