Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265906AbUFDR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUFDR23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUFDR0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:26:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55427 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265892AbUFDRYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:24:08 -0400
Message-ID: <40C0B03F.40507@tmr.com>
Date: Fri, 04 Jun 2004 13:24:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Catalin BOIE <util@deuroconsult.ro>
CC: Con Kolivas <kernel@kolivas.org>, FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40BF3250.9040901@tmr.com> <Pine.LNX.4.60.0406041201230.25783@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.60.0406041201230.25783@hosting.rdsbv.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> Hello!
> 
>> But swap behaviour kills performance even when memory is more than 
>> adequate. Consider building a DVD image in a 4GB system. The i/o 
>> forces all of the unused programs out, in spite of the fact that an 
>> extra 100MB doesn't make a measurable difference in performance. But 
>> when I click Mozilla paging most of it in from disk make a big 
>> difference in performance to the user.
> 
> 
> I think that kernel cannot know that you need some data once or more.
> This is fadvise for.
> With my wrapper (http://kernel.umbrella.ro) for fadvise you can do this:
> NOCA_SIZE=128 NOCA_READ=1 NOCA_WRITE=1 NOCA_RA=1 \
>     noca mkisofs -R -o /tmp/1.iso /tmp/data
> 
> This means:
> NOCA_SIZE: Call fadvise only after 128KiB was read/wrote.
> NOCA_RA: call fadvise with POSIX_FADV_SEQUENTIAL
> NOCA_READ: use fadvise(POSIX_FADV_DONTNEED) for reads (because you don't 
> need anymore the source files)
> NOCA_WRITE: use fadvise(POSIX_FADV_DONTNEED) for writes (because it's 
> useless to cache the end of the ISO)
> 
> Do this program resolve your problem?

It addresses one of the cases which trigger problems, certainly. Thank you.
> 
>> The problems with small memory are different in kind, when not even 
>> the programs will fit in memory at the same time, or will leave next 
>> to nothing for i/o, swap is required for performance. But on a large 
>> memory system I believe the gain to pain ratio is way too low with the 
>> current VM. The solution at the moment is to turn off swap, which as 
>> you note has other problems (can't move between zones without swap?) 
>> which in theory could really hang a system.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
