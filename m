Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbULCTYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbULCTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbULCTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:24:16 -0500
Received: from quark.didntduck.org ([69.55.226.66]:58313 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261800AbULCTYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:24:12 -0500
Message-ID: <41B0BD6B.2010809@didntduck.org>
Date: Fri, 03 Dec 2004 14:24:27 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain <autofr@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: distinguish kernel thread / user task
References: <64b1faec041203091654251b18@mail.gmail.com>
In-Reply-To: <64b1faec041203091654251b18@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sylvain wrote:
> Hi all,
> 
> I have little question while doing some kernel implementation.
> How can I distinguish whether a task_struct is actually kernel thread
> or mere user task?
> 
> My idea was to look at task_struct "mm" field to discriminate them,
> but that was wrong...
> 
> Thanks,
> 
> Sylvain

To the scheduler, a thread is a thread.  It doesn't care if it's a 
kernel thread or not.  The difference is execution context, which is 
cpu-dependant.  For example, on x86 the difference is in the code 
segment the task runs in.  Kernel threads run in KERNEL_CS (ring 0), and 
user threads run USER_CS (or any other ring 3 code segment, or vm86 mode 
set in eflags).  Other cpus might have a flag in the status register.

What are you trying to do that you need to know whether a thread is 
kernel or user?  I suppose if there were a compelling enough reason, a 
kernel/user flag could be added to the task struct, set in do_fork() for 
kernel threads, and cleared by execve().

--
				Brian Gerst
