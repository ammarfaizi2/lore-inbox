Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbULCUQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbULCUQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbULCUQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:16:14 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:9894 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262496AbULCUPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:15:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IckbsB4W4RExwfmWcMEfFhPEP9JwRLtLQt8GAQ2+ynQaRqnHGUFZldcxUe4cMCXoDddBdwpYskJG0CIsp4mMlHOgE4QCLkGW0Y1UgcYNVu+x6BVYL01lbztjukZrTvqQPTa8G82IzgugSAvvTlXGKSQIgb17/yj2Q3DHVI0HQco=
Message-ID: <64b1faec0412031215b934a9@mail.gmail.com>
Date: Fri, 3 Dec 2004 21:15:36 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: distinguish kernel thread / user task
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41B0BD6B.2010809@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <64b1faec041203091654251b18@mail.gmail.com>
	 <41B0BD6B.2010809@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to do a tool to record task switching...separating also
kernel/user tasks, but I got some trouble with that last case.

I confused since "ps" is actually able to distinguish kernel thread
from user task.
I wouldn't had a flag if It 's not necessary

Sylvain


On Fri, 03 Dec 2004 14:24:27 -0500, Brian Gerst <bgerst@didntduck.org> wrote:
> Sylvain wrote:
> 
> 
> > Hi all,
> >
> > I have little question while doing some kernel implementation.
> > How can I distinguish whether a task_struct is actually kernel thread
> > or mere user task?
> >
> > My idea was to look at task_struct "mm" field to discriminate them,
> > but that was wrong...
> >
> > Thanks,
> >
> > Sylvain
> 
> To the scheduler, a thread is a thread.  It doesn't care if it's a
> kernel thread or not.  The difference is execution context, which is
> cpu-dependant.  For example, on x86 the difference is in the code
> segment the task runs in.  Kernel threads run in KERNEL_CS (ring 0), and
> user threads run USER_CS (or any other ring 3 code segment, or vm86 mode
> set in eflags).  Other cpus might have a flag in the status register.
> 
> What are you trying to do that you need to know whether a thread is
> kernel or user?  I suppose if there were a compelling enough reason, a
> kernel/user flag could be added to the task struct, set in do_fork() for
> kernel threads, and cleared by execve().
> 
> --
>                                Brian Gerst
>
