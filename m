Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSGIFXq>; Tue, 9 Jul 2002 01:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSGIFXp>; Tue, 9 Jul 2002 01:23:45 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:37108 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317306AbSGIFXp>; Tue, 9 Jul 2002 01:23:45 -0400
Message-ID: <3D2A73E6.9020907@us.ibm.com>
Date: Mon, 08 Jul 2002 22:25:58 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Drew P. Vogel" <dvogel@intercarve.net>
CC: Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207090037320.13295-100000@northface.intercarve.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew P. Vogel wrote:
>>   If nothing else, I hope you will think twice before sending off
>>   your next BKL removel patch in a subsystem that you haven't fully
>>   tested or understood.  That's the point I keep trying to get across
>>   here.
>>
>>So can you define for me under what conditions the BKL is appropriate
>>to use?  Removing it from legitimate uses would be bad, of course, but
>>part of the problem here is that it's currently used for a variety of
>>unrelated purposes.
> 
> If the trade-offs weigh in about the same, removing the BKL from
> legitimate uses in favor of a different (neither better nor worse)
> approach would be more than acceptable, would it not?

I think Greg's main protests are about the methods, not the means.

> Would creating a few new names for lock_kernel() and friends be
> acceptable? Just a few macros to give slightly more meaningful names to
> each function call for 2.5. Then take lock_kernel() entirely away (the
> name, not the function), in 2.7. By 2.9 it should be able to be removed
> from nearly all "inappropriate" uses. This seems like it would encourage
> more  explicit usage of the BKL, while giving maintainers ample time to
> comply.

I would really prefer not to see the name changed.  In some places 
people do this:

#define mydriver_lock() lock_kernel();
#define mydriver_unlock() unlock_kernel();

All that this really does is obscure the BKL's use -- it makes it 1 
step harder to track down.  If you need a spinlock, use a spinlock. 
If you need the BKL, by all means, take the BKL.

A comment is immeasurable better than a different name.  I would say, 
if you need/want the BKL, justify it with a comment, not a name.

> Note that I have never added or removed a lock from the kernel. I am
> simply thinking aloud; half hoping to be corrected.

I know the feeling :)

-- 
Dave Hansen
haveblue@us.ibm.com

