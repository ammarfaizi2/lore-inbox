Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUBDJYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 04:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUBDJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 04:24:24 -0500
Received: from gw-nl6.philips.com ([161.85.127.52]:4833 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S263792AbUBDJYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 04:24:22 -0500
Message-ID: <4020BA67.9020604@basmevissen.nl>
Date: Wed, 04 Feb 2004 10:24:55 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org>
In-Reply-To: <20040129114400.GA27702@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
>
>>
>>sfhq:/mnt/data/1/lost+found# ls -l
>>total 76
>>d-wSr-----    2 1212680233 136929556    49152 Jun  7  2008 #16370
>>-rwx-wx---    1 1628702729 135220664    45056 May  4  1974 #16380
> 
> 
> Ok, this looks like random garbage has gotten written into inode table.
> 
> If you can make this happen consistently with 2.6 and not with 2.4,
> then that would be useful to know.  There may be some kind of race
> condition or problem with either the raid5 code, or the combination of
> raid5 plus ext3.  It's unlikely this kind of error would be caused by
> a flaw in the ext3 code alone, since this is indicative of complete
> garbage written to the inode table, or a block intended for another
> location on disk getting written to the inode table.  The natural
> suspect is at the block device layer and below.
> 

I've seen this kind of problems on my notebook too. Among others, over 
600MB of a huge cache directory (from a news reader) was having "funny" 
permissions. Maybe more files were affected. I used fsck.ext3 and 
changed the attributes with chmod.

It may be caused by crashes of the notebook (power failure and 
suspend/resume failure), but I would expect that the administration of 
the fs would survive that, as it did for years. Actually, the last time 
I had filesystem corruption was in kernel 1.2.xx days...

As my notebook is not using raid, I suspect something in the ext3 code. 
Kernel is 2.6.1 with ACPI, acpi-dsdt and swsusp2 patches.

Regards,

Bas.



