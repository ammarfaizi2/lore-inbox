Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVATFyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVATFyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 00:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVATFyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 00:54:50 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:15006 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262055AbVATFyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 00:54:45 -0500
Message-ID: <41EF47D8.7070303@kolivas.org>
Date: Thu, 20 Jan 2005 16:55:36 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz lehmann <lkml@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft	rt	scheduling
References: <41EEE1B1.9080909@kolivas.org>	 <1106180177.4036.27.camel@segv.aura.of.mankind>	 <41EEFC4F.1090704@kolivas.org> <1106195201.4180.23.camel@segv.aura.of.mankind>
In-Reply-To: <1106195201.4180.23.camel@segv.aura.of.mankind>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

utz lehmann wrote:
> I had experimented with throttling runaway RT tasks. I use a similar
> accounting. I saw a difference between counting with or without the
> calling from fork. If i remember correctly the timeout expired too fast
> if the non-RT load was "while /bin/true; do :; done".
> With "while true; do :; done" ("true" is bash buildin) it worked good.
> But maybe it's not important in the real world.

It won't be relevant if we move to a sched_clock() based timesource 
anyway, which looks to be the next major development for this.

> If i understand sched_clock correctly it only has higher resolution if
> you can use tsc. In the non tsc case it's jiffies based. (On x86).
> I think you can easily fool a timer tick/jiffies based accounting and do
> a local DoS.

The same timer is used for accounting of SCHED_NORMAL tasks, so if you 
can work around that you can DoS the system with even the correct 
combination of SCHED_NORMAL tasks. When Ingo implemented sched_clock all 
the architectures slowly came on board. If I recall correctly the lowest 
resolution one still had microsecond accuracy which is more than enough 
given the time a context switch takes.

> Making SCHED_ISO privileged if you don't have a high resolution
> sched_clock is ugly.
> I really like the idea of a unprivileged SCHED_ISO but it has to be safe
> for a multi user system. And the kernel default should be safe for multi
> user.

Agreed; this is exactly what this work is about.

Cheers,
Con
