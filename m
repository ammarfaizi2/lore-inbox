Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVCWV0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVCWV0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVCWV0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:26:14 -0500
Received: from mail.tmr.com ([216.238.38.203]:26119 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261351AbVCWV0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:26:06 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Distinguish real vs. virtual CPUs?
Date: Wed, 23 Mar 2005 16:32:10 -0500
Organization: TMR Associates, Inc
Message-ID: <d1sm6q$5po$1@gatekeeper.tmr.com>
References: <42408D97.7000806@tmr.com><42408D97.7000806@tmr.com> <20050323175226.GB3272@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1111612443 5944 192.168.12.100 (23 Mar 2005 21:14:03 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20050323175226.GB3272@zero>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:
> On Tue, Mar 22, 2005 at 04:26:47PM -0500, Bill Davidsen wrote:
> 
>>It's not clear if that's bizarre practice on AMD system boards or if 
>>it's mis-reported. Of course Tom may be running a NUMA setup, in which 
>>case I won't guess what's expected to be displayed. I've added him to 
>>the CC list, in hopes of comment.
> 
> 
> It's numa (two cores, one ram ctrlr per core, one core per package). I'm
> running an x86 kernel, btw, not 64bit. I have CONFIG_X86_HT set, and it
> looks like it gets the pkg id from the apic (there's only one in multicore
> packages?), but i might be reading it wrong.
> 
> My dmseg overflows before syslog starts, so all i could gather is: 

Thanks, Tom. I suspect that NUMA has issues of its own in this area. I 
always set up the kernel buffer size and run dmesg with -s200000 or so 
on machines which tend to be overly verbose.

I leave it to someone really expert to figure out how to tell the actual 
number of sockets, cores, and siblings. I think the system scheduler may 
want this info, but I certainly don't intend to start 2nd guessing the 
kernel on this stuff. The current scheduler does a pretty good job of 
handling HT now, I'm not about to try and do better.

Interesting thought, I believe the IBM chip for PS not only has many 
cores, but one article said they were not all the same. That, and 
thoughts of someone running an SMP system with chips having 
non-identical sibling count make me glad someone else is doing the 
scheduler.
> 
> Mar 23 12:04:25 zero kernel: Brought up 2 CPUs
> Mar 23 12:04:25 zero kernel: CPU0 attaching sched-domain:
> Mar 23 12:04:25 zero kernel:  domain 0: span 3
> Mar 23 12:04:25 zero kernel:   groups: 1 2
> Mar 23 12:04:25 zero kernel: CPU1 attaching sched-domain:
> Mar 23 12:04:25 zero kernel:  domain 0: span 3
> Mar 23 12:04:25 zero kernel:   groups: 2 1
> 
> I don't know how the scheduling domains work, and i'm too busy to look it up
> right now.
> 


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
