Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGEVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGEVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWGEVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:04:59 -0400
Received: from mail.tmr.com ([64.65.253.246]:46761 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964848AbWGEVE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:04:58 -0400
Message-ID: <44AC2B56.8010703@tmr.com>
Date: Wed, 05 Jul 2006 17:12:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org>
In-Reply-To: <20060705125956.GA529@fieldses.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:

>On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
>  
>
>>Theodore Tso wrote:
>>    
>>
>>>Some of the ideas which have been tossed about include:
>>>
>>>	* nanosecond timestamps, and support for time beyond the 2038
>>>      
>>>
>>The 2nd one is probably more urgent than the first. I can see a general 
>>benefit from timestamp in ms, beyond that seems to be a specialty 
>>requirement best provided at the application level rather than the bits 
>>of a trillion inodes which need no such thing.
>>    
>>
>
>What's urgently needed for NFS (and I suspect for most other
>applications demanding higher timestamps) isn't really nanosecond
>precision so much as something that's guaranteed to increase whenever
>the file changes.
>
>Of course, just adding space in the inodes for nanoseconds isn't
>sufficient.  XFS, for example, has nanosecond timestamps, but it's still
>easy to modify a file twice without seeing the ctime or mtime change.
>So either we need a timesource guaranteed to tick faster than the kernel
>can process IO, or we have to be willing to, say, add 1 to the
>nanoseconds field whenever the time doesn't change between operations.
>
>Or we could add an entirely separate attribute that's guaranteed to
>increase whenever the ctime is updated, and that doesn't necessarily
>have any connection with time--call it a version number or something.
>  
>
There are versions in both VMS and the ISO filesystem. I have a sneaking 
suspicion that those of us who ever use them are few and far between. 
The other issue is that unless the field is time, programs like make 
can't really use it, at least without becoming Linux specific.

I'm not sure exactly how a "version" value would be used other than 
detecting the fact that the file had been changed in some way. Feel free 
to show me, I seem to come up empty on using this value.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

