Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263862AbRFRJHz>; Mon, 18 Jun 2001 05:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263859AbRFRJHp>; Mon, 18 Jun 2001 05:07:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48377 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S263851AbRFRJHb>; Mon, 18 Jun 2001 05:07:31 -0400
Message-ID: <3B2DC48B.392795A7@mvista.com>
Date: Mon, 18 Jun 2001 02:06:19 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "SATHISH.J" <sathish.j@tatainfotech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reg:current a pointer to task_struct
In-Reply-To: <Pine.LNX.4.10.10106181403400.9461-100000@blrmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"SATHISH.J" wrote:
> 
> Hi,
> 
> Please help me with the following:
> 
> I tried to go through get_current function which is in assembly.
> 
> static inline struct task_struct * get_current(void) {
>         struct task_struct *current;
>         __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
>         return current;
>  }
> 
> Please tell me what is done here. Does current refer to process onproc.

Actually the code returns the stack pointer (esp) anded with ~8191
(FFFE000).

The trick is that kernel task structures are allocated at the low end of
the kernel stack for each task.  The stack is a the high end of the
address range and works down.  (Kernel stack overflow will "eat" the
task structure.)

current is (struct tast_struct *) and points to the task_struc for the
current task (how could it be otherwise, given that it comes from the
tasks stack pointer).

George
