Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUHQE6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUHQE6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUHQE6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:58:39 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:24689 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262450AbUHQE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:58:35 -0400
Message-ID: <41219076.6090602@yahoo.com.au>
Date: Tue, 17 Aug 2004 14:58:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408161852.50310.gene.heskett@verizon.net> <20040816230154.GM12308@parcelfarce.linux.theplanet.co.uk> <200408170044.37750.gene.heskett@verizon.net>
In-Reply-To: <200408170044.37750.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Monday 16 August 2004 19:01, viro@parcelfarce.linux.theplanet.co.uk wrote:
>
>>On Mon, Aug 16, 2004 at 06:52:50PM -0400, Gene Heskett wrote:
>>
>>>Well, I am seing some dups, but they are so volatile that no two
>>>runs will report the same allocations as dups, and its never more
>>>than 2 using /proc/fs/ext3 | sort | uniq -c | sort -nr |grep -v '
>>>1 '
>>>
>>>Consecutive runs will show anywhere from 3 to 10 or 12 dups, but
>>>never is an address repeated between runs.
>>>
>>>How is this to be interpreted?
>>>
>>That's OK.  Keep in mind that you have a *lot* of these guys and
>>your cat(1) makes a lot of read(2) calls.  So what you see is
>>
>><starting to read>
>><see inode #n that is about to be evicted>
>><read some more>
>><inode #n gets evicted, quite possibly - due to memory pressure from
>>cat(1) or sort(1)>
>><read more>
>><somebody wants the same inode again>
>><read more>
>><see the inode #n we'd just had read from disk again>
>>
>>So few duplicates are all right.
>>
>
>I hope so.  I've got a real hoodoozy here, being out of memory (well,
>maybe 30 megs left) when my nightly run of rsync started, everything
>came to a grinding halt.  I couldn't even get to the screen the 
>tail -f on the log was running in, but after walking away for 10 minutes. 
>I can once again.  However, things seem to be partially functional so 
>I'm going to see if I can do some cut-n-paste from the log screen to 
>here, but I probably can't send it as sendmail was one of the items the 
>OOM killer killed.  According to top, I'm about 250 megs into the 
>swap, very suddenly.  No swap was in use at 23:55 local.
>
>
snip

>
>I cannot start any new shells, as before.  Is there any usable dna in this sample?                                                                                       
>
>Reboot time I guess :(((
>
>

All your low memory has been used by dentry and inode caches. This isn't 
very
interesting because this would be no doubt caused by something oopsing while
holding the shrinker semaphore as Andrew pointed out.

What is interesting is that first Oops message (I wonder if you don't have
bad hardware though, I don't think anyone else is seeing it).

