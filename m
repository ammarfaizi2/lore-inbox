Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULFWC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULFWC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULFWC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:02:56 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:28860 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261672AbULFWCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:02:02 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cp2i3h$hs0$1@terminus.zytor.com>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <cp2i3h$hs0$1@terminus.zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 06 Dec 2004 17:01:57 -0500
Message-Id: <1102370517.25841.216.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 21:14 +0000, H. Peter Anvin wrote:
> Because we already have a name resolution mechanism in the kernel,
> called the filesystem?  We also have a mechanism for ad hoc system
> calls, it's called ioctl().
> 
> And before you go "but ioctl() sucks": dynamic syscalls suck for
> *exactly* the same reasons.
> 

I disagree about this statement.  ioctl's suck because they usually have
none, or very poor documentation and you are stuck with opening devices,
and sending parameters to them that may be for the wrong device and
there is really no good checking to see what you sent is what you want
since its all defined by human unreadable numbers.

As for dynamic system calls (and especially the way I've implemented
them) you have human readable names, with varying amount of parameters
that can make sense. So even if you still have none to very poor
documentation, you can understand things perhaps a little better.  There
is also much better checking in dynamic system calls than to ioctls.

So instead of 

struct mydev_struct myparams;

fd = open("/dev/mydev",O_RDWR);

myparams.arg1 = arg1;
myparams.arg2 = arg2;
... etc ...

ioctl(fd,IO_HOPE_THIS_IS_RIGHT_IOCTL_NUMBER,&myparams);


you now have

mydev_syscall(arg1,arg2,arg3,...);


But you do give me a idea on how to implement dynamic system calls with
the ioctl approach, and this can be added for anyone that wants dynamic
system calls. But I like my original patch better, since the ioctl way
would really be a nasty hack.

-- Steve

