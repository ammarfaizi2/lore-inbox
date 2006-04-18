Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWDRRdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDRRdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWDRRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:33:03 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:63726 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932152AbWDRRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:33:02 -0400
Subject: Re: Question on Schedule and Preemption
From: Steven Rostedt <rostedt@goodmis.org>
To: Liu haixiang <liu.haixiang@gmail.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <bf3792800604181021y4d985dedk19c7d94707c0cd8d@mail.gmail.com>
References: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
	 <20060418091724.GA7258@rhlx01.fht-esslingen.de>
	 <bf3792800604180555n6569a355tc55e850064ea1551@mail.gmail.com>
	 <1145372205.17085.123.camel@localhost.localdomain>
	 <bf3792800604181021y4d985dedk19c7d94707c0cd8d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 13:32:56 -0400
Message-Id: <1145381576.17085.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 01:21 +0800, Liu haixiang wrote:
> 2006/4/18, Steven Rostedt <rostedt@xxxxxx.com>:

Damn! I used my work email account to send that. I try to keep the spam
down on that account, so I don't publish it as much. Darn Evolution
keeps picking the wrong account.

> > On Tue, 2006-04-18 at 20:55 +0800, Liu haixiang wrote:
> >
> > Well according to your output, it was the task "TURNER0" with the pid
> > 611.  After you recompile the kernel with CONFIG_FRAME_POINTERS you will
> > need to follow the stack trace and see what function turned off
> > preemption.  This can happen calling a spin_lock and not unlocking it
> > before calling something that would schedule.
> >
> 
> If it's true, it is a great help for me.
> 
> > If you also turn on in "Kernel Hacking" -> "Compile the kernel with
> > debug info", you can then do a "gdb vmlinux" in the root directory of
> > the compile, and pass in the stack address with the command
> > "li *0xc042382e" to show where that function would return. (replace the
> > c042382e with the location you are looking for).
> >
> > Also, what arch are you using to get a 0x04000000 in the preempt_count
> > (the 0x1 is the depth). Of course I'm looking at 2.6.17-rc1 and not the
> > one you are using.  Hmm, your arch may not even support frame pointers.
> >
> > -- Steve
> >
> 
> The arch is SH4.

Well I just tried a "make ARCH=sh menuconfig" and the
CONFIG_FRAME_POINTERS option is there.  Whether it makes a difference or
not, I haven't the foggiest clue.

-- Steve


