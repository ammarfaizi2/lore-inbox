Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSGIVnQ>; Tue, 9 Jul 2002 17:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSGIVnP>; Tue, 9 Jul 2002 17:43:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47807 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317423AbSGIVnO>;
	Tue, 9 Jul 2002 17:43:14 -0400
Message-ID: <3D2AF6EA.1030008@us.ibm.com>
Date: Tue, 09 Jul 2002 07:44:58 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@mvista.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <20020709201703.GC27999@kroah.com>	<200207092055.g69Ktt418608@eng4.beaverton	 .ibm.com> 	<20020709210053.GF25360@holomorphy.com>	<1026249175.1033.1178.camel@sinai>  <3D2AF10A.1020603@us.ibm.com> <1026250151.1623.1185.camel@sinai>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2002-07-09 at 07:19, Dave Hansen wrote:
> 
>>Robert Love wrote:
>>
>>>The problem is, it is needed in a _lot_ of places.  Mostly instances
>>>where the lock is held across something that may implicitly sleep.
>>
>>And _that_ is why I wrote the BKL debugging patch, to help find these 
>>places at runtime.  It may not be pretty, but it works.  I'll post it 
>>again if you're interested.
> 
> I saw the patch... the problem is we cannot say "oh I ran this code path
> with the patch and did not see anything, it is safe".  Can sleep != will
> sleep, and thus we have code that 99% will not sleep but it may.

That's a good point, but we have to start somewhere.  I think this is 
a reasonable way to start looking for bad behavior.  Since you have to 
fix all of them anyway, why not let the easy bunch come to you instead 
of seeking them out?  In a couple of kernel versions, I'd like to make 
it a BUG() to use the BKL in a nested fashion, or hold it during a 
schedule.  I think that his would be a reasonable thing to do during 
the early days of the first development series after we think we have 
this thing licked.  But, that is admittedly ages from now in kernel 
time.

The Stanford Checker or something resembling it would be invaluable 
here.  It would be a hell of a lot better than my litle patch!

-- 
Dave Hansen
haveblue@us.ibm.com

