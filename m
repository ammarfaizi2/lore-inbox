Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbUJ0Xml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUJ0Xml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUJ0XiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:38:13 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29850 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262679AbUJ0UwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:52:17 -0400
Message-ID: <41800B12.5020405@tmr.com>
Date: Wed, 27 Oct 2004 16:54:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org,
       david@gibson.dropbear.id.au
Subject: Re: MAP_SHARED bizarrely slow
References: <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us><20041027064527.GJ1676@zax> <20041027010659.15ec7e90.akpm@osdl.org>
In-Reply-To: <20041027010659.15ec7e90.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> James Cloos <cloos@jhcloos.com> wrote:
> 
>>>>>>>"David" == David Gibson <david@gibson.dropbear.id.au> writes:
>>
>>David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz
>>
>>David> On a number of machines I've tested - both ppc64 and x86 - the
>>David> SHARED version is consistently and significantly (50-100%)
>>David> slower than the PRIVATE version.
>>
>>Just gave it a test on my laptop and server.  Both are p3.  The
>>laptop is under heavier mem pressure; the server has just under
>>a gig with most free/cache/buff.  Laptop is still running 2.6.7
>>whereas the server is bk as of 2004-10-24.
>>
>>Buth took about 11 seconds for the private and around 30 seconds
>>for the shared tests.
>>
> 
> 
> I get the exact opposite, on a P4:
> 
> vmm:/home/akpm/maptest> time ./mm-sharemmap 
> ./mm-sharemmap  10.81s user 0.05s system 100% cpu 10.855 total
> vmm:/home/akpm/maptest> time ./mm-sharemmap
> ./mm-sharemmap  11.04s user 0.05s system 100% cpu 11.086 total
> vmm:/home/akpm/maptest> time ./mm-privmmap 
> ./mm-privmmap  26.91s user 0.02s system 100% cpu 26.903 total
> vmm:/home/akpm/maptest> time ./mm-privmmap
> ./mm-privmmap  26.89s user 0.02s system 100% cpu 26.894 total
> vmm:/home/akpm/maptest> uname -a
> Linux vmm 2.6.10-rc1-mm1 #14 SMP Tue Oct 26 23:23:23 PDT 2004 i686 i686 i386 GNU/Linux
> 
> It's all user time so I can think of no reason apart from physical page
> allocation order causing additional TLB reloads in one case.  One is using
> anonymous pages and the other is using shmem-backed pages, although I can't
> think why that would make a difference.

I think the cause was covered in another post, I'm surprised that the 
page overhead is reported as user time. It would have been a good hint 
if the big jump were in system time.

Yes, I know some kernel time is charged to the user, I'm just not sure 
diddling the page tables should be, since it might mask the effect of vm 
changes, etc.

That's comment not a suggestion.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
