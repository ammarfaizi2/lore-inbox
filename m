Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbRF0VWy>; Wed, 27 Jun 2001 17:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265410AbRF0VWo>; Wed, 27 Jun 2001 17:22:44 -0400
Received: from colorfullife.com ([216.156.138.34]:22794 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S265409AbRF0VWg>;
	Wed, 27 Jun 2001 17:22:36 -0400
Message-ID: <3B3A4E8B.E4301909@colorfullife.com>
Date: Wed, 27 Jun 2001 23:22:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Scott Long <scott@swiftview.com>, linux-kernel@vger.kernel.org
Subject: Re: wake_up vs. wake_up_sync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having trouble understanding the difference between these.
> Synchronous apparently causes try_to_wake_up() to NOT call
> reschedule_idle() but I'm uncertain what reschedule_idle() is doing. I
> assume it just looks for an idle CPU and makes that CPU reschedule.
> 
> What is the purpose of wake_up_sync?

Avoid the reschedule_idle() call - it's quite costly, and it could cause
processes jumping from one cpu to another.

> Why would you want to prevent
> reschedule_idle()?
> 
If one process runs, wakes up another process and _knows_ that it's
going to sleep immediately after the wake_up it doesn't need the
reschedule_idle: the current cpu will be idle soon, the scheduler
doesn't need to find another cpu for the woken up thread.

I think the pipe code is the only user of _sync right now - pipes cause
an incredible amount of task switches.

--
	Manfred
