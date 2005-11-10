Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVKJNw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVKJNw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVKJNw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:52:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33461 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750877AbVKJNwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:52:25 -0500
Message-ID: <4373508F.9060004@redhat.com>
Date: Thu, 10 Nov 2005 08:52:15 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] handling 64bit values for st_ino]
References: <20051110003024.GD7992@ftp.linux.org.uk> <437343B1.5000809@redhat.com> <20051110134336.GE7992@ftp.linux.org.uk>
In-Reply-To: <20051110134336.GE7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Thu, Nov 10, 2005 at 07:57:21AM -0500, Peter Staubach wrote:
>  
>
>>Has this potential degradation been measured?  This is a lot of extra
>>complexity which needs to justified by the resulting performance.
>>    
>>
>
>What extra complexity?
>
>  
>

Two different sized types to describe inode numbers, different paths, etc.
Having two of something, when just one would suffice, is usually more
complicated.

The simplest implementation would be to have one, 64 bit ino_t, and then
only places which need to know about 32 bit ino_t would know about them.
These places would be restricted to system call interfaces with defined
32 bit ino_t's and file systems which only support 32 bit ino_t's.

>>>	Fix is pretty cheap and consists of two parts:
>>>1) widen struct kstat ->ino to u64, add a macro (check_inumber()) to
>>>be used in callers of ->getattr() that want to store ->ino in possibly
>>>narrower fields and care about overflows (stuff like sys_old_stat() with
>>>its 16bit st_ino clearly doesn't ;-)
>>>      
>>>
>
>  
>
>>It seems to me that a type with a name which better matches the intended
>>semantics would be a better choice than u64.  Even something like ino64_t
>>would help file systems maintainers to correctly implement the appropriate
>>support.
>>    
>>
>
>Why the hell would fs maintainers needs to touch their code at all?
>Have you actually read that patches?
>

Yes, Al, I read the patches.  I didn't say anything about current file
systems needing make changes to implement this support.  You've already
proposed the changes to do so.  I am more concerned with new file systems
coming down the road and file system maintenance starting the second after
your changes are integrated.  You aren't going to be doing that support,
so we will be depending upon people who aren't as aware of the intended
semantics to do the support.  Maintenance of a file system implementation
is already complex enough, so anything that can be done to simplify the
job is a good thing.

       ps
