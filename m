Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUKVOgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUKVOgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUKVOen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:34:43 -0500
Received: from mail.timesys.com ([65.117.135.102]:4229 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262112AbUKVOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:18:34 -0500
Message-ID: <41A1F4B2.10401@timesys.com>
Date: Mon, 22 Nov 2004 09:16:18 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, john cooper <john.cooper@timesys.com>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com>
In-Reply-To: <20041122092302.GA7210@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2004 14:11:54.0750 (UTC) FILETIME=[386061E0:01C4D09D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:

> IMO, their needs to be statistical code in the mutex itself so that it can
> measure the frequency of PI events as well as depth of the inheritance
> chains and all data structure traversals. The problem with writing that
> stuff now is that there isn't proper priority propagation through the entire
> dependency chain in any mutex code that I've publically seen yet.> Patching
> this instrumentation in a mutex require a mutex with this built in
> functionality. IMO, PI should be considered a kind of contention overload
> condition and really a kind of fallback device to deal with these kind
> of exceptional circumstances.

I'd hazard a guess the reason existing implementations do not
do this type of dependency-chain closure is the complexity of a
general approach.  Getting correct behavior and scaling on SMP
require some restrictions of how lock ownership is maintained,
otherwise fine grained locking is not possible.  Another likely
reason is the fact more mechanism is getting put in place for
less likely inversion scenarios.  And when those scenarios do
exist the cost of effecting promotion closure may well be
greater than allowing the priority inversions to subside.
However this point of diminishing returns is application
dependent so there is no single, simple solution.

That said I don't see anything in the current work which precludes
doing any of the above.  To my eyes, the groundwork is already
in place.

-john


-- 
john.cooper@timesys.com
