Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVALDUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVALDUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 22:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVALDUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 22:20:33 -0500
Received: from mail.joq.us ([67.65.12.105]:38311 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261276AbVALDUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 22:20:25 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 21:21:48 -0600
In-Reply-To: <20050111212719.GA23477@elte.hu> (Ingo Molnar's message of
 "Tue, 11 Jan 2005 22:27:19 +0100")
Message-ID: <87sm57qqlv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Chris Wright <chrisw@osdl.org> wrote:
>
>> Hmm, I wonder if this could have anything to do with it.  These are
>> within striking range:
>> 
>>   PID COMMAND          NI PRI
>>     9 events/1        -10  34
>>   931 kcryptd/1       -10  33
>>   930 kcryptd/0       -10  34
>>     8 events/0        -10  34
>>   892 ata/1           -10  34
>>   891 ata/0           -10  34
>>  3747 udevd           -10  33
>>    26 kacpid          -10  31
>>   238 aio/1           -10  34
>>   237 aio/0           -10  31
>>   117 kblockd/1       -10  34
>>   116 kblockd/0       -10  34
>>    10 khelper         -10  34
>
> you are right, i forgot about kernel threads. If they are nice -10 on
> Jack's system too then they are within striking range indeed, especially
> since they are typically idle and if then they are active for short
> bursts of time and get the maximum boost. Jack, could you renice these
> to -5, to make sure they dont interfere?

Sure.  My system does have some of these running at nice -10.  Where
(how) do I change them?

BTW, let's not lose sight of the fact that `nice --20 foo' requires
CAP_SYS_NICE just like SCHED_FIFO does.  From a privilege perspective,
this recurses to the same (still unsolved) problem.  

Chris's rlimits proposal was the only workable suggestion I've seen
for that.  Is there any hope of doing something like that in the 2.6.x
timeframe?  

At this point, I no longer even care that PAM will probably start
randomly assigning users unlimited scheduling rights like it recently
did for mlock.  Eventually, that will get fixed.  :-(
-- 
  joq
