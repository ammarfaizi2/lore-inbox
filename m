Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWHPGPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWHPGPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWHPGPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:15:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38787 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750931AbWHPGPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:15:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 2/7] pid: Add do_each_pid_task
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<11556661923847-git-send-email-ebiederm@xmission.com>
	<20060816031043.GE15241@sergelap.austin.ibm.com>
	<20060815212847.6f88e63a.akpm@osdl.org>
Date: Wed, 16 Aug 2006 00:15:04 -0600
In-Reply-To: <20060815212847.6f88e63a.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 15 Aug 2006 21:28:47 -0700")
Message-ID: <m18xlp6wbb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 15 Aug 2006 22:10:43 -0500
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
>
>> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> > To avoid pid rollover confusion the kernel needs to work with
>> > struct pid * instead of pid_t.  Currently there is not an iterator
>> > that walks through all of the tasks of a given pid type starting
>> > with a struct pid.  This prevents us replacing some pid_t instances
>> > with struct pid.  So this patch adds do_each_pid_task which walks
>> > through the set of task for a given pid type starting with a struct pid.
>> > 
>> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> > ---
>> >  include/linux/pid.h |   13 +++++++++++++
>> >  1 files changed, 13 insertions(+), 0 deletions(-)
>> > 
>> > diff --git a/include/linux/pid.h b/include/linux/pid.h
>> > index 93da7e2..4007114 100644
>> > --- a/include/linux/pid.h
>> > +++ b/include/linux/pid.h
>> > @@ -118,4 +118,17 @@ #define while_each_task_pid(who, type, t
>> >  				1; }) );				\
>> >  	}
>> >  
>> > +#define do_each_pid_task(pid, type, task)				\
>> 
>> Hmm, defining do_each_pid_task right after do_each_task_pid could result
>> in some frustration  :)
>
> That's all right - developers can read the comments to work out what each
> one does.
>
> <seems I'm having a sarcastic day>

The plan is to that having both of them in the same kernel should
be a short lived thing.  There are few enough of these perhaps I should
just replace all of them at once.

Doing this gradually and reviewably seems to require that I have
both versions of the API simultaneously.  The core problem here
is that there aren't many good names.

Eric
