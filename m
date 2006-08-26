Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWHZK2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWHZK2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 06:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZK2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 06:28:37 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:31369
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751108AbWHZK2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 06:28:37 -0400
Date: Sat, 26 Aug 2006 03:28:25 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060826102825.GA7769@gnuppy.monkey.org>
References: <20060822013722.GA628@gnuppy.monkey.org> <20060822232051.GA8991@gnuppy.monkey.org> <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com> <20060823202046.GA17267@gnuppy.monkey.org> <20060823210558.GA17606@gnuppy.monkey.org> <20060823210842.GB17606@gnuppy.monkey.org> <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com> <20060824014658.GB19314@gnuppy.monkey.org> <20060825071957.GA30720@gnuppy.monkey.org> <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 06:24:29PM -0700, Robert Crocombe wrote:
> On 8/25/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >        http://mmlinux.sourceforge.net/public/against-2.6.17-rt8-2.diff
> BUG: scheduling while atomic: make/0x00000001/14632
> 
> Call Trace:
>       <ffffffff802fbc2e>{plist_check_head+60}
>       <ffffffff8025d2eb>{__schedule+155}
>       <ffffffff8028f06a>{task_blocks_on_rt_mutex+643}
>       <ffffffff8020efda>{__mod_page_state_offset+25}
>       <ffffffff802871de>{find_task_by_pid_type+24}
>       <ffffffff8020efda>{__mod_page_state_offset+25}
>       <ffffffff8025dad7>{schedule+236}
>       <ffffffff8025e96d>{rt_lock_slowlock+416}
>       <ffffffff8025f4b8>{rt_lock+13}
>       <ffffffff8020efda>{__mod_page_state_offset+25}
>       <ffffffff8029ab91>{__free_pages_ok+336}
>       <ffffffff8022c07e>{__free_pages+47}
>       <ffffffff80233bb0>{free_pages+128}
>       <ffffffff802580df>{free_task+26}
>       <ffffffff80245b52>{__put_task_struct+182}
>       <ffffffff8025d86e>{thread_return+163}
>       <ffffffff8025dad7>{schedule+236}
>       <ffffffff80245ff1>{pipe_wait+111}
>       <ffffffff802893ac>{autoremove_wake_function+0}
>       <ffffffff8025e7c8>{rt_mutex_lock+50}
>       <ffffffff8022ce81>{pipe_readv+785}
>       <ffffffff8025eaa6>{rt_lock_slowunlock+98}
>       <ffffffff8025f4a9>{__lock_text_start+9}
>       <ffffffff802aea38>{pipe_read+30}
>       <ffffffff8020afae>{vfs_read+171}
>       <ffffffff8020fdbc>{sys_read+71}
>       <ffffffff8025994e>{system_call+126}
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<ffffffff8025d303>] .... __schedule+0xb3/0x57b
> .....[<ffffffff8025dad7>] ..   ( <= schedule+0xec/0x11a)

Things like this make me wonder if you're even appying the patch correctly.

The occurance of free_task() and friends should be completely gone. All
of those scheduling in atomics should be flat out kernel panics and the
kernel should immediately stop. I'll look at it again to see if missed a
compile options or something, but this is really odd cause it should stop
the kernel dead in its tracks.

bill

