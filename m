Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJQJel>; Thu, 17 Oct 2002 05:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSJQJel>; Thu, 17 Oct 2002 05:34:41 -0400
Received: from [203.117.131.12] ([203.117.131.12]:40355 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261287AbSJQJek>; Thu, 17 Oct 2002 05:34:40 -0400
Message-ID: <3DAE858C.8010501@metaparadigm.com>
Date: Thu, 17 Oct 2002 17:40:28 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Vasquez <praka@san.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <1034710299.1654.4.camel@localhost.localdomain> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com> <3DACF908.70207@metaparadigm.com> <20021016054035.GM15552@clusterfs.com> <20021017015903.GA20960@praka.local.home> <1034822651.27.3.camel@localhost> <20021017031125.GA21251@praka.local.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/02 11:11, Andrew Vasquez wrote:
> On Wed, 16 Oct 2002, GrandMasterLee wrote:
> 
> 
>>On Wed, 2002-10-16 at 20:59, Andrew Vasquez wrote:
>>
>>>The stack issues were a major problem in the 5.3x series driver.  I
>>>believe, I can check tomorrow, 5.38.9 (the driver Dell distributes)
>>>contains fixes for the stack clobbering -- qla2x00-rh1-3 also contain
>>>the fixes.
>>
>>Does this mean that 6.01 will NOT work either? What drivers will be
>>affected? We've already made the move to remove LVM from the mix, but
>>your comments above give me some doubt as to how definite it is, that
>>the stack clobbering will be fixed by doing so. 
>>
> 
> The 6.x series driver basically branched from the 5.x series driver.  
> Changes made, many moons ago, are already in the 6.x series driver.
> To quell your concerns, yes, stack overflow is not an issue with the
> 6.x series driver. 
> 
> I believe if we are to get anywhere regarding this issue, we need to 
> shift focus from stack corruption in early versions of the driver.

Well corruption of bufferheads was happening for me with a potentially
stack deep setup (ext3+LVM+qlogic). Maybe it has been fixed in the
non-LVM case but is still an issue as I have had it with 6.0.1b3 -
The stack fix is listed in 6.0b13 which is quite a few release behind
the one i've had the problem with.

I posted the oops to lk about 3 weeks ago. Wasn't sure it was a qlogic
problem at the time, and still am not certain - maybe just sum of
stack(ext3+lvm+qlogic). Even if qla stack was trimmed for the common case,
it may still be a problem when LVM is active as there would be much
deeper stacks during block io.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103302016311188&w=2

The oops doesn't show qlogic at all although it is a corrupt bufferhead
that is causing the oops so may have been silently corrupted earlier
by a qlogic interrupt or block io submission while deep inside lvm and
ext3 or some such, ie. the oops is one of those difficult sort that shows
up corruption from some earlier event that is not directly traceable from
the oops itself.

~mc

