Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271148AbUJVD2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271148AbUJVD2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbUJVDYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:24:10 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:47269 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271062AbUJVDJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:09:51 -0400
Message-ID: <417879FB.5030604@yahoo.com.au>
Date: Fri, 22 Oct 2004 13:09:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andrea Arcangeli <andrea@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random>	<417728B0.3070006@yahoo.com.au>	<20041020213622.77afdd4a.akpm@osdl.org>	<417837A7.8010908@yahoo.com.au>	<20041021224533.GB8756@dualathlon.random>	<41785585.6030809@yahoo.com.au>	<20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org>
In-Reply-To: <20041021182651.082e7f68.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrea Arcangeli <andrea@novell.com> wrote:
> 
>>I'm still unsure if the 2.6 lower_zone_protection completely mimics the
>> 2.4 lowmem_zone_reserve algorithm if tuned by reversing the pages_min
>> settings accordingly, but I believe it's easier to drop it and replace
>> with a clear understandable API that as well drops the pages_min levels
>> that have no reason to exists anymore
> 
> 
> I'd be OK with wapping over to the watermark version, as long as we have
> runtime-settable levels.
> 

Please no "wapping" over :) This release is the first time the allocator
has been anywhere near working properly in this area.

Of course, if Andrea shows that the ->protection racket isn't sufficient,
then yeah.

> But I'd be worried about making the default values anything other than zero
> because nobody seems to be hitting the problems.
> 
> But then again, this get discussed so infrequently that by the time it
> comes around again I've forgotten all the previous discussion.  Ho hum.
> 

I think they probably should be turned on. A system with a gig of ram
shouldn't be able to use up all of ZONE_DMA on pagecache. It seems like
a small price to pay... same goes for very big highmem systems and ZONE_NORMAL.
