Return-Path: <linux-kernel-owner+w=401wt.eu-S1750917AbXAIDiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXAIDiJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXAIDiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:38:08 -0500
Received: from sandeen.net ([209.173.210.139]:23826 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXAIDiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:38:07 -0500
Message-ID: <45A30E1D.4030401@sandeen.net>
Date: Mon, 08 Jan 2007 21:38:05 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze:
 BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
References: <20070104001420.GA32440@m.safari.iki.fi>	<20070107213734.GS44411608@melbourne.sgi.com>	<20070108110323.GA3803@m.safari.iki.fi>	<45A27416.8030600@sandeen.net>	<20070108234728.GC33919298@melbourne.sgi.com>	<20070108161917.73a4c2c6.akpm@osdl.org>	<45A30828.6000508@sandeen.net> <20070108191800.9d83ff5e.akpm@osdl.org>
In-Reply-To: <20070108191800.9d83ff5e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 08 Jan 2007 21:12:40 -0600
> Eric Sandeen <sandeen@sandeen.net> wrote:
> 
>> Andrew Morton wrote:
>>> On Tue, 9 Jan 2007 10:47:28 +1100
>>> David Chinner <dgc@sgi.com> wrote:
>>>
>>>> On Mon, Jan 08, 2007 at 10:40:54AM -0600, Eric Sandeen wrote:
>>>>> Sami Farin wrote:
>>>>>> On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
>>>>>> ...
>>>>>>>> fstab was there just fine after -u.
>>>>>>> Oh, that still hasn't been fixed?
>>>>>> Looked like it =)
>>>>> Hm, it was proposed upstream a while ago:
>>>>>
>>>>> http://lkml.org/lkml/2006/9/27/137
>>>>>
>>>>> I guess it got lost?
>>>> Seems like it. Andrew, did this ever get queued for merge?
>>> Seems not.  I think people were hoping that various nasties in there
>>> would go away.  We return to userspace with a kernel lock held??
>> Is a semaphore any worse than the current mutex in this respect?  At 
>> least unlocking from another thread doesn't violate semaphore rules.  :)
> 
> I assume that if we weren't returning to userspace with a lock held, this
> mutex problem would simply go away.
> 

Well nobody's asserting that the filesystem must always be locked & 
unlocked by the same thread, are they?  That'd be a strange rule to 
enforce upon the userspace doing the filesystem management wouldn't it? 
  Or am I thinking about this wrong...

-Eric
