Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUFITnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUFITnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFITnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:43:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20362 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265878AbUFITnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:43:03 -0400
Message-ID: <40C76861.4040600@tmr.com>
Date: Wed, 09 Jun 2004 15:43:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: John Bradford <john@grabjohn.com>
CC: Rik van Riel <riel@redhat.com>,
       =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= =?ISO-8859-1?Q?_/_Tronic?= 
	<tronic2@sci.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about cache and swap
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com> <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Rik van Riel <riel@redhat.com>:
> 
>>On Sat, 5 Jun 2004, [UTF-8] Lasse K=C3=A4rkk=C3=A4inen / Tronic wrote:
>>
>>
>>>In order to make better use of the limited cache space, the following
>>>methods could be used:
>>
>>	[snip magic piled on more magic]
>>
>>I wonder if we should just bite the bullet and implement
>>LIRS, ARC or CART for Linux.  These replacement algorithms
>>should pretty much detect by themselves which pages are
>>being used again (within a reasonable time) and which pages
>>aren't.
> 
> 
> Is the current system really bad enough to make it worthwhile, though?

Yes! The current implementation just uses all the memory available, and 
pushes any programs not actively running out to disk. Click the window 
and go for coffee. On a small machine that's needed, but for almost any 
typical usage, desktop or server, pushing out programs to have 3.5GB of 
buffer instead of 3.0 doesn't help disk performance.

> Is there really much performance to be gained from tuning the 'limited' cache
> space, or will it just hurt as many or more systems than it helps?

I doubt it, but it would be nice to have a tuner the admin could use 
instead of trying to guess what the priority of program response and i/o 
response should be. So if I have a graphics program which might open an 
image (small file) and decompress it into 1500MB of raw image, I can set 
  the buffer space down to a GB or so (I assume that I do this on a 
machine fitted to such use) and get good response.

And even on a small machine with only 256MB or so, not having the 
overnight file check push all but the last 10-12MB of programs out of 
memory. That's the problem with the current system. As for hurting other 
systems, that's why a tuner would be nice.

With various patches things are getting better, don't think it isn't 
noticed and appreciated.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
