Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSGRPJt>; Thu, 18 Jul 2002 11:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSGRPId>; Thu, 18 Jul 2002 11:08:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17282 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318122AbSGRPI0>; Thu, 18 Jul 2002 11:08:26 -0400
Date: Thu, 18 Jul 2002 11:13:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Patrick J. LoPresti" <patl@curl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <s5gadop9jxq.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.3.95.1020718104807.19207A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Patrick J. LoPresti wrote:

> Pete Zaitcev <zaitcev@redhat.com> writes:
> 
> > The problem with errors from close() is that NOTHING SMART can be
> > done by the application when it receives it.
> 
> This is like saying "nothing smart" can be done when write() returns
> ENOSPC.  Such statements are either trivially true or blatantly false,
> depending on what you mean by "smart".
> 
> Failures happen.  They can happen on write(), they can happen on
> close(), and they can happen on any system call for which the API
> allows it.  There is no difference!  Your application either deals
> with them and is correct or fails to deal with them and is broken.
> 
> If the API allows an error return, you *must* check for it, period.
[SNIPPED..]

Well no. Many procedures are called for effect. When is the last
time you checked the return-value of printf() or puts()? If your
code does this it's wasting CPU cycles.

When it is necessary to perform code reviews, because your company
does FDA or some similar critical software, then you show that
you know you are ignoring a return value by casting it to void.
This shows that the writer knew that he or she was deliberately
ignoring a return-value.

In the specific close(fd) function, my reading of the man page
on this system says that it can only return an error of EBADF
on Linux. Which means that if you make Linux-only code, you
can ignore any error because the fd has become invalid somehow
and subsequent attempts to close with the same fd will surely
fail in the exact same way.

But most systems can return -1 and have an error code of EINTR
(interrupted system call) on any system call. Also, deferred
writing, such as happens in network file-systems, may not return
an error during the write. Such systems are supposed to return
an error during a later call that uses the same file descriptor.
If that call is a close(), then you may get an error. I don't
know what you do under those circumstances, but at the very least,
somebody/something should 'know' that the network write didn't
go as planned.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

