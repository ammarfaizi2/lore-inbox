Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEAPiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTEAPiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:38:17 -0400
Received: from watch.techsource.com ([209.208.48.130]:37003 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261188AbTEAPiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:38:16 -0400
Message-ID: <3EB142D5.60506@techsource.com>
Date: Thu, 01 May 2003 11:52:53 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: naive questions about thrashing
References: <3EB00FD2.5000008@techsource.com> <20030430230701.GA7256@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J.A. Magallon wrote:
> On 04.30, Timothy Miller wrote:
> 
>>I am running kernel version 2.4.18-26.7.x under Red Hat 7.2.
>>
>>I wrote a CPU-intensive program which attempts to use over 700 megs of 
>>RAM on a 512-meg box, therefore it thrashes.
>>
>>One thing I noticed was that 'top' reported that the kernel ("system") 
>>was using 68% of the CPU.  (The offending process was getting about 9%.) 
>>  How much CPU involvement is there in sending I/O requests to the drive 
>>and waiting on an interrupt?  Maybe I don't understand what's going on, 
>>but I would expect the CPU involvement in disk I/O to be practically 
>>NIL, unless it's trying to be really smart about it.  Is it?  Or maybe 
>>the kernel isn't using DMA... this is a Dell Precision 340.  I'm not 
>>sure what drive is in it, but I would be surprised if it weren't using DMA.
>>
> 
> 
> As I understand it, it is telling you that your programs spends 68% of
> its time is kernel space, ie, waiting your pages to come from disk. It
> does not mean that the CPU is doing anything, but it is locked by the
> kernel.

What would the kernel be locked while waiting on disk I/O?  Shouldn't it 
be running another process?  It's not DOING anything.  The whole idea 
behind a multitasking OS is to overlap the I/O of one process with the 
CPU usage of another whenever possible.  Swapping is an I/O operation.

And for that matter, if every runnable process has pages swapped out so 
that they cannot run, then the CPU should be IDLE.

Am I wrong?

> 
> If you can't afford to buy more memory, recode the thing. So much thrashing
> looks like you access your data very randomly. Try to process the data
> in a more sequential way, so you just fault after processing a big bunch
> of data. With 700Mb of data and a 512Mb box, at least half of your data
> fit in memory, so under an ideal sequential access you just would page
> 300Mb one time...
> 

The process got that large because of a bug in my program.  But a 
side-effect of that was kernel behavior that didn't make sense to me.  I 
decided to ask about it.

