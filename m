Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280088AbRKLJfm>; Mon, 12 Nov 2001 04:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281368AbRKLJfc>; Mon, 12 Nov 2001 04:35:32 -0500
Received: from sun.fadata.bg ([80.72.64.67]:5898 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S280088AbRKLJfX>;
	Mon, 12 Nov 2001 04:35:23 -0500
To: Mathijs Mohlmann <mathijs@webflex.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
In-Reply-To: <XFMail.20011112101120.mathijs@webflex.nl>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <XFMail.20011112101120.mathijs@webflex.nl>
Date: 12 Nov 2001 11:41:05 +0200
Message-ID: <87d72ojphq.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mathijs" == Mathijs Mohlmann <mathijs@webflex.nl> writes:

Mathijs> On 12-Nov-2001 Momchil Velikov wrote:
>> In this patch, the first thing is to deschedule the tasklet. So,
>> the changes to interrupt.h are needed in order to put back the
>> tasklet in the queue.
Mathijs> I know, but Andrea suggested not to allow scheduling of
Mathijs> disabled tasklets Also, enableing the tasklet will result in

Disabled tasklets are not scheduled by enable_tasklet (). A disabled
tasklet may temporarily appear in the queue, but nevertheless
tasklet_action will remove it. It seems gross to traverse the list in
order to remove a tasklet at the first disable.

Mathijs> a scheduled tasklet, regardless whether it was
Mathijs> scheduled.

Hmm, if it isn't scheduled, there is not much sense in disabling it at
all.

Mathijs> Plus, we are not sure if it is scheduled on the
Mathijs> same cpu that did the tasklet_schedule (but i might be the
Mathijs> only one who cares about this ;)

Mathijs> thisone we should add some comments to interrupt.h warning
Mathijs> about deadlocks etc.
>> What deadlocks ? ;)
Mathijs> well, loops. Dont use tasklet_kill on disabled tasklet or on
Mathijs> not scheduled tasklets.

Hmm, if TASKLET_STATE_SCHED is not set tasklet_kill will not deadlock.
And tasklet_kill yields (?). Doesn't that mean that tasklet_action
will be called eventually ?

Regards,
-velco



