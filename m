Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbULFWip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbULFWip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbULFWip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:38:45 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:41411 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261684AbULFWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:38:36 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41B4DB1C.3060406@zytor.com>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <cp2i3h$hs0$1@terminus.zytor.com>
	 <1102370517.25841.216.camel@localhost.localdomain>
	 <41B4DB1C.3060406@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 06 Dec 2004 17:38:35 -0500
Message-Id: <1102372715.25841.227.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 14:20 -0800, H. Peter Anvin wrote:
> Steven Rostedt wrote:
> > 
> > I disagree about this statement.  ioctl's suck because they usually have
> > none, or very poor documentation and you are stuck with opening devices,
> > and sending parameters to them that may be for the wrong device and
> > there is really no good checking to see what you sent is what you want
> > since its all defined by human unreadable numbers.
> > 
> 
> That's like saying you might be calling the wrong syscall by accident.

It can be easier to send the wrong command to a device, or even the
wrong device than to use a wrong system call.  

You can do a mknod and use the wrong number, or have an outdated header
file, or wrong arch, and use the wrong command.  Usually either of these
will just break the application doing so, but still can be dangerous.

> > As for dynamic system calls (and especially the way I've implemented
> > them) you have human readable names, with varying amount of parameters
> > that can make sense. So even if you still have none to very poor
> > documentation, you can understand things perhaps a little better.  There
> > is also much better checking in dynamic system calls than to ioctls.
> 
> There is NO checking in the syscall interface.  Period.  Any such 
> checking is a facility of some kind of stub generator, and that's 
> independent of the method used to invoke it.

I'll grant you that there is a stub generator that facilitates this, but
the entire mechanism is still better than the ioctl interface, and it
does have some kind of checking.

To get a system call, you must first ask for it by name. This is where
ioctl and dynamic system calls do differ. Since the name would be define
and you would have to match it. It's harder to confuse a name than a
number. Of course they also differ with the fact that the dynamic system
calls don't need a device.

As for the stub generator (which does the above action), it still gives
the methodology of making the system call with a format to check that
the arguments match. Yes, you do have to use a macro to define your
system call (like any other system call), but once that is done, then
you have a way to check parameters before they are sent. It's not
perfect (what is) but still can be useful, and I'm arguing that it can
be a better interface than the ioctls.

-- Steve
