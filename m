Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVAKQl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVAKQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAKQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:41:26 -0500
Received: from mail.joq.us ([67.65.12.105]:54689 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262824AbVAKQ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:27:23 -0500
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501111305.j0BD58U2000483@localhost.localdomain>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 10:28:13 -0600
In-Reply-To: <200501111305.j0BD58U2000483@localhost.localdomain> (Paul
 Davis's message of "Tue, 11 Jan 2005 08:05:08 -0500")
Message-ID: <87oefw3p7m.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> writes:

>>Rlimits are neither UID/GID or PAM-specific. They fit well within
>>the general model of UNIX security, extending an existing mechanism
>>rather than adding a completely new one. That PAM happens to be the
>>way rlimits are usually administered may be unfortunate, yes, but it
>>doesn't mean that rlimits is the wrong way.

PAM is how most GNU/Linux systems manage rlimits.  It is very UID/GID
oriented.  So from the sysadmin perspective, claiming that rlimits is
"better" or "easier to manage" than "GID hacks" is bogus.

> agreed, although i note with interest the flap over RLIMIT_MEMLOCK
> being made accessible to unprivileged users by people working on
> grsecurity. 

:-)

>>Let's work on that. It'd be _far_ better to have unprivileged near-RT
>>capability everywhere without potential scheduling DoS.
>
> I am not sure what you mean here. I think we've established that
> SCHED_OTHER cannot be made adequate for realtime audio work. Its
> intended purpose (timesharing the machine in ways that should
> generally benefit tasks that don't do a lot and/or are dominated by
> user interaction, thus rendering the machine apparently responsive) is
> really at odds with what we need.
>
> Con has discussed the idea of a new scheduling class, one that has no
> internal priority, runs like SCHED_RR but is subject to cpu
> utilization limits, and is accessible to unprivileged users. I think
> this makes a lot of sense. It can be controlled using sysctl's and/or
> rlimit. 

A good isochronous scheduler in 2.8 would be great.  We can experiment
with it this year in patch form.  

Meanwhile...

> But please note: in any sane world, adding stuff like this could only
> take place in an unstable tree. It seems really odd to me that anyone
> can be talking about adding any of these *mechanisms* to 2.6. That was
> the whole reason we (well, Jack, Torben and others) worked with LSM:
> LSM appeared to be the "blessed" method in 2.6 of allowing changes to
> security policy to be made. We are now finding out that even if Linus
> "blessed" it by inclusion, there is enough vocal opposition to
> actually using it for something useful that something else has to be
> done. I wouldn't want to run an important machine on 2.6 if adding,
> say SCHED_ISO or even RLIMIT_RT_CPU is part of 2.6's "maintainance".
>
> Meanwhile, as I mentioned before, every realtime audio user of 2.6 is
> *still* going to use "realtime" LSM because its really the only
> effective way to get the privilege needed to do what they want to get
> done. 

I am surprised and dismayed by the ignorance of realtime programming
expressed by some (not all) messages in this thread.  Worse, many
developers seem unaware of how much they don't know.  This stuff is
difficult, even for smart people.  Maybe even "especially for smart
people".

I am very conscious of my own matching ignorance of Linux kernel
internals.  If possible, I'd like to keep it that way.    ;-) 

Kernel developers really don't have the equivalent luxury of ignoring
realtime design issues.
-- 
  joq
