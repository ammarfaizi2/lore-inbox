Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVAYFOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVAYFOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVAYFOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:14:50 -0500
Received: from mail.joq.us ([67.65.12.105]:8620 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261819AbVAYFOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:14:41 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 24 Jan 2005 23:16:17 -0600
Message-ID: <87u0p6t7fi.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>>   First, only SCHED_FIFO worked reliably in my tests.  In Con's tests
>>   even that did not work.  My system is probably better tuned for low
>>   latency than his.  Until we can determine why there were so many
>>   xruns, it is premature to declare victory for either scheduler.
>>   Preferably, we should compare them on a well-tuned low-latency
>>   system running your Realtime Preemption kernel.
>
> i didnt declare victory - the full range of latency fixes is in the -RT
> tree. Merging of relevant bits is an ongoing process - in 2.6.10 you've
> already seen some early results, but it's by no means complete. 

I didn't mean to insult you, Ingo.  

I have nothing but praise for what you've accomplished with 2.6.10.
My tests yesterday demonstrated slightly better SCHED_FIFO performance
with 2.6.10 than 2.4.19 with Andrew's low-latency patches.  For a
mainstream kernel that is a huge accomplishment, never before
achieved.  We should celebrate.

I was just pointing out that saying nice(-20) works as well as
SCHED_ISO, though true, doesn't mean much since neither of them
(currently) work well enough to be useful.

>>   Second, the nice(-20) scheduler provides no clear way to support
>>   multiple realtime priorities. [...]
>
> why? You could use e.g. nice -20, -19 and -18. (see the patch below that
> implements this.)

Which of the the POSIX 1-99 range do you map into those three
priorities?  (I can't figure it out from the patch.)

How does one go about deciding which priority differences "matter" and
which do not?  Why not honor the realtime programmer's choice of
priorities?

For good reasons, most audio developers prefer the POSIX realtime
interfaces.  They are far from perfect, but remain the only workable,
portable solution available.  That is why I like your rt_cpu_limit
proposal so much better that this one.
-- 
  joq
