Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282183AbRK1XeE>; Wed, 28 Nov 2001 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282188AbRK1Xd5>; Wed, 28 Nov 2001 18:33:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58772 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282185AbRK1Xc1>; Wed, 28 Nov 2001 18:32:27 -0500
Message-ID: <3C057410.3090201@us.ibm.com>
Date: Wed, 28 Nov 2001 15:32:32 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>drivers' release functions.  The release functions are already 
>>serialized in the VFS code by an atomic_t which guarantees that each 
>>
>The release function was only partially serialized - what stops a release
>and an open racing each other ? That in several cases was why the lock
>was there. 
>
Nothing, because the BKL is not held for all opens anymore.  In most of 
the cases that we addressed, the BKL was in release _only_, not in open 
at all.  There were quite a few drivers where we added a spinlock, or 
used atomic operations to keep open from racing with release.  


