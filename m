Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVCVE2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVCVE2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVCVE1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:27:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:40132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbVCVEVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:21:31 -0500
Date: Mon, 21 Mar 2005 20:20:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, cmorgan@alum.wpi.edu,
       paul@linuxaudiosystems.com, Jamie Lokier <jamie@shareable.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: kernel bug: futex_wait hang
Message-Id: <20050321202051.2796660e.akpm@osdl.org>
In-Reply-To: <1111463950.3058.20.camel@mindpipe>
References: <1111463950.3058.20.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Paul Davis and Chris Morgan have been chasing down a problem with
> xmms_jack and it really looks like this bug, thought to have been fixed
> in 2.6.10, is the culprit.
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.0/2044.html
> 
> (for more info google "futex_wait 2.6 hang")
> 
> It's simple to reproduce.  Run JACK and launch xmms with the JACK output
> plugin.  Close XMMS.  The xmms process hangs.  Strace looks like this:
> 
> rlrevell@krustophenia:~$ strace -p 7935
> Process 7935 attached - interrupt to quit
> futex(0xb5341bf8, FUTEX_WAIT, 7939, NULL
> 
> Just like in the above bug report, if xmms is run with
> LD_ASSUME_KERNEL=2.4.19, it works perfectly.
> 
> I have reproduced the bug with 2.6.12-rc1.
> 

iirc we ended up deciding that the futex problems around that time were due
to userspace problems (a version of libc).  But then, there's no discussion
around Seto's patch and it didn't get applied.  So I don't know what
happened to that work - it's all a bit mysterious.

Is this a 100% repeatable hang, or is it some occasional race?
