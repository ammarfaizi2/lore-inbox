Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSJXUZC>; Thu, 24 Oct 2002 16:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265639AbSJXUZC>; Thu, 24 Oct 2002 16:25:02 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:47086 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S265643AbSJXUZB>;
	Thu, 24 Oct 2002 16:25:01 -0400
Message-ID: <3DB858A3.10104@wmich.edu>
Date: Thu, 24 Oct 2002 16:31:31 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com>	<200210242048.36859.earny@net4u.de>  <3DB85385.6030302@wmich.edu> <1035490431.1501.101.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Thu, 2002-10-24 at 16:09, Ed Sweetman wrote:
> 
> 
>>I seem to be seeing compiler optimizations come into play with the 
>>numbers and not any mention of them that i've seen has been talked 
>>about. That could be causing any discrepencies with predicted values. So 
>>not only would we have to look at algorithms, but also the compilers and 
>>what optimizations we plan on using them with.  Some do better on 
>>certain compilers+flags than others. It's a mixmatch that seems to only 
>>get complicated the more realistic you make it.
> 
> 
> The majority of the program is inline assembly so I do not think
> compiler is playing a huge role here.
> 
> Regardless, the numbers are all pretty uniform in saying the new no
> prefetch method is superior so its a mute point.
> 
> 	Robert Love

With gcc 3.x i get

495MB/s  with -O3 -march=athlon-tbird -mcpu=athlon-tbird -falign-loops=4 
-falign-functions=4

488MB/s with -O3 -march=athlon-tbird -mcpu=athlon-tbird -falign-loops=4

467MB/s with -O0 -march=i686 -mcpu=i686

which is almost a 30MB/s difference or 6% simply from compiler options 
of the same compiler.  It may not mean much in 1 second. But few things 
where we care about performance are only run for one second.

I'd expect something below 3% and realistically closer to 1%. Any ideas 
as to why it is making a difference?  Does the execution path to the 
function in C really take up performance to drop 30MB/s of memory 
bandwidth because from the looks of it this program is very small and 
things should be really quick to the asm functions.

