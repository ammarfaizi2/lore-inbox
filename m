Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUEJUWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUEJUWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUEJUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:22:39 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:4781 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261498AbUEJUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:22:34 -0400
Subject: Re: ptrace in 2.6.5
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m365b4kth8.fsf@averell.firstfloor.org>
References: <1UlcA-6lq-9@gated-at.bofh.it>
	 <m365b4kth8.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1084220684.1798.3.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 May 2004 17:24:44 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 15:49, Andi Kleen wrote:
> Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:
> 
> > Hi All.
> >
> >      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
> >     When tracing a sequence like
> >
> > 	mov ...
> > 	int 0x80
> > 	mov ....
> >
> >     ptrace would notify the tracer after the two movs, but not after the
> > int 0x80. I want to know if it is a bug or the expected behaviour.
> 
> What happens is that after the int 0x80 the CPU is in ring 0 (you
> don't get an trace event in that mode unless you use a kernel debugger). 
> Then when the kernel returns the last instruction executed before it is an 
> IRET. But the IRET is also executed still in ring 0 and you should not get 
> an event for it (you can not even access its code from user space).
> 
> So it's expected behaviour.
> 
> -Andi

I got it. But I need it to stop after the instruction. I am a newbie,
so is it trivial to patch the kernel so that it STOPS after the int
0x80? Can  you give me some light on it?

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

