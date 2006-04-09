Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWDIBve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWDIBve (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 21:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWDIBve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 21:51:34 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:42415 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965058AbWDIBve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 21:51:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Jnb9teLRmSKeKD40wUfSQ8EeROqk1hJ9kz3bgRtIh+Yeo2fBelIcVe4krrKDaq+S1f0ULzCrhF5CT50OHpvFfPTtEW8sYpGYLnRk7sZsBVen9Vvnq00a9d5C5UvJp/pyUTzoyeyxg/vfdeYDLPaZLIVCQQwcztSK/vZagCmqlnM=  ;
Message-ID: <443868A5.1020503@yahoo.com.au>
Date: Sun, 09 Apr 2006 11:51:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>, Fabio Comolli <fabio.comolli@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Userland swsusp failure (mm-related)
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604081716.31836.rjw@sisk.pl> <20060408161555.GA1722@elf.ucw.cz> <200604090047.17372.rjw@sisk.pl>
In-Reply-To: <200604090047.17372.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 

>>>Well, it looks like we didn't free enough RAM for suspend in this case.
>>>Unfortunately we were below the min watermark for ZONE_NORMAL and
>>>we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
>>>ZONE_DMA in this case?).
>>>
>>>I think we can safely ignore the watermarks in swsusp, so probably
>>>we can set PF_MEMALLOC for the current task temporarily and reset
>>>it when we have allocated memory.  Pavel, what do you think?
>>
>>Seems little hacky but okay to me.
>>
>>Should not fixing "how much to free" computation to free a bit more be
>>enough to handle this?
> 
> 
> Yes, but in that case we'll leave some memory unused. ;-)
> 

Probably doesn't fall back to ZONE_DMA because of lowmem reserve.
Yes, PF_MEMALLOC sounds like it might do what you want. A little
hackish perhaps, but better than putting swsusp special cases
into page_alloc.c.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
