Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKWBhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKWBhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbUKWBha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:37:30 -0500
Received: from mail.timesys.com ([65.117.135.102]:31915 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261242AbUKWBg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:36:59 -0500
Message-ID: <41A293B4.8000002@timesys.com>
Date: Mon, 22 Nov 2004 20:34:44 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, john cooper <john.cooper@timesys.com>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <41A1F4B2.10401@timesys.com> <20041122213054.GB9058@nietzsche.lynx.com>
In-Reply-To: <20041122213054.GB9058@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2004 01:30:16.0859 (UTC) FILETIME=[FCB956B0:01C4D0FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Mon, Nov 22, 2004 at 09:16:18AM -0500, john cooper wrote:
> 
>>I'd hazard a guess the reason existing implementations do not
>>do this type of dependency-chain closure is the complexity of a
>>general approach.  Getting correct behavior and scaling on SMP
>>require some restrictions of how lock ownership is maintained,
>>otherwise fine grained locking is not possible.  Another likely
> 
> 
> What do you mean by that ? Are you talking about strict priority
> obedience by the system ?

Not quite if I understand your question.  I was referring to
avoiding having a global lock to synchronize the conglomerate
data structure when doing a PI dependency walk.  The problem
is the lock must be acquired not only in PI scenarios but in
any case which may possibly lead to one or affect a concurrent
PI in progress.

True this global lock is mostly an issue for large count
SMP systems.  But as witnessed by such voodoo[1] mechanisms
as rcu, scalability problems are real at that end of the
spectrum.

-john


[1] in a 'nice' way.


-- 
john.cooper@timesys.com
