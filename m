Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271032AbUJUXGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbUJUXGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271092AbUJUXFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:05:03 -0400
Received: from mail.timesys.com ([65.117.135.102]:40620 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S271032AbUJUW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:56:29 -0400
Message-ID: <41783E4A.5020902@timesys.com>
Date: Thu, 21 Oct 2004 18:55:06 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Wood <scott@timesys.com>
CC: "Eugeny S. Mints" <emints@ru.mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com> <20041021184742.GB26530@yoda.timesys> <41781984.5090602@timesys.com> <20041021211244.GA28290@yoda.timesys> <417834E4.7000506@timesys.com> <20041021223003.GA28704@yoda.timesys>
In-Reply-To: <20041021223003.GA28704@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 22:51:18.0375 (UTC) FILETIME=[7A202F70:01C4B7C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:

>On Thu, Oct 21, 2004 at 06:15:00PM -0400, john cooper wrote:
>
>>Yes, but my concern was having to backoff in out-of-sequence
>>spinlock acquisition paths. 
>>
>
>Out-of-sequence acquisition is a bug, unless the caller uses trylocks
>and handles backoff itself.
>
Understood -- we may be getting hung up on terminology here.

Rather the issue was whether the nondeterministic out-of-sequence
backoff could be pushed to a noncritical path. I believe so.
It is further likely a backoff would not be needed as the
a path acquiring a mutex's task-owned list lock during a
priority promotion scan shouldn't have reason to acquire any
task's mutex-owned list lock. The latter list would only need
to be locked at time of successful mutex acquisition/free.

-john

-- 
john.cooper@timesys.com

