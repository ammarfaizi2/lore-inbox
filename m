Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRLAAX3>; Fri, 30 Nov 2001 19:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281234AbRLAAXU>; Fri, 30 Nov 2001 19:23:20 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:39430 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281228AbRLAAXL>; Fri, 30 Nov 2001 19:23:11 -0500
Date: Fri, 30 Nov 2001 16:33:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <E169xWr-0005EM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0111301614000.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Alan Cox wrote:

> > So You like the idea of stocking structure pointers inside CPU registers
> > or I missed Your point ?
> > The proposed implementation is "uniform" between architectures, that's my
> > point.
>
> An uniform implementation for a totally non uniform set of processors. Not
> actually useful. The x86 is one of the few cpus so short of registers that
> current in a global register is not a win performancewise.

The point is why store kernel pointers in global registers when You can
achieve the same functionality, with a smaller patch, that does not need
to be recoded for each CPU, without using global registers.



> The cache behaviour also heavily depends on the processor. In paticular the
> problem with having to align stacks to do current tricks is absent on non
> x86 processors so they can use properly coloured stacks.
>
> current is far too critical to generalise

This is the diff for current :

 static inline struct task_struct * get_current(void)
 {
-       struct task_struct *current;
-       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-       return current;
+       unsigned long *tskptr;
+       __asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
+       return (struct task_struct *) *tskptr;
 }




- Davide



