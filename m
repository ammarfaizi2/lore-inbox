Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTLWKRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbTLWKRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 05:17:25 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:9607 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265083AbTLWKRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 05:17:24 -0500
Message-ID: <3FE81563.7040505@cyberone.com.au>
Date: Tue, 23 Dec 2003 21:13:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <7F740D512C7C1046AB53446D372001736187E6@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D372001736187E6@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:

>BTW, Nick, does your SMT scheduler have "idle package prioritization"
>which chooses an idle logical processor with the other local processor
>idle if any (rather than just an idle processor with other local
>processor running at full speed), when the scheduler requires an idle
>local processor? That would prevent situations like two logical
>processors run at full speed in the same processor package, with the
>other processor package(s) idle in a same processor package(s). I
>haven't reviewed your latest patch closely, and that is the one of the
>things I want to do during the holidays.
>

Yep,
sched_balance_wake wakes to idle siblings if your domain has SD_FLAG_WAKE
and idle_balance tries pulling tasks from any domain with SD_FLAG_NEWIDLE
set if we're just about to become idle.

>
>One question. Why did you remove SD_FLAG_IDLE flag from cpu_domain
>initialization in the w27 patch? We've been seeing some performance
>degradation with w27, compared to w26.
>

I reworked things to not require this hopefully. w26 was quite broken
with respect to the active balancing stuff. One thing I did in w27 was
accidently release the code with cache_hot_time for the SMT domain set
to 1ms instead of 0 in w26, so SD_FLAG_NEWIDLE is sometimes not allowed
to pull a ready-to-run task off a sibling...

I haven't been able to do a great deal of performance tuning though,
there is probably quite a bit of room for improvement.


