Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVAOJhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVAOJhH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 04:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVAOJhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 04:37:07 -0500
Received: from holomorphy.com ([66.93.40.71]:8868 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262247AbVAOJhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 04:37:02 -0500
Date: Sat, 15 Jan 2005 01:36:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: matthias@corelatus.se, linux-kernel@vger.kernel.org
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
Message-ID: <20050115093657.GI3474@holomorphy.com>
References: <16872.55357.771948.196757@antilipe.corelatus.se> <20050115013013.1b3af366.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115013013.1b3af366.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Lang <matthias@corelatus.se> wrote:
>> The linux implementation of setitimer() doesn't behave quite as
>>  expected. I found several problems:
>>    1. POSIX says that negative times should cause setitimer() to 
>>       return -1 and set errno to EINVAL. In linux, the call succeeds.
>>    2. POSIX says that time values with usec >= 1000000 should
>>       cause the same behaviour. In linux, the call succeeds.
>>    3. If large time values are given, linux quietly truncates them
>>       to the maximum time representable in jiffies. On 2.4.4 on PPC,
>>       that's about 248 days. On 2.6.10 on x86, that's about 24 days.
>>       POSIX doesn't really say what to do in this case, but looking at
>>       established practice, i.e. "what BSD does", since the call comes 
>>       from BSD, *BSD returns -1 if the time is out of range.

On Sat, Jan 15, 2005 at 01:30:13AM -0800, Andrew Morton wrote:
> These are things we probably cannot change now.  All three are arguably
> sensible behaviour and do satisfy the principle of least surprise.  So
> there may be apps out there which will break if we "fix" these things.
> If the kernel version was 2.7.0 then well maybe...

We can easily do a "rolling upgrade" by adding new versions of the
system calls, giving glibc and apps grace periods to adjust to them,
and nuking the old versions in a few years.


-- wli
