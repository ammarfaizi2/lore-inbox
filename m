Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUGGPxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUGGPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUGGPxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:53:16 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:49166 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S265027AbUGGPxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:53:11 -0400
Date: Wed, 7 Jul 2004 08:52:58 -0700
From: Elladan <elladan@eskimo.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'Elladan'" <elladan@eskimo.com>, "'Mike Galbraith'" <efault@gmx.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum) que stio n
Message-ID: <20040707155258.GA8270@eskimo.com>
References: <313680C9A886D511A06000204840E1CF08F42FD9@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FD9@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 05:48:17AM -0400, Povolotsky, Alexander wrote:
> Thanks again (and sorry for annoying yet again)!
> 
> >If an interrupt from some device, or the timer interrupt, causes a
> >high-priority process to become runnable 
> 
> I guess, you are referring above to what is also called "process wake-up" or
> "process awakening" ?
> What are the specific means of effecting "process wake-up" (say at the
> interrupt time) ?

If the high priority process was blocked waiting for something (eg.,
data from a device) and the interrupt causes data to be available on the
object the process is blocked on, then the high priority process will be
woken up and will then become runnable again.

> >All system calls execute schedule() before returning to user space, if
> >schedule has been requested.  It's done in the system call handler.  An
> >interrupt will also schedule if necessary.
> 
> Does above suggest that OS calls (with the schedule NOT being requested) are
> permissable to be executed from the ISR (Interrupt Service Routine)?
> ... - I have been told that anything, that invokes the scheduler is not
> callable from the ISR ...

The top half interrupt handler just basically puts the interrupt on a
list.  The bottom half handler then runs with a full context and can
schedule.

If the current process was already executing in the kernel, then the
bottom half is delayed until the end of the current call.  Otherwise, it
happens immediately afterward.

-J
