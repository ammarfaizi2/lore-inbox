Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSHHQNH>; Thu, 8 Aug 2002 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSHHQNH>; Thu, 8 Aug 2002 12:13:07 -0400
Received: from mnh-1-06.mv.com ([207.22.10.38]:48132 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317642AbSHHQNF>;
	Thu, 8 Aug 2002 12:13:05 -0400
Message-Id: <200208081719.MAA02461@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Thu, 08 Aug 2002 11:03:59 +0200."
             <20020808110359.1aa8f4a1.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Aug 2002 12:19:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> The task is uncooperative and doesn't dequeue signals itself. When it
> gets a signal it stops. The kernel then sees the signal and accepts it
> using sigwaitinfo, at which point it is no longer pending in the task
> either. The siginfo structure then provides the necessary info, i.e.
> which fd caused the i/o.

I think this is more or less what I had in mind.  The thing that is missing
is for sigwaitinfo to be able to dequeue another process' signals, which is
where the shared signal queue would come in.

> If you have a magic aio descriptor, how does the task process read
> signals from it and stop? 

I was looking at this as a way of dequeueing signals from the other process.
The task process would have the signal queued and wake up the kernel process
as happens now.  The kernel process would have /proc/<task-pid>/sigqueue
or something opened and would read siginfos from it.  Those would then be 
dequeued from the task process.

This almost suffices for getting page fault information, except that, for
some reason, siginfo doesn't say whether the faulting access was a read or
a write.

And now that I'm thinking about it, aio doesn't really come into it.  This
would be strictly synchronous.

				Jeff

