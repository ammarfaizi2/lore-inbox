Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbTCaVyv>; Mon, 31 Mar 2003 16:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTCaVyv>; Mon, 31 Mar 2003 16:54:51 -0500
Received: from dyn-ctb-210-9-246-105.webone.com.au ([210.9.246.105]:8964 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261863AbTCaVyu>;
	Mon, 31 Mar 2003 16:54:50 -0500
Message-ID: <3E88BAF9.8040100@cyberone.com.au>
Date: Tue, 01 Apr 2003 08:02:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: erik@hensema.net, linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <20030328231248.GH5147@zaurus.ucw.cz> <slrnb8gbfp.1d6.erik@bender.home.hensema.net> <3E8845A8.20107@aitel.hist.no>
In-Reply-To: <3E8845A8.20107@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Erik Hensema wrote:
> [...]
>
>> Helge Hafting already pointed out that writing out the data earlier 
>> isn't
>> desirable. The problem isn't in the waiting: the problem is in the 
>> writing.
>> I think the current kernel tries to write too much data too fast when
>> there's absolutely no reason to do so. It should probably gently 
>> write out
>> small amounts of data until there is a more pressing need for memory.
>>
> I don't think the problem is "writing a large chunk", rather that this
> chunk is scheduled for writing a bit too late.  Memory is filling up
> and the process producing data us throttled while waiting for
> the write to free up pages.  Then the "huge chunk" of pages is released,
> and memory is allowed to fill up for too long again.
>
> Seem to me the correct solution is to start writing out
> things long before memory gets so full that we need to
> throttle the producer. 

I haven't thought about this much, but it seems to me that
doing writeout whenever the disk would otherwise be idle
(and we have dirty memory to write out) would be a good
solution.

