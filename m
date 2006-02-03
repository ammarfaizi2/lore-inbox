Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWBCPmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWBCPmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBCPmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:42:51 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:42451 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750914AbWBCPmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:42:50 -0500
Message-ID: <43E379C2.2020607@cfl.rr.com>
Date: Fri, 03 Feb 2006 10:41:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Bill Davidsen <davidsen@tmr.com>, Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org> <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com> <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 15:43:15.0448 (UTC) FILETIME=[8C0F0780:01C628D8]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--7.750000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:
> On Thu, 2 Feb 2006, Bill Davidsen wrote:
>
> Just to state clearly in the first place. I've allready solved the problem 
> by low-level formatting the entire disk that this inconsistent array in 
> question was part of.
>
> So now everything is back to normal. So unforunatelly I would not be able 
> to do any more tests on the device in the non-working state.
>
> I mentioned this problem here now just to let you konw that there is such 
> a problematic Linux behviour (and IMO flawed) in such circumstances, and 
> that perhaps it may let you think of such situations when doing further 
> improvements and development in the design of the block device layer (or 
> wherever the problem may possibly come from).
>
>   

It looks like the problem is in that controller card and its driver.  
Was this a proprietary closed source driver?  Linux is perfectly happy 
to access the rest of the disk when some parts of it have gone bad; 
people do this all the time.  It looks like your raid controller decided 
to take the entire virtual disk that it presents to the kernel offline 
because it detected errors.

<snip>
> The 0,0,0 is the /dev/sda. And even though this is now, after low-level 
> formatting of the previously inconsistent disc, the indications back then 
> were just the same. Which means every indication behaved as usual. Both 
> arrays were properly identified. But when I was accessing the inconsistent 
> one, i.e. /dev/sda, in any way (even just bytes, this has nothing to do 
> with any filesystems) the error messages mentioned above appeared. I'm not 
> sure what exactly was generating them, but I've CC'd Mark Salyzyn, maybe 
> he can explain more to it.
>
>   

How did you low level format the drive?  These days disk manufacturers 
ship drives already low level formatted and end users can not perform a 
low level format.  The last time I remember being able to low level 
format a drive was with MFM and RLL drives, prior to IDE.  My guess is 
what you actually did was simply write out zeros to every sector on the 
disk, which replaced the corrupted data in the effected sector with good 
data, rendering it repaired.  Usually drives will fail reads to bad 
sectors but when you write to that sector, it will write and read that 
sector to see if it is fine after being written again, or if the media 
is bad in which case it will remap the sector to a spare. 


