Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757216AbWLCBZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbWLCBZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 20:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbWLCBZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 20:25:52 -0500
Received: from mail.tmr.com ([64.65.253.246]:13746 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1757216AbWLCBZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 20:25:51 -0500
Message-ID: <45722858.30600@tmr.com>
Date: Sat, 02 Dec 2006 20:28:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 14/23] x86 microcode: dont check the size
References: <20061129220111.137430000@sous-sol.org> <20061129220524.148156000@sous-sol.org> <20061202064454.GE1736@1wt.eu>
In-Reply-To: <20061202064454.GE1736@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Shaohua,
> 
> this one seems appropriate for 2.4 too. It is OK for you if I merge it ?
> 
> Thanks,
> Willy
> 
> On Wed, Nov 29, 2006 at 02:00:25PM -0800, Chris Wright wrote:
>> -stable review patch.  If anyone has any objections, please let us know.
>> ------------------
>>
>> From: Shaohua Li <shaohua.li@intel.com>
>>
>> IA32 manual says if micorcode update's size is 0, then the size is
>> default size (2048 bytes). But this doesn't suggest all microcode
>> update's size should be above 2048 bytes to me. We actually had a
>> microcode update whose size is 1024 bytes. The patch just removed the
>> check.

I agree with what you said, but unless I miss something, not what you 
did... I don't see the code to get the size and set it to 2k if it's 
zero. I would expect after the call to get_totalsize() that there would 
be a line like:
   if (unlikely(total_size == 0)) total_size = DEFAULT_UCODE_TOTALSIZE;
or some similar logic to do what the manual suggests, that zero is a 
valid value.

I may be totally misreading this, of course, I'm taking the manual quote 
as gospel.

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
