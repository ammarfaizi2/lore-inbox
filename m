Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbWLLBPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWLLBPd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWLLBPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:15:33 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31168 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbWLLBPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:15:32 -0500
Message-ID: <457E02B3.3000302@mvista.com>
Date: Mon, 11 Dec 2006 17:15:31 -0800
From: Joe Green <jgreen@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dsingleton@mvista.com
Subject: Re: new procfs memory analysis feature
References: <787b0d920612110013w755996f8xf9bea48e900e304@mail.gmail.com>
In-Reply-To: <787b0d920612110013w755996f8xf9bea48e900e304@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> David Singleton writes:
>
>> Add variation of /proc/PID/smaps called /proc/PID/pagemaps.
>> Shows reference counts for individual pages instead of aggregate totals.
>> Allows more detailed memory usage information for memory analysis tools.
>> An example of the output shows the shared text VMA for ld.so and
>> the share depths of the pages in the VMA.
>>
>> a7f4b000-a7f65000 r-xp 00000000 00:0d 19185826   /lib/ld-2.5.90.so
>>  11 11 11 11 11 11 11 11 11 13 13 13 13 13 13 13 8 8 8 13 13 13 13 13 
>> 13 13
>
> Arrrgh! Not another ghastly maps file!
>
> Now we have /proc/*/smaps, which should make decent programmers cry.

Yes, that's what we based this implementation on.  :)

> Along the way, nobody bothered to add support for describing the
> page size (IMHO your format ***severely*** needs this)

Since the map size and an entry for each page is given, it's possible to 
figure out the page size, assuming each map uses only a single page 
size.  But adding the page size would be reasonable.

> There can be a million pages in a mapping for a 32-bit process.
> If my guess (since you too failed to document your format) is right,
> you propose to have one decimal value per page.

Yes, that's right.  We considered using repeat counts for sequences 
pages with the same reference count (quite common), but it hasn't been 
necessary in our application (see below).

> In other words, the lines of this file can be megabytes long without 
> even getting
> to the issue of 64-bit hardware. This is no text file!
>
> How about a proper system call?

Our use for this is to optimize memory usage on very small embedded 
systems, so the number of pages hasn't been a problem.

For the same reason, not needing a special program on the target system 
to read the data is an advantage, because each extra program needed adds 
to the footprint problem.

The data is taken off the target and interpreted on another system, 
which often is of a different architecture, so the portable text format 
is useful also.

This isn't mean to say your arguments aren't important, I'm just 
explaining why this implementation is useful for us.


-- 
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

