Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWIDK3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWIDK3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWIDK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:29:22 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:52318 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751372AbWIDK3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:29:22 -0400
Message-ID: <44FBFFFC.90309@tls.msk.ru>
Date: Mon, 04 Sep 2006 14:29:16 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru> <44FBF62A.1010900@aitel.hist.no>
In-Reply-To: <44FBF62A.1010900@aitel.hist.no>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Michael Tokarev wrote:
[]
>> If something with swap space goes wrong, God only knows what will break.
>> It is trivial to break userspace data this way, when an app is swapped
>> out and there's an error reading it from swap, its data file very likely
>> to be corrupt, especially when it is interrupted during file update.
>> It is probably possible to corrupt the whole filesystem this way too,
>> when some kernel memory has been swapped out and is needed to write some
>> parts of filesystem, but it can't be read back.
>>   
> I thought kernel data weren't swapped at all?
> Mostly because kernel data could be needed immediately, with
> no option of waiting for swapin. So, bad swap should only really kill
> userspace programs,
> although it probably can cause some bad delays in cases
> where the userspace program calls into the kernel,
> passing an address that happens to be in damaged swap.
> You might then stall the kernel holding some resources
> while the disks retries umpteen times.

Well, it's not that simple.  Kernel uses both swappable and
non-swappable memory internally.  For some things, it's
unswappable, for some, it's swappable.  In general, it's
impossible to say which parts of kernel will break (and
in wich ways) if swap goes havoc.

>> Ie, your swap space must be reliable.  At least not worse than your
>> memory.
>> And with striping, you've much more chances of disk failure...
>>   Yes it sounds very promising at first, to let kernel stripe swap space,
>> for faster operations.  But hell, first, try to avoid swappnig in the
>> first place, by installing appropriate amount memory which is cheap
>> nowadays, so there will be just no need for swapping.  And when it's
>> done, it's not relevant anymore whenever your swap space is fast or
>> not.  But make it *reliable*.
>>   
> Some swap is nice to have.  "Ouch - sluggish server today,
> I will have to look into it" is so much better
> than "Eww - the OOM serial killer took out another 5 processes,
> people are screaming!"

I didn't say "eliminate swap space", I said about trying to avoid
swap usage.  In the other words, DO set up swap space, and DO it
in a reliable way.  Not "swap isn't needed" - well yes, it's
not entirely clear from my statement.

> As for reliable swap - swap on raid-1 is nice - and it
> probably perform better than single-disk swap too,
> although not as fast as striped swap.

Yes it's slower.  But you don't really care, because in normal
life, there should be almost no swap usage.  When swapping starts
occuring in amounts where speed difference is noticeable, it's
time to add more memory (or to run less hungry processes),
not to speed up swap space.

/mjt

-- 
VGER BF report: H 0.182426
