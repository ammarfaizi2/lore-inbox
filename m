Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313817AbSD3Q7J>; Tue, 30 Apr 2002 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314496AbSD3Q7I>; Tue, 30 Apr 2002 12:59:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10989 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314085AbSD3Q7G>; Tue, 30 Apr 2002 12:59:06 -0400
Message-ID: <3CCECD42.8020108@us.ibm.com>
Date: Tue, 30 Apr 2002 09:58:42 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: g@redhat.com, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com> <3CCD811E.8689F4B0@redhat.com> <20020430134557.C26943@flint.arm.linux.org.uk> <3CCEC978.2090602@us.ibm.com> <20020430125214.A19533@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>I like the idea.  But, while we're at it, does anyone have a good enough 
>>grasp of locking the the TTY layer that we can start peeling some of the 
>>BKL out of there?  Somebody was doing tests over a serial console here 
>>and the lockmeter data showed horrible BKL contention and hold times.
> 
> I really really doubt that fixing contention will make serial ports go
> faster... 

I know :)  It just takes extra explaining on my part whenever someone 
sees the lockmeter data.

 > it'll just move to another lock since I suspect we're
 > just waiting for hardware

Just about any other lock is preferrable to the BKL.  Should 
ext2_update_inode() be blocked because someone hit "Enter"?

-- 
Dave Hansen
haveblue@us.ibm.com

