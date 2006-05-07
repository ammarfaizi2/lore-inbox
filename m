Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWEGNfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWEGNfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWEGNfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:35:52 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:10837 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932162AbWEGNfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:35:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vPXFqAA1uvxTAfgXqtYTpSBczUqlnkTvuNMOhaesYVqjoTqjQ+bEvIixB7LG8twQlA7k35MuQIHwri+Dg/EhUiyFhT2SWeNGzg5k5ZW1Fy3FTyImlbYQj+i3frYNCvKfrk7INLQeonjlmskTGnAbCjYKN3kzAYRTTeZaTljh1WE=  ;
Message-ID: <445DF667.309@yahoo.com.au>
Date: Sun, 07 May 2006 23:30:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au> <20060507124307.GA20443@flint.arm.linux.org.uk> <445DEE70.10807@yahoo.com.au> <445DEF6D.1050902@yahoo.com.au> <20060507131825.GC20443@flint.arm.linux.org.uk>
In-Reply-To: <20060507131825.GC20443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, May 07, 2006 at 11:00:29PM +1000, Nick Piggin wrote:
> 
>>Nick Piggin wrote:
>>
>>
>>>I stand by my first reply to your comment WRT the API.
>>
>>Actually, on rereading, it seems like I was a bit confused about
>>your proposal. I don't think you specified anyway the units
>>returned by your new sched_clock(). So it is identical to my
>>"corrected" interface :\
> 
> 
> Okay, so that presumably means we have to either stick with what we
> currently have, or go the whole hog and re-implement the sched_clock()
> support?
> 
> IOW, my patch on 2nd May isn't of any use as it currently stands?

IMO it would probably be best to try to re implement it in one go.
It shouldn't have spread too far out of kernel/sched.c, and the arch
code should mostly be implementable in terms of their sched_clock().
Mundane but not difficult.

Making arch code actually try to do the right thing may require a
bit more thinking, to handle both the variable time counter issue
and your time counter wrap problem. That wouldn't be your problem
though, outside arch/arm/

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
