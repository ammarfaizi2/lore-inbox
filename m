Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313682AbSD3Qmy>; Tue, 30 Apr 2002 12:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSD3Qmx>; Tue, 30 Apr 2002 12:42:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24794 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313682AbSD3Qmw>; Tue, 30 Apr 2002 12:42:52 -0400
Message-ID: <3CCEC978.2090602@us.ibm.com>
Date: Tue, 30 Apr 2002 09:42:32 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com> <3CCD811E.8689F4B0@redhat.com> <20020430134557.C26943@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Apr 29, 2002 at 06:21:34PM +0100, Arjan van de Ven wrote:
> 
>>I'm not convinced of that. It's not nearly a critical path and it's
>>better to get even the "dumb" drivers safe than to risk having big
>>security holes in there for years to come.
> 
> Would it be worth dropping a  BUG_ON(!kernel_locked()) in tty_open() to
> catch this type of error?  The tty code heavily relies on the BKL.
> 
> This way, such locking problems would get caught early, since everyone
> uses the tty code during boot, right?

I like the idea.  But, while we're at it, does anyone have a good enough 
grasp of locking the the TTY layer that we can start peeling some of the 
BKL out of there?  Somebody was doing tests over a serial console here 
and the lockmeter data showed horrible BKL contention and hold times.

-- 
Dave Hansen
haveblue@us.ibm.com

