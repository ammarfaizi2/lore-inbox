Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWCWI6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWCWI6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWCWI6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:58:11 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:30083 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932580AbWCWI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:58:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vNsz5Qs19+ZKOUYtfU7fWi91GgBS+DUCKw1KJ6LBCkThtwQnPSzp5Cw7S1326UEcjTnVN/IqNMG9HLbhQUyzauKYdevLrZ8Xes3tJ7tvAJbJ+LMH/SSroUVtWh81i3thiu9Bh6QhIQHI2c2y/D7YxZpBTDIray9AikRV2ONbg4E=  ;
Message-ID: <44225AB4.4080503@yahoo.com.au>
Date: Thu, 23 Mar 2006 19:22:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: jos poortvliet <jos@mijnkamer.nl>
CC: ck@vds.kolivas.org, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org> <200603230901.57052.jos@mijnkamer.nl>
In-Reply-To: <200603230901.57052.jos@mijnkamer.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jos poortvliet wrote:
> Op donderdag 23 maart 2006 08:04, schreef Con Kolivas:
> 
>>On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
>>
>>>A look at the -mm lineup for 2.6.17:
>>>
>>>mm-implement-swap-prefetching.patch
>>>mm-implement-swap-prefetching-fix.patch
>>>mm-implement-swap-prefetching-tweaks.patch
>>>
>>>  Still don't have a compelling argument for this, IMO.
> 
> 
> well, the reason i use it is my computer is much more reactive in the morning. 
> linux uses to get very slow after a night of not-doing-much except some 
> 'sleep 5h && blabla' and cron stuff. in the morning it takes a few HOURS to 
> get up and running smoothly. with swap prefetch, it actually feels faster 
> compared to a fresh boot. now you can force swap prefetch to start working, i 
> use it now and then after some heavy taskts which pulled everything to swap.
> 

I have two issues with this argument (not that I'm trying to say it
couldn't make a difference in your case).

Firstly, swap prefetch actually doesn't handle the midnight updatedb pageout
problem nicely. It doesn't do any prefetching when the pagecache/vfs cache
fills memory (which is what would have to happen for updatedb to push stuff
into swap).

Secondly, with or without swap prefetch, I think we can do a better job of
handling these use-once patterns to begin with.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
