Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285568AbRLGVtj>; Fri, 7 Dec 2001 16:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285573AbRLGVt3>; Fri, 7 Dec 2001 16:49:29 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47496 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285568AbRLGVtX>; Fri, 7 Dec 2001 16:49:23 -0500
Message-ID: <3C11394D.90101@us.ibm.com>
Date: Fri, 07 Dec 2001 13:49:01 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Udo A. Steinberg" <reality@delusion.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Udo A. Steinberg" wrote:
>
>>Hi Andrew,
>>
>>According to Linus' 2.5.1-pre changelog, the release locking changes
>>introduced in -pre5 are your work. Those changes, however, seem to
>>break the keyboard driver:
>>
>>keyboard: Timeout - AT keyboard not present?(f4)
>>
>>Other people (i.e. Mike Galbraith) have been experiencing the same.
>>
>wasntmeididntdoit
>
>>Do you have an updated patch which fixes those issues? -pre6 still
>>contains the same stuff as -pre5 and if it's broken then Linus should
>>probably back it out.
>>

I'm responsible for the release locking changes.  But, I don't think 
that the problems are a result of those changes.  There have been some 
other patches that might have caused the problem.  Take a look at this 
thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100745930928683&w=2

Jens Axboe posted a patch.  I asked him:
 > So, what was the actual problem?
bio_alloc() not waiting on the reserved pool for free entries, even
though __GFP_WAIT was set. No need for __GFP_IO in that case too.

Udo, did you apply the patch that Jens sent?

