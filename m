Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267636AbUHJTqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267636AbUHJTqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUHJTqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:46:05 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19868 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267636AbUHJTp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:45:58 -0400
Message-ID: <411925FA.2000303@namesys.com>
Date: Tue, 10 Aug 2004 12:46:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Josh Aas <josha@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
Subject: Re: bkl cleanup in do_sysctl
References: <4118FE9D.2050304@sgi.com> <1092158905.11212.18.camel@nighthawk> <1092163919.782.54.camel@mindpipe>
In-Reply-To: <1092163919.782.54.camel@mindpipe>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2004-08-10 at 13:28, Dave Hansen wrote:
>
>  
>
>>Remember that the BKL isn't a plain-old spinlock.  You're allowed to
>>sleep while holding it and it can be recursively held, which isn't true
>>for other spinlocks.
>>
>>So, if you want to replace it with a spinlock, you'll need to do audits
>>looking for sysctl users that might_sleep() or get called recursively
>>somehow.  The might_sleep() debugging checks should help immensely for
>>the first part, but all you'll get are deadlocks at runtime for any
>>recursive holders.  But, those cases are increasingly rare, so you might
>>luck out and not have any.  
>>
>>Or, you could just make it a semaphore and forget about the no sleeping
>>requirement.  
>>
>>    
>>
>
>Someone once suggested that newbies who show up on LKML wanting to learn
>kernel hacking should be assigned to find one use of the BKL and replace
>it with proper locking.  Something similar worked very well with my
>previous employer, before giving someone root, new hires would first be
>assigned some task like writing a script to take the user account
>database and generate a report of old accounts on a bunch of machines,
>or rewrite the RADIUS accounting scripts, where the point was really to
>get them familiar with the system.
>
>This way, even if they come back with a totally botched fix, someone
>will probably just post a correct one.  We could get rid of the BKL very
>soon, I count only 247 files with lock_kernel in them.
>
>For example reiserfs uses the BKL for all write locking (!), but it
>probably would not be too hard to fix, because you can just look at
>another filesystem that has proper locking.
>  
>
Wrong. ;-)  Balancing makes it way hard.  Use reiser4.  That has very 
sophisticated locking that pushes the research envelope, if you want to 
read code to learn about locking.....

>Maybe this should be added to the FAQ:
>
>Q:  I want to hack the kernel, and I *think* I know what I am doing. 
>Where do I start?
>
>Lee
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

