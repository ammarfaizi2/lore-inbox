Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422964AbWHZKto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422964AbWHZKto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 06:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWHZKto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 06:49:44 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:21455
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1422964AbWHZKtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 06:49:43 -0400
Date: Sat, 26 Aug 2006 03:49:23 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060826104923.GA7879@gnuppy.monkey.org>
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
> Is there anything else you want me to try: I can probably wave a
> chicken over the machine or get some black candles or something?

Stop using icecream or anything that might to any kind of binary object
caching or header analysis to minimize compiles during the build. Make sure
you're really cleaning the entire kernel directory before each build. Make
sure it'a full build for starters.

Throw a #error in the __put_task_struct_inline(), not the alternative
__put_task_struct(). It should bark at compile time and fail to compile
kernel/fork.c

The function __put_task_struct() should never show up a stack trace
EVER. That function has been rename under all things CONFIG_PREEMPT_RT
under my addendum patches. That's why I'm starting to think it's your
build environment or you're miss applying the patches.

bill

