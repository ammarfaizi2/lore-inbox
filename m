Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWIDJvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWIDJvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWIDJvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:51:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:59556 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751291AbWIDJuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:50:44 -0400
Message-ID: <44FBF62A.1010900@aitel.hist.no>
Date: Mon, 04 Sep 2006 11:47:22 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru>
In-Reply-To: <44FBD08A.1080600@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Marc Perkel wrote:
>   
>> If I have two drives and I want swap to be fast if I allocate swap spam
>> on both drives does it break up the load between them? Or would it run
>> faster if I did a Raid 0 swap?
>>     
>
> Don't do that - swap on raid0.  Don't do that.  Unless you don't care
> about your data, ofcourse.  Seriously.
>
> If something with swap space goes wrong, God only knows what will break.
> It is trivial to break userspace data this way, when an app is swapped
> out and there's an error reading it from swap, its data file very likely
> to be corrupt, especially when it is interrupted during file update.
> It is probably possible to corrupt the whole filesystem this way too,
> when some kernel memory has been swapped out and is needed to write some
> parts of filesystem, but it can't be read back.
>   
I thought kernel data weren't swapped at all?
Mostly because kernel data could be needed immediately, with
no option of waiting for swapin. 
So, bad swap should only really kill userspace programs,
although it probably can cause some bad delays in cases
where the userspace program calls into the kernel,
passing an address that happens to be in damaged swap.
You might then stall the kernel holding some resources
while the disks retries umpteen times.
> Ie, your swap space must be reliable.  At least not worse than your memory.
> And with striping, you've much more chances of disk failure...
>   
> Yes it sounds very promising at first, to let kernel stripe swap space,
> for faster operations.  But hell, first, try to avoid swappnig in the
> first place, by installing appropriate amount memory which is cheap
> nowadays, so there will be just no need for swapping.  And when it's
> done, it's not relevant anymore whenever your swap space is fast or
> not.  But make it *reliable*.
>   
Some swap is nice to have.  "Ouch - sluggish server today,
I will have to look into it" is so much better
than "Eww - the OOM serial killer took out another 5 processes,
people are screaming!"

As for reliable swap - swap on raid-1 is nice - and it
probably perform better than single-disk swap too,
although not as fast as striped swap.

Helge Hafting



-- 
VGER BF report: U 0.498988
