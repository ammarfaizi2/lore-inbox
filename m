Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVHXAEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVHXAEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHXAEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:04:36 -0400
Received: from mail-res.bigfish.com ([63.161.60.61]:38235 "EHLO
	mail46-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932499AbVHXAEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:04:36 -0400
X-BigFish: V
Message-ID: <430BB991.9010204@am.sony.com>
Date: Tue, 23 Aug 2005 17:04:33 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
References: <20050821110127.3b601268.akpm@osdl.org>
In-Reply-To: <20050821110127.3b601268.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>What about just using jiffies, then?
>>
>>Really, sched_clock() is very broken for this (I know you're
>>not arguing against that).
>>
>>It can go backwards when called twice from the same CPU, and the
>>number returned by one CPU need have no correlation with that
>>returned by another.
> 
> jiffies wouldn't have sufficient resolution for this application.  Bear
> in
> mind that this is just a debugging thing - it's better to have good
> resolution with occasional theoretical weirdness than to have poor
> resolution plus super-consistency, IMO.

Andrew's assessment is correct for my usage.

I use this for detailed info on bootup times, for tuning embedded
configurations.  Someone has already noted that the current code
truncates the value to microseconds (so a nanosecond-capable clock
interface is overkill for the current code).  Microseconds seems
to be a pretty useful precision for the work I'm doing.

Note that on many embedded platforms, a jiffy is 10 milliseconds,
which is far too low resolution for my purposes.  Also, not
to be totally egocentric, but most embedded platforms don't
have SMP (currently), so the SMP weirdness has never bothered
me. Even on SMP systems, the bootup code, which is what
I'm measuring, is mostly UP.

Just my 2 cents.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

