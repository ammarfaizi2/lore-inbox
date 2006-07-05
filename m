Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWGEVOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGEVOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGEVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:14:32 -0400
Received: from mail.tmr.com ([64.65.253.246]:49065 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964814AbWGEVOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:14:31 -0400
Message-ID: <44AC2D9A.7020401@tmr.com>
Date: Wed, 05 Jul 2006 17:22:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org> <1152128033.22345.17.camel@lade.trondhjem.org>
In-Reply-To: <1152128033.22345.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Wed, 2006-07-05 at 08:59 -0400, J. Bruce Fields wrote:
>  
>
>>On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
>>    
>>
>>>Theodore Tso wrote:
>>>      
>>>
>>>>Some of the ideas which have been tossed about include:
>>>>
>>>>	* nanosecond timestamps, and support for time beyond the 2038
>>>>        
>>>>
>>>The 2nd one is probably more urgent than the first. I can see a general 
>>>benefit from timestamp in ms, beyond that seems to be a specialty 
>>>requirement best provided at the application level rather than the bits 
>>>of a trillion inodes which need no such thing.
>>>      
>>>
>>What's urgently needed for NFS (and I suspect for most other
>>applications demanding higher timestamps) isn't really nanosecond
>>precision so much as something that's guaranteed to increase whenever
>>the file changes.
>>    
>>
>
>NFS doesn't necessarily require monotonicity either. The only real
>requirement that knfsd has is that the timestamp needs to change every
>time the file data (mtime+ctime) and/or metadata (ctime only) is
>changed.
>
>Applications like 'make' OTOH, probably would be happier if the
>timestamps are guaranteed to be monotonic.
>

Consider the case where the build machine reads source from one network 
filesystem and write the binary result to another on another machine. If 
you know that I have the kernel source on a file server, do the compiles 
on a compute server, and store the binaries on three test machines for 
evaluation, you might guess this really can happen. Just increasing the 
timestamp may not solve the problem, unless you have a system call to 
set timestamp over network f/s, like a high resolution touch.

It's a problem when there are multiple times involved.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

